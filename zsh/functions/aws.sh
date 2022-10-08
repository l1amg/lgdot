

OS=`uname -s`
if [[ $OS = "Linux" ]];then
  # aws login to profile
  function aws-login(){
  aws sso login --profile $1
  }
fi
