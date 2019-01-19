#!/bin/bash

IFS=$'\t' read album artist title \
    <<< "$(mpc --format="%album%\t%artist%\t%title%")"

notify-send --urgency=low --expire-time=5000 --app-name=ncmpcpp \
    --icon=audio-x-generic "$title" "by $artist\nfrom $album"

