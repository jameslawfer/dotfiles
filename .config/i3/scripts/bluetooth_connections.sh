#!/usr/bin/env bash
# Depends on bluetoothctl

# modified one-liner from https://superuser.com/questions/1500383/bluetoothctl-list-connected-devices

declare -a bt_names
COUNTER=0

while read uuid; do
    if [[ $(bluetoothctl info $uuid | sed -rn 's/^\s*Connected:\s(.*)/\1/p') == "yes" ]]; then
        if [[ ! $COUNTER -eq 0 ]] ; then
            bt_names+=", "
        fi
        COUNTER=$((COUNTER+1))
        bt_names+="$(bluetoothctl info $uuid | sed -rn 's/^\s*Alias:\s(.*)/\1/p')"
    fi
done < <(bluetoothctl devices | cut -f2 -d' ')

echo $bt_names
