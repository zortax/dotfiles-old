#!/bin/bash
BUTTON=${1:-1}
echo "Starting autoclicker (Button $BUTTON)..."
MOUSE_ID=$(xinput --list | grep -i -m 1 'DeathAdder' | grep -o 'id=[0-9]\+' | grep -o '[0-9]\+')
echo "Detected DeathAdder on ID $MOUSE_ID..."
while true; do
    while [ `xinput --query-state 13 | grep 'button\[9' | awk -F"=" '/button\[9\]=/ {print $2}'` = "down" ]; do
        xdotool mousedown $BUTTON
        sleep 0.0$(shuf -i 2800-3100 -n 1)
        xdotool mouseup $BUTTON
        sleep 0.0$(shuf -i 3800-4100 -n 1)
    done
    sleep 0.0001
done

