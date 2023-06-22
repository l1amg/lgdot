#!/bin/bash

# Check if an argument is given. If so, only check that namespace.
if [ "$1" ]; then
    namespaces=$1
else
    # Get all namespaces
    namespaces=$(kubectl get namespaces -o jsonpath='{.items[*].metadata.name}')
fi

echo "NAMESPACE     POD     CPU_REQUEST     CPU_USAGE     MEMORY_REQUEST     MEMORY_USAGE"

for ns in $namespaces; do
    # Get all pods in the namespace
    pods=$(kubectl -n $ns get pods -o jsonpath='{.items[*].metadata.name}')
    for pod in $pods; do
        # Get CPU and memory request values
        cpu_request=$(kubectl -n $ns get pod $pod -o jsonpath='{.spec.containers[*].resources.requests.cpu}')
        memory_request=$(kubectl -n $ns get pod $pod -o jsonpath='{.spec.containers[*].resources.requests.memory}')

        # Get CPU and memory usage values
        cpu_usage=$(kubectl top pod $pod -n $ns --no-headers | awk '{print $2}')
        memory_usage=$(kubectl top pod $pod -n $ns --no-headers | awk '{print $3}')

        echo "$ns     $pod     $cpu_request     $cpu_usage     $memory_request     $memory_usage"
    done
done

