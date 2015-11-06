if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

GIT_REPO_DIR="/Users/stephenhara/GitDownloads/git/contrib/completion"
source $GIT_REPO_DIR/git-completion.bash
source $GIT_REPO_DIR/git-prompt.sh

alias ls="ls -G"
alias gcout="git checkout"

stty -ixon -ixoff

alias git-tree="git log --graph --pretty=oneline --abbrev-commit"
alias g.log="clear; git log --graph --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(bold white)— %an%C(reset)%C(bold yellow)%d%C(reset)' --abbrev-commit --date=relative"
alias del.pyc='find . -type f -name "*.pyc" -delete'
alias del.tilde='find . -type f -name "*~" -delete'
alias del.orig='find . -type f -name "*orig" -delete'
alias del.clean='del.pyc && del.tilde && del.orig'

# find out if we're running a virtualenv
if [ -z ${VIRTUAL_ENV+x} ]; then # VIRTUAL_ENV is unset
    echo "No virtual environment set here"
    VIRTUAL_ENV_PROMPT_STR=""
else
    VIRTUAL_ENV_PROMPT_STR=" ($(basename `echo ${VIRTUAL_ENV}`))"
    echo "Currently in ${VIRTUAL_ENV_PROMPT_STR:2:${#VIRTUAL_ENV_PROMPT_STR}-3}"
fi

# build the prompt because fuck this noise
DATETIME_STRING="\[$(tput setaf 6)\]\d \[$(tput setaf 4)\]"
VIRTUAL_ENV_STRING="\[$(tput setaf 3)\]${VIRTUAL_ENV_PROMPT_STR}"
CURRENT_DIR_STRING="\[$(tput setaf 1)\]\w"
USER_STRING="\[$(tput setaf 2)\]\u"
WAIT_WHAT_STRING="\[$(tput sgr0)\]"
GIT_BRANCH_STRING="\[$(tput setaf 7)\]$(__git_ps1)"

PS1="${DATETIME_STRING}\t ${VIRTUAL_ENV_STRING} ${CURRENT_DIR_STRING} ${GIT_BRANCH_STRING}\n    ${USER_STRING} >${WAIT_WHAT_STRING}"

#define a function to grep -r with all the usual additions
#TODO: Finish the update to have this show a more tree-like structure, i.e.
#Apps/physics.c:
#    244:   void gravity() {
#    245:       return 9.8;
#    246:   }
# or something
grepdir() {
    GREP_OUT=$(grep -nr "$@" . -C2)
    FILENAME_LIST=()
    for line in "$GREP_OUT"; do
            echo "$line"
    done
}


# nifty git aliases
alias g.s="git status"
alias g.d="git diff"
alias g.b="git branch"
alias g.p="git pull"
function g.add-origin {
    git branch --set-upstream-to=origin/$1 $1
}

function g.untracked {
    g.s | sed -n -e '/Untracked files/,$p' | tail -n +4 | sed '$d' | sed '$d'
}

# nifty rouster aliases
alias rind="$AVER_SOURCE/rouster/rind"
alias r=rind

alias r.b="r bash"

# docker aliases and functions
eval $(docker-machine env dev)

alias d.nuke='docker stop $(docker ps -a -q) && docker rm --volumes=true $(docker ps -a -q)'
alias d.inf="docker ps"
alias d.rs="docker-machine restart"
function d.use {
    eval $(docker-machine env $1)
}

# nifty docker aliases
alias d.sync='docker-machine ssh dev "sudo ntpclient -s -h pool.ntp.org"'

function file_test {
    $AVER_SOURCE/rouster/rind exec api py.test /aver/$1
}

# some virtualenv stuff
function v.active {
    TARGET_ENV=$1
    if [ -d ~/.virtualenvs/$TARGET_ENV/ ]; then
            source ~/.virtualenvs/$TARGET_ENV/bin/activate
            source ~/.bashrc
    else
            echo ~/.virtualenvs/$TARGET_ENV
            echo "$TARGET_ENV is not a virtual environment!"
    fi
}

# handy exports
export PYTHONPATH=/aver/Application:/aver/aver-core:/aver/common:/:~
export ROUSTER_ENVIRONMENT='local.informatics'
export AVER_SOURCE=~/aver

function source__ {
    SOURCE_FILE=${1:-~/.bashrc}
    source $SOURCE_FILE
}

alias src="source__"
