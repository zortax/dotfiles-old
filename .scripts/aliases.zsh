#!/bin/zsh

alias "ls"="ls --group-directories-first --color=auto"
alias "ll"="colorls -l --group-directories-first --gs --dark"
alias "la"="ls --group-directories-first -hal"
alias "diff"="diff --color=auto"
alias "grep"="grep --color=auto"
alias "ip"="ip -color=auto"
alias ":q"="exit"
alias "rm -rf /"="echo \"read mail really fast\""
alias "pls"="sudo \$(history | tail -n1 | cut --complement -d' ' -f1)"
alias "copy"="xsel -ib"
alias "vim"="nvim"

man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}
