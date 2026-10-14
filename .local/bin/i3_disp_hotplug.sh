#!/usr/bin/env bash

export DISPLAY=$(strings "/proc/$(pidof Xorg)/environ" | grep "^DISPLAY=" | cut -d= -f2-)
export XAUTHORITY=$(strings "/proc/$(pidof Xorg)/environ" | grep "^XAUTHORITY=" | cut -d= -f2-)
export HOME="/home/$(loginctl list-sessions --no-legend | awk '{ print $3 }' | head -n 1)"
export PATH=/usr/local/bin:/usr/bin:/bin # ensure a standard PATH is available.

echo "i3_disp_hotplug.sh called (XAUTHORITY=$XAUTHORITY | DISPLAY=$DISPLAY | HOME=$HOME)" | systemd-cat -t i3_disp_hotplug -p info

PRIMARY_DISPLAY=$(xrandr | grep " primary " | awk '{ print $1 }') # assumes a display must always be primary? Not sure if this is true. If it isn't will need to change subsequent logic
if [ -z "$PRIMARY_DISPLAY" ]; then # set a fallback I guess for a primary display
    PRIMARY_DISPLAY=$(xrandr | grep " connected " | head -n 1 | awk '{ print $1 }')
fi

# fill DISPLAYS array with connected display name strings
DISPLAYS=()
while read -r line; do
    if [[ $line != $PRIMARY_DISPLAY ]]; then
        DISPLAYS+=("$line")
    fi
done < <(xrandr | grep " connected " | awk '{ print $1 }')

# fill DISCONNECTED_DISPLAYS array with connected display name strings
DISCONNECTED_DISPLAYS=()
while read -r line; do
    DISCONNECTED_DISPLAYS+=("$line")
done < <(xrandr | grep " disconnected " | awk '{ print $1 }')

DISPLAY_COUNT=$((${#DISPLAYS[@]} + 1))
DISCONNECTED_DISPLAY_COUNT=${#DISCONNECTED_DISPLAYS[@]}

echo "Number of displays is: $DISPLAY_COUNT, Number of disconnected displays is: $DISCONNECTED_DISPLAY_COUNT, Primary Display is: $PRIMARY_DISPLAY" | systemd-cat -t i3_disp_hotplug -p info

XRANDR_ARGS=("--display" "$DISPLAY" "--output" "$PRIMARY_DISPLAY" "--auto")

if [ $DISPLAY_COUNT -gt 1 ]; then
    # more than one display handling
    for DISP in "${DISPLAYS[@]}"; do
        XRANDR_ARGS+=("--output" "$DISP" "--auto" "--right-of" "$PRIMARY_DISPLAY")
    done
fi

for DISP in "${DISCONNECTED_DISPLAYS[@]}"; do
    XRANDR_ARGS+=("--output" "$DISP" "--off")
done

echo "Running xrandr with args: ${XRANDR_ARGS[*]}" | systemd-cat -t i3_disp_hotplug -p info

# Set the display configuration (finally.. this took far too long to get right)
xrandr "${XRANDR_ARGS[@]}"

# Set wallpaper on all monitors with feh
feh --bg-fill /home/james/Pictures/Wallpapers/WP.jpg
