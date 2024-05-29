#!/bin/bash
ip route ls | grep rmnet | grep 'default via' >/dev/null
if (( $? != 0 ))
then
    provider=$(nmcli c | grep gsm | awk '{ print $1 }')
	nmcli c down $provider
	sleep 1
	nmcli c up $provider
fi
