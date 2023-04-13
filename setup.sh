#!/bin/bash
# Some stuff I wanna run on all of my *nix systems

MANJARO_PACKAGES=("curl" "unzip" "make" "openssl" "ncurses" "gcc" "automake"
	"autoconf" "readline" "zlib" "inotify-tools" "fuse2"
	"python-setuptools" "base-devel")
APT_PACKAGES=("curl" "unzip" "make"
      "libssl-dev" "libncurses5-dev" "gcc" "automake" "autoconf"
      "libreadline-dev" "zlib1g-dev" "g++" "inotify-tools" "libfuse2"
      "python-setuptools" "uuid-dev")

system_packages() {
  install_queue=()
  if apt --version &> /dev/null; then
    for p in ${APT_PACKAGES[*]}; do
      if apt show $p &> /dev/null; then
	install_queue+=($p)
      fi
    done
    sudo apt update && sudo apt install ${install_queue[@]}
  elif pacman --version &> /dev/null; then
    for p in ${APT_PACKAGES[*]}; do
      if pacman -Q $p &> /dev/null; then
	install_queue+=($p)
      fi
    done
    sudo pacman -Syu && sudo pacman -S ${install_queue[@]}
  fi
}

asdf_plugins_install() {

    if [ ! -e "~/.asdf" ]; then
        echo "Installing asdf"
        git clone https://github.com/asdf-vm/asdf.git ~/.asdf
        cd ~/.asdf
        git checkout "$(git describe --abbrev=0 --tags)"
    fi

    . "$HOME/.asdf/asdf.sh"
    . "$HOME/.asdf/completions/asdf.bash"

    echo "Installing asdf plugins"
    echo

    for plugin in "elixir" "erlang" "postgres"; do
      if ! asdf current $plugin; then
        echo "Adding plugin $plugin"
        asdf plugin add "$plugin"
        asdf install "$plugin" latest
        asdf global "$plugin" $(asdf latest "$plugin")
      else
        echo "Skipping installed plugin $plugin"
      fi
    done

    if ! asdf current nodejs; then
        echo "Installing plugin nodejs"
        asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
        asdf install nodejs latest
        asdf global nodejs $(asdf latest nodejs)
    fi

    echo "asdf plugins installed!"
}

starship_prompt() {
    if ! starship &> /dev/null; then
        echo "Installing Starship prompt"

        sh -c "$(curl -fsSL https://starship.rs/install.sh)"
    fi
}

rust_and_utils() {
    if [ ! -d "$HOME/.rustup/" ]; then
        echo "Installing rustup"
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
        source "$HOME/.cargo/env"
    fi

    export PATH="$PATH:$HOME/.cargo/bin"

    echo "Installing some cargo tools"

    cargo install exa
    cargo install bob-nvim
    cargo install erdtree
    cargo install ripgrep
    cargo install gitui
    cargo install bottom

    NVIM_VERSION="stable"
    echo "Installing nvim version $NVIM_VERSION"
    bob install "${NVIM_VERSION}"
    bob use "${NVIM_VERSION}"
}

system_packages
asdf_plugins_install
starship_prompt
rust_and_utils

echo "Done!"
