function pods() {
  for N in `kubectl get ns | awk '{print $1}'`
  do
    echo "---------- $N ---------- "
    kubectl get pods -n $N
  done
}

function kusage {
      echo "Usage: $0 [argument]"
      echo ""
      echo "Options:"
      echo "  n                       runs kubectl get namespaces."
      echo "  gp $namespace           runs kubectl get pods (optional namespace)"
      echo "  -o, --option            Describe what the option does."
      echo ""
      echo "Arguments:"
      echo "  ARGUMENT                Describe what the argument represents."
      echo ""
      echo "Example:"
      echo "  $0 -o arg"

}



alias kxl='kubectl config get-contexts'
alias kxs='kubectl config use-context $1'
alias kn='kubectl get ns'
alias kgp='k gp'
alias kr='k r'
alias kl='k l'
alias kc="kubectl get pods --all-namespaces -o jsonpath=\"{.items[*].metadata.namespace}\" | tr ' ' '\n' | sort | uniq -c"
alias nodes='kubectl top nodes'
alias sts='aws sts get-caller-identity'



function k() {
  case "$1" in
    "gp")
        if [ "$2" != "" ];then
            ns=`kn |grep $2 |head -1|awk '{print $1}'`
            kubectl get pods -n $ns
        else
            kubectl get pods --all-namespaces
        fi
        ;;
    "l")
        if [ "$3" != "" ];then
            ns=`kn |grep $3 |head -1|awk '{print $1}'`
            kubectl logs $2 -n $ns
        else
          kubectl logs $2
        fi
        ;;
    "r")
        # Check if an argument is given. If so, only check that namespace.
        if [ "$2" ]; then
            namespaces=`kn |grep $2 | head -1`
            echo "Namespace is $namespaces"
        else
            # Get all namespaces
            namespaces=$(kubectl get namespaces -o jsonpath='{.items[*].metadata.name}')
            echo "all namespaces"
        fi

        echo "NAMESPACE                 POD                           CPU_REQUEST     CPU_USAGE     MEMORY_REQUEST     MEMORY_USAGE"

        for ns in `echo $namespaces`; do
            # Get all pods in the namespace
            pods=$(kubectl -n $ns get pods -o jsonpath='{.items[*].metadata.name}')
            for pod in `echo $pods`; do
                # Get CPU and memory request values
                cpu_request=$(kubectl -n $ns get pod $pod -o jsonpath='{.spec.containers[*].resources.requests.cpu}')
                memory_request=$(kubectl -n $ns get pod $pod -o jsonpath='{.spec.containers[*].resources.requests.memory}')

                # Get CPU and memory usage values
                cpu_usage=$(kubectl top pod $pod -n $ns --no-headers | awk '{print $2}')
                memory_usage=$(kubectl top pod $pod -n $ns --no-headers | awk '{print $3}')

                echo "$ns     $pod     $cpu_request     $cpu_usage     $memory_request     $memory_usage"
            done
        done
        ;;
    "usage")
        kusage
        ;;
    *)
      kusage
      ;;
  esac
}


function kusage(){
  echo ""
}
