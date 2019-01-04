#!/bin/bash

wrapperplatformversion=$(cat ~/platformVersion)

if [[ $wrapperplatformversion = "1.0.0" ]];
then
  echo "platform version is 1.0.0"
else
  echo "platform version is not"
fi
