#!/usr/bin/env bash
# To be copied to /etc/networkd-dispatcher/routable.d
# with gid=uid=0 (owned by root) and executable

echo "ESSID: $ESSID | IFACE: $IFACE"

if [[ $ESSID == "SandyButtCheeksResidence" ]] && [[ $IFACE == "wlan0" ]]; then
    for i in /home/james/CATNAS/*/; do
        echo "Mounting: $i"
        mount -v $i
        mount_ret="$?"
        if [[ $mount_ret -ne 0 ]]; then
            echo "error mounting code $mount_ret"
            sudo -u james DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus notify-send -u low -a mount "Error $mount_ret mounting $i"
        fi
    done
fi
