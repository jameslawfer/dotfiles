#!/usr/bin/env bash
# Depends on bluetoothctl

declare  vpn_status

if [[ -e /proc/sys/net/ipv4/conf/nordtun ]] ; then
    vpn_status="OpenVPN"
elif [[ -e /proc/sys/net/ipv4/conf/nordlynx ]] ; then
    vpn_status="NordLynx"
else
    vpn_status="Disconnected"
fi

echo $vpn_status
