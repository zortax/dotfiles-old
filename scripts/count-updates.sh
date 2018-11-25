#!/bin/bash

COUNT_ARCH=$(checkupdates | wc -l)
COUNT_AUR=$(trizen -Su --aur --quiet | wc -l)
TOTAL=$(( COUNT_ARCH + COUNT_AUR))

if [[ $TOTAL -ge 1 ]]; then
    echo "   $COUNT_ARCH / $COUNT_AUR "
fi

