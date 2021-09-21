#!/usr/bin/env bash
# Dependency networkd-dispatcher
# AUR: https://aur.archlinux.org/packages/networkd-dispatcher/
# Gitlab: https://gitlab.com/craftyguy/networkd-dispatcher/-/tree/master
# To be copied to /etc/networkd-dispatcher/carrier.d
# To be copied to /etc/networkd-dispatcher/routable.d
# To be copied to /etc/networkd-dispatcher/no-carrier.d
# with gid=uid=0 (owned by root) and executable
# Ensure to start and enable the systemd service with 'sudo systemctl enable --now networkd-dispatcher'

killall -SIGUSR1 i3status
