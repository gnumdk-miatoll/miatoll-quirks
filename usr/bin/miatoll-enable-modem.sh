#!/bin/sh
/usr/bin/gdbus wait -y org.ofono

if grep "WWANEnabled=true" /var/lib/NetworkManager/NetworkManager.state >/dev/null
then
	/usr/share/ofono/scripts/online-modem
fi
