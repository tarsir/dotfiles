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
  else
    echo "I don't support your system's package manager yet. Skipping system packages."
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

    if ! which yarn &> /dev/null; then
      echo "Installing yarn"
      npm install -g yarn
    fi

    echo "asdf plugins installed!"
}

starship_prompt() {
  if ! starship help &> /dev/null; then
    echo "Installing Starship prompt"

    sh -c "$(curl -fsSL https://starship.rs/install.sh)"
  else
    echo "Starship already installed! Skipping"
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

    cargo_packages_base=("exa" "bob-nvim" "erdtree" "ripgrep" "gitui" "bottom" "zellij" "mprocs" "speedtest-rs" "ssh-agency")
    cargo_packages=()
    for pkg in ${cargo_packages_base[@]}; do
      if ! cargo install --list | grep $pkg &> /dev/null; then
        cargo_packages+=($pkg)
      fi
    done

    if [ "${#cargo_packages[@]}" -eq 0 ]; then
      echo "All Cargo packages already installed!"
    else
      cargo install ${cargo_packages[*]}
    fi

    NVIM_VERSION="stable"
    if ! bob ls | grep ${NVIM_VERSION} &> /dev/null; then
      echo "Installing nvim version $NVIM_VERSION via bob-nvim"
      bob install "${NVIM_VERSION}"
      bob use "${NVIM_VERSION}"
    fi
}

case "$1" in
  -a|--all)
    echo "Running all steps: system, asdf, starship, rust"
    system_packages
    asdf_plugins_install
    starship_prompt
    rust_and_utils
    ;;
  -s|--sys)
    echo "Running system packages step"
    system_packages
    ;;
  -a|--asdf)
    echo "Running asdf step"
    asdf_plugins_install
    ;;
  -p|--prompt)
    echo "Running Starship step"
    starship_prompt
    ;;
  -r|--rust)
    echo "Running rust step"
    rust_and_utils
    ;;
  *)
    echo "Doing nothing for unrecognized input"
    exit 1
    ;;
esac

echo "Done!"
