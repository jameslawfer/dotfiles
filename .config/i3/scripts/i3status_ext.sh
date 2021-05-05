#!/usr/bin/env bash
# Depends on jq

COUNTER=0
i3status -c ~/.config/i3status/config | while :
do
  read line
  KBD=$(~/.config/i3/scripts/keyboard_layout.sh)
  KBDTEXT=" $KBD"
  if [ "$line" == '{"version":1}' ] || [ "$line" == "[" ] ; then
    echo "$line" || exit 1
  elif [[ "$COUNTER" -eq 0 ]] ; then
    COUNTER=$((COUNTER+1))
    echo $line | sed 's/^,//' | jq --compact-output --raw-output --arg KBDSTATUS "$KBDTEXT" '.[0:length-2] +[{"name":"keyboard","instance":"unknown","markup":"none","full_text":$KBDSTATUS}] + .[length-2:length]' || exit 1
  else
    echo $line | sed 's/^,//' | jq --compact-output --raw-output --arg KBDSTATUS "$KBDTEXT" '.[0:length-2] +[{"name":"keyboard","instance":"unknown","color":"#00FFFB","markup":"none","full_text":$KBDSTATUS}] + .[length-2:length]' | sed 's/^/,/' || exit 1
  fi
done
