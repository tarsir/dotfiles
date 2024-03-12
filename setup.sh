#!/bin/bash
# Some stuff I wanna run on all of my *nix systems

MANJARO_PACKAGES=("curl" "unzip" "make" "openssl" "ncurses" "gcc" "automake"
  "autoconf" "readline" "zlib" "inotify-tools" "fuse2"
  "python-setuptools" "base-devel" "pkgconf" "freetype2"
  "fontconfig" "libxcb" "xclip" "harfbuzz")

APT_PACKAGES=("curl" "unzip" "make" "expat" "libxml2-dev"
  "libssl-dev" "libncurses5-dev" "gcc" "automake" "autoconf"
  "libreadline-dev" "zlib1g-dev" "g++" "inotify-tools" "libfuse2"
  "python-setuptools" "uuid-dev" "pkg-config" "libasound2-dev"
  "libssl-dev" "cmake" "libfreetype6-dev" "libexpat1-dev"
  "libxcb-composite0-dev" "libharfbuzz-dev")

install_brew() {
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

system_packages() {
  install_queue=()
  if apt --version &>/dev/null; then
    for p in ${APT_PACKAGES[*]}; do
      if apt show $p &>/dev/null; then
        install_queue+=($p)
      fi
    done
    sudo apt update && sudo apt upgrade && sudo apt install ${install_queue[@]}
  elif pacman --version &>/dev/null; then
    for p in ${APT_PACKAGES[*]}; do
      if pacman -Q $p &>/dev/null; then
        install_queue+=($p)
      fi
    done
    sudo pacman -Syu && sudo pacman -S ${install_queue[@]}
  else
    echo "I don't support your system's package manager yet. Skipping system packages."
  fi
}

asdf_update() {
  if [ -e "~/.asdf" ]; then
    pushd .
    cd ~/.asdf
    git fetch
    git checkout "$(git describe --abbrev=0 --tags)"
    popd
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

  for plugin in "elixir" "erlang" "postgres" "nodejs"; do
    if ! asdf current $plugin; then
      echo "Adding plugin $plugin"
      asdf plugin add "$plugin"
      asdf install "$plugin" latest
      asdf global "$plugin" $(asdf latest "$plugin")
    else
      echo "Skipping installed plugin $plugin"
    fi
  done

  echo "asdf plugins installed!"
}

brew_packages() {
  brew install eza
  brew install nushell
  brew install zellij
  brew install silicon
  brew install erdtree
  brew install ripgrep
  brew install gitui
  brew install bottom
  brew install mprocs
  brew install starship
}

rust_and_utils() {
  if [ ! -d "$HOME/.rustup/" ]; then
    echo "Installing rustup"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source "$HOME/.cargo/env"
  else
    echo "Updating rustup"
    rustup update
  fi

  export PATH="$PATH:$HOME/.cargo/bin"

  echo "Installing some cargo tools"

  cargo_packages_base=("bob-nvim" "speedtest-rs" "ssh-agency")
  cargo_packages=()
  for pkg in ${cargo_packages_base[@]}; do
    if ! cargo install --list | grep $pkg &>/dev/null; then
      cargo_packages+=($pkg)
    fi
  done

  if [ "${#cargo_packages[@]}" -eq 0 ]; then
    echo "All Cargo packages already installed!"
  else
    cargo install ${cargo_packages[*]}
  fi

  NVIM_VERSION="stable"
  if ! bob ls | grep ${NVIM_VERSION} &>/dev/null; then
    echo "Installing nvim version $NVIM_VERSION via bob-nvim"
    bob install "${NVIM_VERSION}"
    bob use "${NVIM_VERSION}"
  fi
}

case "$1" in
-a | --all)
  echo "Running all steps: system, brew, asdf, rust"
  system_packages
  install_brew
  brew_packages
  asdf_plugins_install
  rust_and_utils
  ;;
-s | --sys)
  echo "Running system packages step"
  system_packages
  ;;
-a | --asdf)
  echo "Running asdf step"
  asdf_plugins_install
  ;;
-r | --rust)
  echo "Running rust step"
  rust_and_utils
  ;;
-b | --brew)
  echo "Install homebrew and homebrew packages"
  install_brew
  brew_packages
  ;;
*)
  echo "Doing nothing for unrecognized input"
  exit 1
  ;;
esac

echo "Done!"
