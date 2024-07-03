#!/bin/sh
# Set something else than 100% volume
pactl set-sink-volume 0 90%
# Camera does not work after a reboot, like if camera ids are changing
sed -i '/camera.*/d' ~/.config/Droidian/droidian-camera.conf
