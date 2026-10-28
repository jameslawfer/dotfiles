#!/usr/bin/env bash

# This script will attempt to firstly reconfigure a custom keyboard layout as keyboard hotplugging resets layouts
# It wil then reload the hid_apple_dkms kernel module if necessary (only needs to be done once at boot)

echo "reload_magic_keyboard.sh called" | systemd-cat -t reload_magic_keyboard -p info

SUCCESS_STRING="hid_apple module reloaded successfully."

# Try the keyboard layout setting
setxkbmap -layout us-g,es -variant , -option custom:types
if [[ "$(setxkbmap -query | grep -iE '^\s*layout' | awk '{ print $2}')" =~ "us-g" ]]; then
    echo "keyboard map reset to include custom US(Grave) config" | systemd-cat -t reload_magic_keyboard -p info
else
    echo "keyboard map could not be reloaded" | systemd-cat -t reload_magic_keyboard -p err
fi

# Now deal with the kernel module
# --no-pager required to prevent journalctl opening an interactive log viewer
if journalctl -b --no-pager | grep -q "$SUCCESS_STRING"; then
    echo "hid_apple module has already been reloaded." | systemd-cat -t reload_magic_keyboard -p warning # the script was run successfully this boot, so don't run it again
else # otherwise attempt to reload the hid_apple kernel module
    if /usr/bin/rmmod hid_apple; then
        echo "hid_apple module unloaded successfully." | systemd-cat -t reload_magic_keyboard -p info
        if /usr/bin/modprobe hid_apple; then
            echo "$SUCCESS_STRING" | systemd-cat -t reload_magic_keyboard -p info
        else
            echo "hid_apple module could not be reloaded." | systemd-cat -t reload_magic_keyboard -p err
            exit 1
        fi
    else
        echo "hid_apple module could not be unloaded." | systemd-cat -t reload_magic_keyboard -p err
    fi
fi
