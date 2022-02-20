#!/usr/bin/env bash
# Requires pgrep

LOGSEQPS=$(pgrep Logseq)

# Check if Logseq is running by confirming if pgrep returns any processes under the name Logseq
if [ -z "$LOGSEQPS" ]
then
    echo "Logseq is not running"
    echo "Launching Logseq"
    # Launch Logseq (should be started in the active workspace)
    logseq
else
    echo "Logseq is running"
    # Check what the active workspace is
    # Check which workspace Logseq is running in
    # If there is a discrepancy between the two, move Logseq window to the active workspace
fi

#COUNTER=0
#i3status -c ~/.config/i3status/config | while :
#do
#  read line
#  KBD=$(~/.config/i3/scripts/keyboard_layout.sh)
#  KBDTEXT=" $KBD"
#  KBDCOLOUR="#FFFFFF"
#
#  if [ $KBD != 'US' ] ; then
#    KBDCOLOUR="#00FFFB"
#  fi
#
#  if [ "$line" == '{"version":1}' ] || [ "$line" == "[" ] ; then
#    echo "$line" || exit 1
#  elif [[ "$COUNTER" -eq 0 ]] ; then
#    COUNTER=$((COUNTER+1))
#    echo $line | sed 's/^,//' | jq --compact-output --raw-output --arg KBDTEXT "$KBDTEXT" --arg KBDCOLOUR "$KBDCOLOUR" '.[0:length-2] +[{"name":"keyboard","instance":"unknown","color":$KBDCOLOUR,"markup":"none","full_text":$KBDTEXT}] + .[length-2:length]' || exit 1
#  else
#    echo $line | sed 's/^,//' | jq --compact-output --raw-output --arg KBDTEXT "$KBDTEXT" --arg KBDCOLOUR "$KBDCOLOUR" '.[0:length-2] +[{"name":"keyboard","instance":"unknown","color":$KBDCOLOUR,"markup":"none","full_text":$KBDTEXT}] + .[length-2:length]' | sed 's/^/,/' || exit 1
#  fi
#done
