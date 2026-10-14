#!/usr/bin/env bash

export DISPLAY=$(strings "/proc/$(pidof Xorg)/environ" | grep "^DISPLAY=" | cut -d= -f2-)
export XAUTHORITY=$(strings "/proc/$(pidof Xorg)/environ" | grep "^XAUTHORITY=" | cut -d= -f2-)
export HOME="/home/$(loginctl list-sessions --no-legend | awk '{ print $3 }' | head -n 1)"

echo "i3_disp_hotplug.sh called (XAUTHORITY=$XAUTHORITY | DISPLAY=$DISPLAY | HOME=$HOME)" | systemd-cat -t i3_disp_hotplug -p info

PRIMARY_DISPLAY=$(xrandr | grep " primary " | awk '{ print $1 }') # assumes a display must always be primary? Not sure if this is true. If it isn't will need to change subsequent logic

# fill DISPLAYS array with connected display name strings
while read -r line; do
    if [[ $line != $PRIMARY_DISPLAY ]]; then
        DISPLAYS+=("$line")
    fi
done < <(xrandr | grep " connected " | awk '{ print $1 }')

# fill DISCONNECTED_DISPLAYS array with connected display name strings
while read -r line; do
    DISCONNECTED_DISPLAYS+=("$line")
done < <(xrandr | grep " disconnected " | awk '{ print $1 }')

DISPLAY_COUNT=$((${#DISPLAYS[@]} + 1))
DISCONNECTED_DISPLAY_COUNT=${#DISCONNECTED_DISPLAYS[@]}

echo "Number of displays is: $DISPLAY_COUNT, Number of disconnected displays is: $DISCONNECTED_DISPLAY_COUNT, Primary Display is: $PRIMARY_DISPLAY" | systemd-cat -t i3_disp_hotplug -p info

CMD_STRING="xrandr "
if [ $DISPLAY_COUNT -gt 1 ]; then
    # more than one display handling
    CMD_STRING+="--output $PRIMARY_DISPLAY --auto "
    for DISPLAY in "${DISPLAYS[@]}"; do
        CMD_STRING+="--output $DISPLAY --auto --right-of $PRIMARY_DISPLAY "
    done
else
    # only a single primary display
    CMD_STRING+="--output $PRIMARY_DISPLAY --auto "
fi
for DISPLAY in "${DISCONNECTED_DISPLAYS[@]}"; do
    CMD_STRING+="--output $DISPLAY --off "
done
CMD_STRING=$(echo "$CMD_STRING" | sed 's/[[:space:]]*$//') # trim trailing whitespace
echo "Running command: $CMD_STRING" | systemd-cat -t i3_disp_hotplug -p info
eval "$CMD_STRING"

# Set wallpaper on all monitors with feh
#feh --bg-fill /home/james/Pictures/Wallpapers/WP.jpg
