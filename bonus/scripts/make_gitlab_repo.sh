#!/bin/bash

curl --request POST --header "PRIVATE-TOKEN: `cat gitlab_pat`" \
    --header "Content-Type: application/json" --data '{
      "name": "iot", "description": "iot-app", "path": "iot",
      "visibility": "public"}' \
    --url 'http://gitlab.iot.com/api/v4/projects/'

git clone https://github.com/nakamo326/ynakamot-iot-app
cd ynakamot-iot-app
git remote rm origin
git remote add origin http://root:`cat ../gitlab_pass`@gitlab.iot.com/root/iot
git push --set-upstream origin main