#!/bin/sh

# Kill already running instances...
killall -q polybar

# Wait till process terminated...
while pgrep -x polybar >/dev/null; do
    sleep 1;
done

export IFACE=$(ls /sys/class/net | grep wlp) 

MAIN_MONITOR="DP-0"

for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    
    export MONITOR=$m 

    if [ "$m" = "$MAIN_MONITOR" ]; then
        polybar --reload main -c ~/.config/polybar/main.ini &
    else
       polybar --reload secondary -c ~/.config/polybar/main.ini &
    fi

done

echo "Polybar started..."
