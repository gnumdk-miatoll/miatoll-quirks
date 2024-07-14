#!/bin/bash
IPS=(8.8.8.8 1.1.1.1 9.9.9.9 208.67.222.222 208.67.220.220 208.67.222.220 208.67.220.222 208.67.222.123 208.67.220.123)
IP=${IPS[ $RANDOM % ${#IPS[@]} ]}

grep 'WWANEnabled=true' /var/lib/NetworkManager/NetworkManager.state >/dev/null || exit 0
if ! ping -I rmnet_data1 -c1 $IP -W 5 >/dev/null
then
    provider="$(nmcli c show | grep gsm | grep -oE '[a-z0-9]*-[a-z0-9]*-[a-z0-9]*-[a-z0-9]*-[a-z0-9]*')"
    LANG=C nmcli connection show "$provider" | grep connection.autoconnect: | grep yes >/dev/null || exit 0
    nmcli c down "$provider"
    sleep 1
    nmcli c up "$provider"
fi
