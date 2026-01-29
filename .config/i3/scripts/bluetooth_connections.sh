#!/usr/bin/env bash
# Depends on bluetoothctl, systemctl

# modified one-liner from https://superuser.com/questions/1500383/bluetoothctl-list-connected-devices

declare -a bt_names
COUNTER=0

if [[ $(systemctl status bluetooth.service | sed -rn 's/^\s*Active:\s(\w+)\s*(.*)/\1/p') == 'active' ]]; then
    while read uuid; do
        if [[ $(bluetoothctl info $uuid | sed -rn 's/^\s*Connected:\s(.*)/\1/p') == "yes" ]]; then
            if [[ ! $COUNTER -eq 0 ]] ; then
                bt_names+=", "
            fi
            COUNTER=$((COUNTER+1))
            bt_names+="$(bluetoothctl info $uuid | sed -rn 's/^\s*Alias:\s(.*)/\1/p')"
        fi
    done < <(bluetoothctl devices | cut -f2 -d' ')
elif [[ $(systemctl status bluetooth.service | sed -rn 's/^\s*Active:\s(\w+)\s*(.*)/\1/p') == 'inactive' ]]; then
    bt_names+="-Disabled-"
else
    bt_names+="!ERROR. See bluetooth_connections.sh script!"
fi

echo $bt_names
