[[ $- == *i* ]] || return

if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

stty -ixon -ixoff

source ~/.gitbash

# Work specific bash stuff
if [ -f ~/.workbash ]; then
  source ~/.workbash
fi

alias ls="eza -G"
alias src="source__"
alias vim="nvim"

function du.all {
  sudo du -d 1 | sort -n -r >filesizes.txt
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

path_add() {
  new_path_entry="$1"
  if [ -n "$new_path_entry" ]; then
    case ":$PATH:" in
    *:"${new_path_entry}":*) ;;
    *) export PATH="${PATH}:${new_path_entry}" ;;
    esac
  fi
}

modify_paths() {
  export LLVM_INSTALL_PATH="/home/stephen/local/llvm16-release"
  export FLYCTL_INSTALL="/home/stephen/.fly"

  if declare -F "work_paths" >/dev/null; then
    work_paths
  fi
  zig_paths
  path_add "/usr/local/sbin"
  path_add "$HOME/downloads/AppImages"
  path_add "$HOME/.asdf/bin"
  path_add "$HOME/.bin"
  path_add "$HOME/.local/share/bob/nvim-bin"
  path_add "$LLVM_INSTALL_PATH/bin"
  path_add "$FLYCTL_INSTALL/bin:$PATH"
}

zig_paths() {
  path_add "$HOME/Downloads/zig/build/stage3/bin"
  path_add "$HOME/Downloads/zls/zig-out/bin"
}

. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash
. "$HOME/.cargo/env"

modify_paths

export FZF_DEFAULT_COMMAND='rg --files'

eval "$(starship init bash)"
eval "$(ssh-agency -y)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
