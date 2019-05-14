#!/bin/bash

getscript() {
    pgrep -lf ".[ /]$1( |\$)"
}

if getscript "/home/leo/.scripts/space_spam.sh" >/dev/null; then
    kill -9 $(getscript "/home/leo/.scripts/space_spam.sh" | cut -d' ' -f1 -n);
	echo "Killed it!";
else
    nohup bash /home/leo/.scripts/space_spam.sh >/dev/null 2>&1 &
fi



