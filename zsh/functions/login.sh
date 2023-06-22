#!/bin/zsh

. /home/liam.grogan/Desktop/gits/lgdot/zsh/functions/aws.sh

alias sts='aws sts get-caller-identity 1>&2 2>/dev/null'

AC="StandardMonitoringandTracing"
if ! sts ; then
  echo ""aws sso login --profile StandardMonitoringandTracing --no-browser""
else
  echo "AWS Profile:"
fi
