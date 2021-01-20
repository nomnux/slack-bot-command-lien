# Slack command line bot

## Description

Linux/Unix command line Slack bot using Slack Incoming Webhooks.

## Requirement

* Enable Incoming WebHooks in your Slack workspace.
    * https://api.slack.com/incoming-webhooks

## Installation

1. mkdir ~/.slack && cp slack.conf.sample ~/.slack/slack.conf
2. vim ~/.slack/slack.conf
3. chmod 600 ~/.slack/slack.conf

## Usage

```console
Usage: slack-send-messages.sh [OPTION...] MESSAEGE
```
