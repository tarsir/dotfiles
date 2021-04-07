# Some stuff I wanna run on all of my *nix systems

echo "Installing basic packages"
sudo apt update && sudo apt install unzip make libssl-dev libncurses5-dev gcc automake autoconf libreadline-dev zlib1g-dev

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

echo "asdf plugins installed!"
echo

if [ -e "~/.rustup" ]; then
    echo "Installing rustup"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

echo "Done!"
