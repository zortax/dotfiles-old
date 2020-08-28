#!/bin/zsh

alias "ls"="ls --group-directories-first --color=auto"
alias "ll"="colorls -l --group-directories-first --gs --dark"
alias "la"="ls --group-directories-first -hal"
alias ":q"="exit"
alias "rm -rf /"="echo \"read mail really fast\""
alias "pls"="sudo \$(history | tail -n1 | cut --complement -d' ' -f1)"
alias "copy"="xsel -ib"
