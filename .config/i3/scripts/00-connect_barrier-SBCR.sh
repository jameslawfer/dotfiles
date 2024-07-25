#!/usr/bin/env bash

# Dependancies: networkd-dispatcher, barrier
# AUR: https://aur.archlinux.org/packages/networkd-dispatcher/
# Gitlab: https://gitlab.com/craftyguy/networkd-dispatcher/-/tree/master
#
# To be copied to /etc/networkd-dispatcher/carrier.d
# To be copied to /etc/networkd-dispatcher/routable.d
# To be copied to /etc/networkd-dispatcher/no-carrier.d
# with gid=uid=0 (owned by root) and executable
# Ensure to start and enable the systemd service with 'sudo systemctl enable --now networkd-dispatcher'

if [[ "$(iwctl station wlan0 show | sed -n 's/^\s*Connected\snetwork\s*\(\S*\)\s*$/\1/p')" == "SandyButtCheeksResidence" ]]; then
    while ! ping -c 1 -n -w 1 10.8.99.21 &> /dev/null; do
        :
    done
    if [[ -n "$(pgrep barrierc)" ]]; then
        :
    else
        sleep 3 # this is really gross, find a better solution. Used to wait for some service after reboot. Only required at initial login
        su - james -c "barrierc --restart --daemon 10.8.99.21"
    fi
else
    pkill barrier
fi
