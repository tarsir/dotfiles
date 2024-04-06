#!/bin/bash
# Some stuff I wanna run on all of my *nix systems

ARCH_PACKAGES=("curl" "unzip" "make" "openssl" "ncurses" "gcc" "automake"
  "autoconf" "readline" "zlib" "inotify-tools" "fuse2"
  "python-setuptools" "base-devel" "pkgconf" "freetype2"
  "fontconfig" "libxcb" "xclip" "harfbuzz" "lutris" "flatpak" "steam" "neovim")

APT_PACKAGES=("curl" "unzip" "make" "expat" "libxml2-dev"
  "libssl-dev" "libncurses5-dev" "gcc" "automake" "autoconf"
  "libreadline-dev" "zlib1g-dev" "g++" "inotify-tools" "libfuse2"
  "python-setuptools" "uuid-dev" "pkg-config" "libasound2-dev"
  "libssl-dev" "cmake" "libfreetype6-dev" "libexpat1-dev"
  "libxcb-composite0-dev" "libharfbuzz-dev" "neovim")

ZYPPER_PACKAGES=("git-core" "neovim" "gcc" "make" "inotify-tools" "neovim" "openssl-devel")

install_brew() {
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
}

flatpak_packages() {
  # TODO: do something with this
  FLATPAK_PACKAGES=("obsidian" "discord")
}

system_packages() {
  install_queue=()
  if apt --version &>/dev/null; then
    for p in ${APT_PACKAGES[*]}; do
      if apt show $p &>/dev/null; then
        install_queue+=($p)
      else
	echo "Couldn't find $p in apt repositories"
      fi
    done
    sudo apt update && sudo apt upgrade && sudo apt install ${install_queue[@]}
  elif pacman --version &>/dev/null; then
    for p in ${MANJARO_PACKAGES[*]}; do
      if pacman -Q $p &>/dev/null; then
        install_queue+=($p)
      else
	echo "Couldn't find $p in pacman repositories"
      fi
    done
    sudo pacman -Syu && sudo pacman -S ${install_queue[@]}
  elif zypper --version &>/dev/null; then
    for p in ${ZYPPER_PACKAGES[*]}; do
      if zypper -Q $p &>/dev/null; then
        install_queue+=($p)
      else
	echo "Couldn't find $p in zypper repositories"
      fi
    done
    sudo zypper ref && sudo zypper install ${install_queue[@]}
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
  packages=("eza" "nushell" "zellij" "silicon" "erdtree" "ripgrep" "gitui" "bottom" "mprocs" "starship")
  brew_list=$(brew list)
  brew_packages=()
  for pkg in ${packages[@]}; do
    if ! echo "$brew_list" | grep -w $pkg &>/dev/null; then
      brew_packages+=($pkg)
    fi
  done

  if [ "${#brew_packages[@]}" -eq 0 ]; then
    echo "All Homebrew packages already installed!"
  else
    brew install ${brew_packages[*]}
  fi
}

rust_and_utils() {
  if [ ! -d "$HOME/.rustup/" ]; then
    echo "Installing rustup"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source "$HOME/.cargo/env"
  else
    echo "Updating rustup"
    source "$HOME/.cargo/env"
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
