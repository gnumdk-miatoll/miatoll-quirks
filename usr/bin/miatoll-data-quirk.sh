#!/bin/bash
ping -c1 8.8.8.8 -W 5 >/dev/null 2>&1
if (( $? != 0 ))
then
	nmcli c down Orange
	sleep 1
	nmcli c up Orange
fi
