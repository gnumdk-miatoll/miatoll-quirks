#!/bin/bash
ping -c1 8.8.8.8 -W 5 >/dev/null 2>&1
if (( $? != 0 ))
then
    provider=$(nmcli c | grep gsm | awk '{ print $1 }')
	nmcli c down $provider
	sleep 1
	nmcli c up $provider
fi
