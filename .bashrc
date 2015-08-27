if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

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
else
    VIRTUAL_ENV_PROMPT_STR=" ($(basename `echo ${VIRTUAL_ENV}`))"
    echo "Currently in ${VIRTUAL_ENV_PROMPT_STR:2:${#VIRTUAL_ENV_PROMPT_STR}-3}"
fi

PS1="\[$(tput setaf 6)\]\d \[$(tput setaf 4)\]\t\[$(tput setaf 3)\]${VIRTUAL_ENV_PROMPT_STR} \[$(tput setaf 1)\]\w \n    \[$(tput setaf 2)\]\u >\[$(tput sgr0)\]"

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

# do a docker thing
eval $(docker-machine env dev)
function d.use {
    eval $(docker-machine env $1)
}

# nifty docker aliases
function d.bash {
    docker exec -it arcus_$1_1 bash
}

alias d.sync='docker-machine ssh dev "sudo ntpclient -s -h pool.ntp.org"'

# nifty git aliases
alias g.s="git status"
alias g.d="git diff"
alias g.b="git branch"
alias g.p="git pull"
function g.untracked {
    g.s | sed -n -e '/Untracked files/,$p' | tail -n +4 | sed '$d' | sed '$d'
}

# nifty docker/rouster aliases
alias r.b="r bash"
alias d.inf="docker ps"
alias d.rs="docker-machine restart"

function r.test {
    TEST_SUITES="/aver/aver-core/Test/ /aver/Test/ /aver/TestE2E/"
    if [ "$1" = "core" ]; then
        TEST_SUITES="/aver/aver-core/Test/"
    elif [ "$1" = "app" ]; then
        TEST_SUITES="/aver/Test/"
    elif [ "$1" = "e2e" ]; then
        TEST_SUITES="/aver/TestE2E/"
    fi
    echo "Running the following tests: $TEST_SUITES"
    rouster exec -t api py.test $TEST_SUITES --durations=10
}

# handy exports
export PYTHONPATH=/:/aver/Application/aver/aver-core:/aver/common
export ROUSTER_ENVIRONMENT='local.informatics'
alias r=/aver/rouster/rouster.py
