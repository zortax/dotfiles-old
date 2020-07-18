#!/bin/bash
bspc rule -a \* -o state=floating rectangle=$(slop -f "%g")
nohup $* >/dev/null 2>&1 &

