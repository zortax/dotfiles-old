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
    export DESK_COUNT=$(bspc query -D -m $m | wc -l)
    export DESK_VAR_WIDTH=$((DESK_COUNT * 32 + 10))
    export DESK_OFFSET_NEXT=$((DESK_VAR_WIDTH + 16))

    polybar --reload main -c ~/.config/polybar/workspace.ini &

    if [ "$m" = "$MAIN_MONITOR" ]; then
        
        polybar --reload main -c ~/.config/polybar/system.ini &
        polybar --reload main -c ~/.config/polybar/apps.ini &
        polybar --reload main -c ~/.config/polybar/updates.ini &

    else

        polybar --reload main -c ~/.config/polybar/time.ini &

    fi

done

echo "Polybar started..."
