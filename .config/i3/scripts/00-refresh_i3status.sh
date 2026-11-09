#!/usr/bin/env bash
# Dependency networkd-dispatcher
# AUR: https://aur.archlinux.org/packages/networkd-dispatcher/
# Gitlab: https://gitlab.com/craftyguy/networkd-dispatcher/-/tree/master
# To be symlinked into /etc/networkd-dispatcher/{carrier.d,routable.d,no-carrier.d,off.d}
# N.b. networkd-dispatcher.service expects this file to be mode=0o755, uid=0, gid=0;
# Ensure to start and enable the systemd service with 'sudo systemctl enable --now networkd-dispatcher'

killall -SIGUSR1 i3status
