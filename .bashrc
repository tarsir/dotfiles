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

if [ -f ~/.localbash ]; then
  source ~/.localbash
fi

# color definitions
black_fg=30
red_fg=31
green_fg=32
yellow_fg=33
blue_fg=34
magenta_fg=35
cyan_fg=36
white_fg=37
black_bg=40
red_bg=41
green_bg=42
yellow_bg=43
blue_bg=44
magenta_bg=45
cyan_bg=46
white_bg=47

function colorize {
  local color=$1
  local message=$2
  echo -e "\e[${color}m${message}\e[0m"
}

alias ls="eza -G"
alias src="source__"
alias vim="nvim"

function du.all {
  sudo du -d 1 | sort -n -r >filesizes.txt
}

function find.big {
  local SIZE="${1:-+200M}"
  find . -size "${SIZE}" -exec ls -lh {} \;
}

function f.diff {
  local TARGET_FILE=${1}
  local TARGET_BRANCH=${2}
  find . -name "*${TARGET_FILE}" | xargs -I{} git diff ${TARGET_BRANCH} {}
}

function source__ {
  local SOURCE_FILE=${1:-~/.bashrc}
  source "$SOURCE_FILE"
}

function projects_in_dir {
  local target_dir=${1:-$(pwd)}
  find $target_dir -maxdepth 2 -name "*README.md" | while read -r file; do
    project_name=$(basename $(dirname ${file}))
    colorize $blue_fg "${project_name}"
    echo
    sed '/^# \|^$/d;/^##/Q' $file
    printf "\n-------------------\n"
  done
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

export FZF_DEFAULT_COMMAND='rg --files'

function startup {
  if [ ${INITIALIZED:=no} == "no" ]; then
    eval "$(~/.local/bin/mise activate bash)"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    eval "$(starship init bash)"
    eval "$(ssh-agency -y)"
    . "$HOME/.cargo/env"
    modify_paths

    export INITIALIZED="yes"
  fi
}

startup
