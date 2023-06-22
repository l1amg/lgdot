#!/bin/bash

# Get all the nodes
nodes=$(kubectl get nodes -o jsonpath='{.items[*].metadata.name}')

for node in $nodes; do
    echo "Node: $node"
    echo "=========================="
    # Get all pods in all namespaces on each node and print the namespace and pod name
    kubectl get pods --all-namespaces -o jsonpath="{range .items[*]}{'Namespace: '}{.metadata.namespace}{', Pod: '}{.metadata.name}{', Node: '}{.spec.nodeName}{'\n'}{end}" | awk -v node="$node" -F', ' '$3 ~ node {print $1 ", " $2}' | grep -v kube-system |grep -v observability |grep -v ingress-nginx
    echo "=========================="
done

