#!/usr/bin/env bash
# Depends on jq
# Glyphs from https://www.nerdfonts.com/cheat-sheet

COUNTER=0
i3status -c ~/.config/i3status/config | while :
do
  read line
  KBD=$(~/.config/i3/scripts/keyboard_layout.sh)
  KBDTEXT=" $KBD"
  KBDCOLOUR="#FFFFFF"

  BT="$(~/.config/i3/scripts/bluetooth_connections.sh)"
  BTTEXT=" $BT"
  BTCOLOUR="#00EEFF"

  VPN="$(~/.config/i3/scripts/vpn_connections.sh)"
  VPNTEXT=" $VPN"
  VPNCOLOUR="#FF0000"

  if [ -z "$BT" ] ; then
      BTTEXT=""
  fi

  if [ $KBD != 'US' ] ; then
    KBDCOLOUR="#00FFFB"
  fi

  if [ $VPN != 'Disconnected' ] ; then
      VPNCOLOUR="#00FF00"
  fi

  if [ "$line" == '{"version":1}' ] || [ "$line" == "[" ] ; then
    echo "$line" || exit 1
  elif [[ "$COUNTER" -eq 0 ]] ; then
    COUNTER=$((COUNTER+1))
    echo $line | sed 's/^,//' | jq --compact-output --raw-output --arg BTTEXT "$BTTEXT" --arg BTCOLOUR "$BTCOLOUR" --arg KBDTEXT "$KBDTEXT" --arg KBDCOLOUR "$KBDCOLOUR" --arg VPNTEXT "$VPNTEXT" --arg VPNCOLOUR "$VPNCOLOUR" '[{"name":"vpn","instance":"unknown","color":$VPNCOLOUR,"markup":"none","full_text":$VPNTEXT}] + .[0:length-7] + [{"name":"bluetooth","instance":"unknown","color":$BTCOLOUR,"markup":"none","full_text":$BTTEXT}] + .[length-7:length-2] + [{"name":"keyboard","instance":"unknown","color":$KBDCOLOUR,"markup":"none","full_text":$KBDTEXT}] + .[length-2:length]' || exit 1
  else
    echo $line | sed 's/^,//' | jq --compact-output --raw-output --arg BTTEXT "$BTTEXT" --arg BTCOLOUR "$BTCOLOUR" --arg KBDTEXT "$KBDTEXT" --arg KBDCOLOUR "$KBDCOLOUR" --arg VPNTEXT "$VPNTEXT" --arg VPNCOLOUR "$VPNCOLOUR" '[{"name":"vpn","instance":"unknown","color":$VPNCOLOUR,"markup":"none","full_text":$VPNTEXT}] + .[0:length-7] + [{"name":"bluetooth","instance":"unknown","color":$BTCOLOUR,"markup":"none","full_text":$BTTEXT}] + .[length-7:length-2] + [{"name":"keyboard","instance":"unknown","color":$KBDCOLOUR,"markup":"none","full_text":$KBDTEXT}] + .[length-2:length]' | sed 's/^/,/' || exit 1
  fi
done
