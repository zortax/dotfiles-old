#!/bin/zsh

shrug() {
    echo $em_shrug
    echo $em_shrug | xsel -i -b
}

run() {
    nohup $* >/dev/null 2>&1 &
}

open() {
    nohup xdg-open $1 >/dev/null 2>&1 &
}

wrun() {
    ~/.scripts/open_floating_window.sh $*
}

wopen() {
    wrun xdg-open $*
}

pw() {
    bw get password $1 | tr -d '\n' | xsel -i -b
}

bw-unlock() {
    export BW_SESSION="$(bw unlock --raw)"
}

setwall() {
    betterlockscreen -u $1 -r 2560x1440
    betterlockscreen -w
}

