#!/bin/bash

# Just the git commit message title
title=$(git reflog -1 | sed 's/^.*: //')
# Save the messages into an array called message
IFS=$'\n' message=($(git log -1 --pretty=%B | sed -e '1,2d'))

formattedmessages=''
for i in "${message[@]}"
do
  formattedmessages=$formattedmessages'|'$i
done

echo $formattedmessages

json='{"authenticationPassword":"'$EMAILAUTHPASS'", "messages" : "'$formattedmessages'"}'
echo $json
# curl -H "Content-Type: application/json" --data $json -X POST "https://staging-api.voiceit.io/platform/20"
curl -X POST -H "Content-Type: application/json" -d $json "https://0b43ae59.ngrok.io/platform/20"
