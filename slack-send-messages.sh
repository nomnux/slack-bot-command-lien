#!/bin/sh

set -e

conf_file="$HOME/.slack/slack.conf"

print_usage() {
    cat << __USAGE 1>&2
Usage

  ${0##*/} [OPTION...] [MESSAEGE]

  With no message, read message from standard input.

Options

    -f CONFIGURATION_FILE
        specify configuration file.

__USAGE

    exit 1
}

## ------------------------------------------------------------------------------


while getopts f:h opt; do
    case "$opt" in
        f) f_flag=enabled
           conf_file="$OPTARG"
           ;;
        h|*) print_usage
           ;;
    esac
done
shift `expr $OPTIND - 1`

if [ $# -eq 0 ]; then
    msg=$(cat)
else
    msg="$1"
fi

# read configuration file
. "$conf_file"

json=$(cat << EOF
{
  "channel" : "#${channel}",
  "text" : "@${username_to} ${msg}",
  "username" : "${username_from}",
  "link_names": 1
}
EOF)

curl \
  -sS \
  -X POST \
  -H "Content-type: application/json" \
  --data "$json" \
  "$webhook_url"

exit 0
