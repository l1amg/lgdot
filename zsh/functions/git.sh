function parse_git_branch() {
        git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'

}

COLOR_DEF=$'\e[0m'
if [[ $OS = Darwin ]];then
  COLOR_USR=$'\e[38;5;5m'
else
  COLOUR_USR=$'\e[38;5;55m'
fi
COLOR_DIR=$'\e[38;5;34m'
COLOR_GIT=$'\e[38;5;39m'
setopt PROMPT_SUBST
export PROMPT='${COLOR_USR}%n ${COLOR_DIR}%~ ${COLOR_GIT}$(parse_git_branch)${COLOR_DEF} $ '
