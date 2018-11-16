#!/bin/bash

# Just the git commit message title
title=$(git reflog -1 | sed 's/^.*: //')
# Save the messages into an array called message
IFS=$'\n' message=($(git log -1 --pretty=%B | sed -e '1,2d'))


if [[ $title = *"SENDEMAIL"* ]];
then
  formattedmessages=''
  for i in "${message[@]}"
  do
    formattedmessages=$formattedmessages'|'$i
  done

  echo $formattedmessages

  echo "EMAILAUTHPASS"
  echo $EMAILAUTHPASS
  json='{"authenticationPassword":"'$EMAILAUTHPASS'", "messages" : "'$formattedmessages'"}'
  echo $json
  curl -X POST -H "Content-Type: application/json" -d $json "https://0b43ae59.ngrok.io/platform/39"
fi
