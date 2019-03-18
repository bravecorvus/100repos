#!/bin/bash

# Just the git commit message title
title=$(git log -1 --pretty=%B | head -n 1)
git checkout master
# Save the messages into an array called message
IFS=$'\n' message=($(git log -1 --pretty=%B | sed -e '1,2d'))

if [[ $title = *"SENDEMAIL"* ]];
then
  formattedmessages=''
  for i in "${message[@]}"
  do
    formattedmessages=$formattedmessages'|'$i
  done

  json='{"authenticationPassword":"'$EMAILAUTHPASS'", "messages" : "'$formattedmessages'", "packageManaged": "true", "instructions": "go get -u github.com/voiceittech/VoiceIt2-Go</code></div><br /><p class=\"p1\"><span class=\"s1\">inside your project.</span></p>"}'
  curl -X POST -H "Content-Type: application/json" -d $json "https://api.voiceit.io/platform/3"
fi
