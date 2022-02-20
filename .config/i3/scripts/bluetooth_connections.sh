#!/usr/bin/env bash
# Depends on bluetoothctl

# modified one-liner from https://superuser.com/questions/1500383/bluetoothctl-list-connected-devices

bluetoothctl devices | cut -f2 -d' ' | while read uuid; do
    if [[ $(bluetoothctl info $uuid | sed -rn 's/^\s*Connected:\s(.*)/\1/p') == "yes" ]]; then
        echo "$(bluetoothctl info $uuid | sed -rn 's/^\s*Alias:\s(.*)/\1/p')"
    fi
done
