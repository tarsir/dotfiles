if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

stty -ixon -ixoff

# GIT
source ~/.gitbash

# DOCKER
source ~/.dockerbash

# Prompt
source ~/.promptbash

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
    TARGET_BRANCH=${2}
    find . -name "*${TARGET_FILE}" | xargs -I{} git diff ${TARGET_BRANCH} {}
}

function source__ {
    SOURCE_FILE=${1:-~/.bashrc}
    source $SOURCE_FILE
}

alias src="source__"

# Path settings
export PATH="$PATH:/usr/local/sbin"

init() {
    build_prompt
}

cd_with_prompt_change() {
    cd $1
    build_prompt
}

start_ssh_agent() {
    eval $(ssh-agent -s)
    ssh-add ~/.ssh/id_rsa
}

alias cd="cd_with_prompt_change"
if [ ! -e "$HOME/.asdf" ]; then
	git clone https://github.com/asdf-vm/asdf.git ~/.asdf
	cd ~/.asdf
	git checkout "$(git describe --abbrev=0 --tags)"
fi

if [ -z "$ASDF_SET" ]; then
	. $HOME/.asdf/asdf.sh
	. $HOME/.asdf/completions/asdf.bash
	export ASDF_SET="true"
fi

init
