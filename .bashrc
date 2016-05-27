if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

stty -ixon -ixoff

# GIT

src ~/.gitbash

# AVER
src ~/.averbash

# VIRTUALENVS

src ~/.venvbash

# Prompt
src ~/.promptbash

# MISC
# other aliases
alias ls="ls -G"
alias del.pyc='find . -type f -name "*.pyc" -delete'
alias del.tilde='find . -type f -name "*~" -delete'
alias del.orig='find . -type f -name "*orig" -delete'
alias del.clean='del.pyc && del.tilde && del.orig'

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

init() {
    build_prompt
}

init
