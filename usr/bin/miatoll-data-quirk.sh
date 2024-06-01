#!/bin/bash
grep 'WWANEnabled=true' /var/lib/NetworkManager/NetworkManager.state >/dev/null || exit 0
ip route ls | grep rmnet | grep 'default via' >/dev/null
if (( $? != 0 ))
then
    provider=$(nmcli c | grep gsm | awk '{ print $1 }')
    LANG=C nmcli connection show Orange | grep connection.autoconnect: | grep yes >/dev/null || exit 0
    nmcli c down $provider
    sleep 1
    nmcli c up $provider
fi
