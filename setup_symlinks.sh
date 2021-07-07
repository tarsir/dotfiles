#!/bin/bash

echo "Backing up existing files to this directory just in case"
FILES=(".bashrc" ".dockerbash" ".gitbash" ".promptbash")
mkdir -p backups
for f in ${FILES[*]}; do
    cp $f backups/backup$f
done

echo "So now we can remove the existing links, and then make new ones!"
for f in ${FILES[*]}; do
    rm ~/$f
    echo "Linking $f to ~/$f"
    ln -s $(pwd)/${f} $HOME/${f}
done

# Do separately for nvim

NVIM_CONFIG="nvim.vim"
NVIM_TARGET_PATH="$HOME/.config/nvim/init.vim"
cp ${NVIM_CONFIG} backups/backup${NVIM_CONFIG}
rm -f "${NVIM_TARGET_PATH}"
ln -s "$(pwd)/${NVIM_CONFIG}" "${NVIM_TARGET_PATH}"

echo "Done!"
