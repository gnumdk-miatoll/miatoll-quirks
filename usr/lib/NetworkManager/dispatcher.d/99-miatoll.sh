#!/bin/sh
DEVICE=$1
STATUS=$2
exit 0
[ "$DEVICE" != "/ril_0" ] && exit 0
[ "$STATUS" != "down" ] && exit 0
if grep "WWANEnabled=true" /var/lib/NetworkManager/NetworkManager.state >/dev/null
then
    enabled=$(nmcli r wwan)
    [ "$enabled" = "enabled" ] && nmcli d connect $DEVICE
fi
