#!/bin/bash
ID=$(xsetwacom --list devices | grep 'STYLUS' | awk '{ print $8 }')
xsetwacom set $ID MapToOutput $(slop -a 216,135 -c 1,0,0,1 -b 2)

