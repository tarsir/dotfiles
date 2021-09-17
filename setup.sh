# Some stuff I wanna run on all of my *nix systems

mkdir -p ~/downloads/AppImages

echo "Installing basic packages"
sudo apt update && sudo apt install unzip make libssl-dev libncurses5-dev gcc automake autoconf libreadline-dev zlib1g-dev g++ silversearcher-ag inotify-tools libfuse2

echo "Installing asdf"

if [ -e "~/.asdf" ]; then
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf
    cd ~/.asdf
    git checkout "$(git describe --abbrev=0 --tags)"
fi

. "$HOME/.asdf/asdf.sh"
. "$HOME/.asdf/completions/asdf.bash"

echo "Installing asdf plugins"
echo

for plugin in "elixir" "erlang" "postgres"; do
    echo "Installing plugin $plugin"
    asdf plugin add "$plugin"
    asdf install "$plugin" latest
    asdf global "$plugin" $(asdf latest "$plugin")
done

if ! asdf current nodejs; then
    echo "Installing plugin nodejs"
    sudo apt install dirmngr gpg curl gawk
    asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
    asdf install nodejs latest
    asdf global nodejs $(asdf latest nodejs)
fi

echo "asdf plugins installed!"
echo

echo "Installing Starship prompt"
echo

sh -c "$(curl -fsSL https://starship.rs/install.sh)"

echo "Installing nvim"
NVIM_FILENAME="nvim.appimage"
curl -L "https://github.com/neovim/neovim/releases/download/v0.5.0/nvim.appimage" -o ~/downloads/AppImages/"${NVIM_FILENAME}"
chmod u+x "$HOME/downloads/AppImages/${NVIM_FILENAME}"

echo

if [ -e "~/.rustup" ]; then
    echo "Installing rustup"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

echo "Done!"
