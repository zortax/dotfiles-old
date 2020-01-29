#!/bin/bash
mkdir -p ~/Pictures/Screenshots
touch ~/Pictures/Screenshots/imgur_upload_log
FILE="$HOME/Pictures/Screenshots/$(date "+%F-%T").png"
import $FILE
response=$(curl -s -H "Authorization: Client-ID c9a6efb3d7932fd" -H "Expect: " -F "image=@$FILE" https://api.imgur.com/3/image.xml)
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

