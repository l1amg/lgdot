

OS=`uname -s`
if [[ $OS = "Linux" ]];then
  # aws login to profile
#  function aws-login(){
 # aws sso login --profile $1
 echo "Linux"
  #}
fi

alias stsl='aws sts get-caller-identity 1>/dev/null 2>/dev/null'

alias alc="aws eks list-clusters --output json | jq -r '.clusters[]'"
alias auk='eks update-kubeconfig --name "$2" --region $AWS_REGION --alias $2'

function a() {
  case "$1" in
    "lc")
    aws eks list-clusters
    ;;
    "uk")
    aws eks update-kubeconfig --name "$2" --region eu-west-2 --alias $2
    ;;
  esac
}

function asl(){

  # Empty array
 typeset -a choices

 # Read file into an array
 #while IFS= read -r line || [[ -n $line ]]; do
 for i in `grep "^\[" ~/.aws/config | awk '{print $2}' | sed -e 's/\]//g'`
 do
   choices+="$i"
 done

 # Print options
 echo "Please select an option:"
 i=1
 for choice in "${(@)choices}"; do
   echo "$i) $choice"
   i=$((i+1))
 done

 # Get user input
 read "selection?Enter the number of your choice: "

 # Check if the input is a valid option
 if [[ $selection -ge 1 && $selection -le ${#choices} ]]; then
   export AWS_PROFILE="${choices[$selection]}"
   # sts 1>&2 2> /dev/null
   #if [ $? -ne 0 ];then
   if ! stsl ; then
      #echo "You selected: ${choices[$selection]}"
      aws sso login --profile ${choices[$selection]} --no-browser
   else
      echo "AWS Profile: ${choices[$selection]}"
   fi
 else
   echo "Invalid selection"
 fi
}

function rep(){

COUNT=1

	typeset -a accounts
	for i in `grep "^\[" ~/.aws/report-configs | awk '{print $2}' | sed -e 's/\]//g'`
	do
		accounts+="$i"
	done

	for account in "${(@)accounts}"
	do
		echo "_____$COUNT) ${accounts[$COUNT]} ______ \n"
    	  export AWS_PROFILE="${accounts[$COUNT]}"
		    if ! stsl ; then
			    aws sso login --profile ${accounts[$COUNT]} --no-browser
		    else
			    echo "AWS Profile: ${accounts[$COUNT]}"
		    fi
        for REGION in `echo "eu-west-1 eu-west-2"`
        do
          export AWS_REGION=$REGION
          NUMBERC=`alc |wc -l `
          echo "There are $NUMBERC clusters in this account in $REGION\n"
          alc
        done

    COUNT=$((COUNT+1))
	done
}
