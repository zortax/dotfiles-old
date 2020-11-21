#!/bin/bash
rofi_command="rofi -theme ~/.config/polybar/scripts/themes/powermenu.rasi"

uptime=$(uptime -p | sed -e 's/up //g')

shutdown="   "
reboot="   "
lock="   "
suspend=" 鈴  "
logout=" 﫼  "

options="$lock\n$suspend\n$logout\n$reboot\n$shutdown"

selected=$(echo -e "$options" | $rofi_command -p "Up: $uptime" -dmenu -selected-row 0)

case $selected in
    $shutdown)
        systemctl poweroff
        ;;
    $reboot)
        systemctl reboot
        ;;
    $lock)
        betterlockscreen -l dim
        ;;
    $suspend)
        mpc -q pause
        amixer set Master mute
        systemctl suspend
        ;;
    $logout)
        bspc quit
        ;;
esac

