if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

stty -ixon -ixoff

# GIT
source ~/.gitbash

# DOCKER
source ~/.dockerbash

# AVER
source ~/.averbash

# VIRTUALENVS
source ~/.venvbash

# Prompt
source ~/.promptbash

# install stuff
source ~/.installbash

# MISC
# other aliases
alias ls="ls -G"
alias del.pyc='find . -type f -name "*.pyc" -delete'
alias del.tilde='find . -type f -name "*~" -delete'
alias del.orig='find . -type f -name "*orig" -delete'
alias del.clean='del.pyc && del.tilde && del.orig'

function find.big {
    SIZE="${1:-+200M}"
    find . -size "${SIZE}" -exec ls -lh {} \;
}

function f.diff {
    TARGET_FILE=${1}
    TARGET_BRANCH=${2:-informatics/develop}
    find . -name "*${TARGET_FILE}" | xargs -I{} git diff ${TARGET_BRANCH} {}
}

function source__ {
    SOURCE_FILE=${1:-~/.bashrc}
    source $SOURCE_FILE
}

alias src="source__"
source ~/.dvm/dvm.sh

# Path settings
export NODE_PATH=/usr/local/lib/node_modules
export PATH="$PATH:/usr/local/sbin"

init() {
    build_prompt
}

init
