#!/bin/bash
grep 'WWANEnabled=true' /var/lib/NetworkManager/NetworkManager.state >/dev/null || exit 0
ip route ls | grep rmnet | grep 'default via' >/dev/null
if (( $? != 0 ))
then
    provider="$(nmcli c show | grep gsm | grep -oE '[a-z0-9]*-[a-z0-9]*-[a-z0-9]*-[a-z0-9]*-[a-z0-9]*')"
    LANG=C nmcli connection show "$provider" | grep connection.autoconnect: | grep yes >/dev/null || exit 0
    nmcli c down "$provider"
    sleep 1
    nmcli c up "$provider"
fi
