#!/usr/bin/env bash

echo "reload_hid_apple.sh called" | systemd-cat -t reload_hid_apple -p info

SUCCESS_STRING="hid_apple module reloaded successfully."

# --no-pager required to prevent journalctl opening an interactive log viewer
if journalctl -b --no-pager | grep -q "$SUCCESS_STRING"; then
    echo "hid_apple module has already been reloaded." | systemd-cat -t reload_hid_apple -p warning # the script was run successfully this boot, so don't run it again
else # otherwise attempt to reload the hid_apple kernel module
    if /usr/bin/rmmod hid_apple; then
        echo "hid_apple module unloaded successfully." | systemd-cat -t reload_hid_apple -p info
        if /usr/bin/modprobe hid_apple; then
            echo "$SUCCESS_STRING" | systemd-cat -t reload_hid_apple -p info
        else
            echo "hid_apple module could not be reloaded." | systemd-cat -t reload_hid_apple -p err
            exit 1
        fi
    else
        echo "hid_apple module could not be unloaded." | systemd-cat -t reload_hid_apple -p err
    fi
fi
