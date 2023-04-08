#!/bin/bash

echo "Backing up existing files to this directory just in case"
FILES=(".bashrc" ".gitbash")
DATE=$(date +%Y%m%d)
mkdir -p backups
for f in ${FILES[*]}; do
    cp "$f" "backups/backup$f-${DATE}"
done

echo "So now we can remove the existing links, and then make new ones!"
for f in ${FILES[*]}; do
    rm -f "${HOME}/$f"
    echo "Linking $f to ~/$f"
    ln -s "$(pwd)/${f}" "$HOME/${f}"
done

ssh_config_path="${HOME}/.ssh/config"
rm -f "${ssh_config_path}"
echo "Copying ./ssh_config to ${ssh_config_path}"
cp "./ssh_config" "${ssh_config_path}"

# Do separately for nvim

echo "Now copying nvim config"

NVIM_CONFIG="nvim.vim"
NVIM_TARGET_PATH="$HOME/.config/nvim/init.vim"
mkdir -p $(dirname $NVIM_TARGET_PATH)
cp "${NVIM_CONFIG}" "backups/backup${NVIM_CONFIG}-${DATE}"
rm -f "${NVIM_TARGET_PATH}"
ln -s "$(pwd)/${NVIM_CONFIG}" "${NVIM_TARGET_PATH}"

echo "Done!"
