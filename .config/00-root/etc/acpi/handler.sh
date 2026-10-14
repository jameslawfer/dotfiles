#!/usr/bin/env bash
# Default acpi script that takes an entry for all actions

export DISPLAY=$(strings "/proc/$(pidof Xorg)/environ" | grep "^DISPLAY=" | cut -d= -f2-)
export XAUTHORITY=$(strings "/proc/$(pidof Xorg)/environ" | grep "^XAUTHORITY=" | cut -d= -f2-)

case "$1" in
    button/power)
        case "$2" in
            PBTN|PWRF)
                logger 'PowerButton pressed'
                ;;
            *)
                logger "ACPI action undefined: $2"
                ;;
        esac
        ;;
    button/sleep)
        case "$2" in
            SLPB|SBTN)
                logger 'SleepButton pressed'
                ;;
            *)
                logger "ACPI action undefined: $2"
                ;;
        esac
        ;;
    ac_adapter)
        case "$2" in
            AC|ACAD|ADP0)
                case "$4" in
                    00000000)
                        logger 'AC unpluged'
                        ;;
                    00000001)
                        logger 'AC pluged'
                        ;;
                esac
                ;;
            *)
                logger "ACPI action undefined: $2"
                ;;
        esac
        ;;
    battery)
        case "$2" in
            BAT0)
                case "$4" in
                    00000000)
                        logger 'Battery online'
                        ;;
                    00000001)
                        logger 'Battery offline'
                        ;;
                esac
                ;;
            CPU0)
                ;;
            *)  logger "ACPI action undefined: $2" ;;
        esac
        ;;
    button/lid)
        case "$3" in
            close)
                logger 'LID closed'
                ;;
            open)
                logger 'LID opened'
                ;;
            *)
                logger "ACPI action undefined: $3"
                ;;
    esac
    ;;
    video/tabletmode)
        case "$2" in
            TBLT)
                case "$4" in
                    00000000)
                        logger '2-in-1 screen in Laptop mode'
                        xrandr --output eDP-1 --rotate normal
                        xinput set-prop 10 310 1 0 0 0 1 0 0 0 1
                        kill $(pgrep -f iio-sensor-proxy_rotate.sh)
                        xset s on
                        xset +dpms
                        ;;
                    00000001)
                        logger '2-in-1 screen in Tablet mode'
                        #xrandr --output eDP-1 --rotate inverted
                        #xinput set-prop 10 310 -1 0 1 0 -1 1 0 0 1
                        exec /home/james/.config/i3/scripts/iio-sensor-proxy_rotate.sh &
                        xset s off
                        xset -dpms
                        ;;
                esac
                ;;
        esac
        ;;
    *)
        logger "ACPI group/action undefined: $1 / $2"
        ;;
esac

# vim:set ts=4 sw=4 ft=sh et:
