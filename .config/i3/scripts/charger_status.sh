#!/usr/bin/env bash

PSTAT=$(sed '/^POWER_SUPPLY_STATUS/!d;s/.*=//' /sys/class/power_supply/BAT0/uevent | tr 'a-z' 'A-Z')

if [ "$PSTAT" == 'CHARGING' ]; then
    echo "AC_CHARG" || exit 1
  elif [ "$PSTAT" == 'NOT CHARGING' ]; then
    echo "AC_NOCHR" || exit 1
  else
    echo "BAT_DCHR" || exit 1
  fi
