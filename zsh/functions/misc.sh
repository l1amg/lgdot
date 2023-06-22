#!/bin/zsh

function h(){
  

cat << _EOF

AWS: 

    asl            'aws sso login - prints a list of accounts to choose from'
    alc            'aws eks list-clusters'
    auk            'aws eks update-kubecfonfig --name "\$2" --region eu-west-2 --alias "\$2" '
    sts            'aws sts get-caller-identity'
    p              'Prints current AWS_PROFILE'

K8s

    kxl            'kubectl config get-contexts'
    kxs            'kubectl config use-context \$1'
    kn             'kubectl get ns'
    kgp            'kubectl get pods - optional \$1 will search in a namespace that matches \$1'
    kl             'k8s get logs on \$1 add \$2 as namespaces to find pod'
    kr             'Print resource requested versus usage - \$1 is the namespace. Defaul= all-namespaces'
    kc             'Prints the number of pods per namespace
    nodes          'kubectl top nodes'

Directories
    g              'cd ~/Desktop/gits/'
    dot            'cd ~/Desktop/lgdot/zsh/'

LiamoShell
    b              'Build crdsh'
    r              'Run crdsh'

_EOF

}