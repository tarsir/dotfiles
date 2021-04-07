# Some stuff I wanna run on all of my *nix systems

echo "Installing basic packages"
sudo apt update && sudo apt install unzip make libssl-dev libncurses5-dev gcc automake autoconf

echo "Installing asdf"

git clone https://github.com/asdf-vm/asdf.git ~/.asdf
cd ~/.asdf
git checkout "$(git describe --abbrev=0 --tags)"

. "$HOME/.asdf/asdf.sh"
. "$HOME/.asdf/completions/asdf.bash"

echo "Installing asdf plugins"
echo

for plugin in "elixir" "erlang" "postgres"; do
    echo "Installing plugin $plugin"
    asdf plugin add "$plugin"
    asdf install "$plugin" latest
done

echo "asdf plugins installed!"
echo

echo "Installing rustup"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo "Done!"
