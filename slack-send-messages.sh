#!/bin/sh

set -e

conf_file="$HOME/.slack/slack.conf"

print_usage() {
    cat << __USAGE 1>&2
Usage

  ${0##*/} [OPTION...] MESSAEGE

Options

    -f CONFIGURATION_FILE
        specify configuration file

__USAGE

    exit 1
}

## ------------------------------------------------------------------------------

if [ $# -eq 0 ]; then
    print_usage
fi

while getopts f: opt; do
    case "$opt" in
        f) f_flag=enabled
           conf_file="$OPTARG"
           ;;
        *) print_usage
           ;;
    esac
done
shift `expr $OPTIND - 1`

msg="$1"

# read configuration file
. "$conf_file"

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
