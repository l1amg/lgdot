#!/bin/bash

# Check if a namespace parameter is provided
if [ -z "$1" ]; then
  echo "Please provide a namespace parameter."
  exit 1
fi

namespace=$1

# Get the list of pods in the specified namespace
pods=$(kubectl get pods -n "$namespace" --no-headers=true -o custom-columns=":metadata.name")

# Iterate through each pod
for pod in $pods; do
  echo "Pod: $pod"
  echo "------------------------"

  # Get the last line of the pod's logs
  last_log=$(kubectl logs -n "$namespace" "$pod" --tail=1)

  # Check if there are logs available
  if [[ -n "$last_log" ]]; then
    echo "$last_log"
  else
    echo "No logs available for this pod."
  fi

  echo ""
done

