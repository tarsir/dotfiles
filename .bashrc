[[ $- == *i* ]] || return

if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

stty -ixon -ixoff

# GIT
source ~/.gitbash

# Work specific bash stuff
if [ -f ~/.workbash ]; then
    source ~/.workbash
fi

# MISC
alias ls="ls -G --color=auto"
alias del.pyc='find . -type f -name "*.pyc" -delete'
alias del.tilde='find . -type f -name "*~" -delete'
alias del.orig='find . -type f -name "*orig" -delete'
alias del.clean='del.pyc && del.tilde && del.orig'
alias src="source__"

if env | grep "WSL_DISTRO_NAME=" > /dev/null; then
  alias nvim="nvim.appimage --appimage-extract-and-run"
else
  alias nvim="nvim.appimage"
fi

alias vim="nvim"

function du.all {
    sudo du -d 1 | sort -n -r > filesizes.txt
}

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
    source "$SOURCE_FILE"
}

modify_paths() {
  work_paths
  if which go; then
    PATH="$PATH:$(go env GOPATH)/bin"
  fi 
  PATH="$PATH:/usr/local/sbin"
  PATH="$PATH:$HOME/downloads/AppImages"
  PATH="$PATH:$HOME/.asdf/bin"
  PATH="$PATH:$HOME/.bin"
  export PATH
}

if [[ ! -v BASHRC_LOADED ]]; then
  . $HOME/.asdf/asdf.sh
  . $HOME/.asdf/completions/asdf.bash

  modify_paths

  echo "Initial bashrc loading complete"
fi

export BASHRC_LOADED=1

eval "$(starship init bash)"
