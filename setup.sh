# Some stuff I wanna run on all of my *nix systems

echo "Installing basic packages"
if ! make ; then
    sudo apt update && sudo apt install curl unzip make \
      libssl-dev libncurses5-dev gcc automake autoconf \
      libreadline-dev zlib1g-dev g++ silversearcher-ag \
      inotify-tools libfuse2 python-setuptools uuid-dev
fi

echo "Installing asdf"

if [ ! -e "~/.asdf" ]; then
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
    echo "Skipping plugin $plugin"
  fi
done

if ! asdf current nodejs; then
    echo "Installing plugin nodejs"
    sudo apt install dirmngr gpg gawk
    asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
    asdf install nodejs latest
    asdf global nodejs $(asdf latest nodejs)
fi

echo "asdf plugins installed!"
echo

echo "Installing Starship prompt"
echo

sh -c "$(curl -fsSL https://starship.rs/install.sh)"

echo

if [ ! -d "$HOME/.rustup/" ]; then
    echo "Installing rustup"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

echo "Installing some cargo tools"

cargo install exa
cargo install bob-nvim

NVIM_VERSION="stable"
echo "Installing nvim version $NVIM_VERSION"
bob install "${NVIM_VERSION}"
bob use "${NVIM_VERSION}"

echo "Done!"
