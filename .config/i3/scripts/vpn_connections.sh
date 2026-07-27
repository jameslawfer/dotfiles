#!/usr/bin/env bash
# Depends on bluetoothctl

declare  vpn_status

if [[ -e /proc/sys/net/ipv4/conf/nordtun ]] ; then
    vpn_status="OpenVPN"
elif [[ -e /proc/sys/net/ipv4/conf/nordlynx ]] ; then
    vpn_status="NordLynx"
elif [[ $(ip addr show wg0 | sed -rn 's/.*,(UP),.*/\1/p') == 'UP' ]] ; then
    if [[ $(ping -c 1 -W 1 1.1.1.1 | sed -rn 's/^.*([0-9])\sreceived.*/\1/p') == '1' ]] ; then
        vpn_status="WireGuard"
    elif [[ $(ping -c 1 -W 1 1.1.1.1 | sed -rn 's/^.*([0-9])\sreceived.*/\1/p') == '0' ]] ; then
        vpn_status="WireGuard (Connecting)"
    fi
elif [[ $(ip addr show pangolin | sed -rn 's/.*,(UP),.*/\1/p') == 'UP' ]] ; then
    if [[ $(ping -c 1 -W 1 1.1.1.1 | sed -rn 's/^.*([0-9])\sreceived.*/\1/p') == '1' ]] ; then
        vpn_status="Pangolin"
    elif [[ $(ping -c 1 -W 1 1.1.1.1 | sed -rn 's/^.*([0-9])\sreceived.*/\1/p') == '0' ]] ; then
        vpn_status="Pangolin (Connecting)"
    fi
else
    vpn_status="Disconnected"
fi

echo $vpn_status
