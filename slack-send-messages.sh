#!/bin/sh

set -e

if [ $# -eq 0 ];then
    echo "Usage: ${0##*/} MESSAEGE"
    exit 1
fi

. "$HOME"/.slack/slack.conf || exit 1

msg="$1"

json="{
  \"channel\" : \"#${channel}\",
  \"text\" : \"@${username_to} ${msg}\",
  \"username\" : \"${username_from}\",
  \"link_names\": 1
}"

curl \
  -sS \
  -o /dev/null \
  -X POST \
  -H "Content-type: application/json" \
  --data "$json" \
  "$webhook_url"

exit 0
