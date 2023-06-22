#!/bin/bash

# Get the list of nodes in the cluster
nodes=$(kubectl get nodes -o=name)

# Iterate through each node
for node in $nodes; do
  echo "Node: ${node#node/}"
  echo "------------------------"

  # Get the pods running on the current node
  pods=$(kubectl get pods --all-namespaces -o wide --field-selector spec.nodeName=${node#node/} --no-headers=true | awk '{ print $2 " - " $1 }')

  # Check if there are pods on the node
  if [[ -n "$pods" ]]; then
    echo "$pods"
  else
    echo "No pods running on this node."
  fi

  echo ""
done
