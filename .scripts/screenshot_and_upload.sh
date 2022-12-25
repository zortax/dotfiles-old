#!/bin/bash
mkdir -p ~/Pictures/Screenshots
touch ~/Pictures/Screenshots/imgur_upload_log
FILE="$HOME/Pictures/Screenshots/$(date "+%F-%T").png"
#spectacle -rb --output $FILE
maim -g $(slop) $FILE
if [ ! -f $FILE ]; then
    exit 0
fi
response=$(curl -s -H "Authorization: Client-ID d010f9ca5c370bf" -H "Expect: " -F "image=@$FILE" https://api.imgur.com/3/image.xml)
if [ $? -ne 0 ]; then
    notify-send "Screenshot taken\!" "Upload to Imgur failed..." -i image-x-generic
elif echo "$response" | grep -q 'success="0"'; then
    msg=${response##*<error>}
    notify-send "Screenshot taken\!" "Upload to Imgur failed: ${msg%%</error>}"
else
    url="${response##*<link>}"
    url="${url%%</link>*}"
    delete_hash="${response##*<deletehash>}"
	delete_hash="${delete_hash%%</deletehash>*}"
    echo "$FILE    $url    https://imgur.com/delete/$delete_hash" >> $HOME/Pictures/Screenshots/imgur_upload_log
    notify-send "Screenshot taken!" "Uploaded to Imgur: $url" -i image-x-generic
    echo $url | xsel -ib
fi

