#!/bin/bash

# Check if a namespace parameter is provided
if [ -z "$1" ]; then
  echo "Please provide a namespace parameter."
  exit 1
fi

namespace=$1

# Get the list of nodes in the cluster
nodes=$(kubectl get nodes -o=name)

# Iterate through each node
for node in $nodes; do
  echo "Node: ${node#node/}"
  echo "------------------------"

  # Get the pods running on the current node in the specified namespace
  pods=$(kubectl get pods -n "$namespace" --field-selector spec.nodeName=${node#node/} -o=name)

  # Check if there are pods on the node
  if [[ -n "$pods" ]]; then
    echo "$pods"
  else
    echo "No pods running on this node in the '$namespace' namespace."
  fi

  echo ""
done

