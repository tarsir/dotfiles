#!/bin/bash

echo "Backing up existing files to this directory just in case"
FILES=(".bashrc" ".dockerbash" ".gitbash" ".promptbash" ".vimrc")
mkdir -p backups
for f in ${FILES[*]}; do
    cp $f backups/backup$f
done

echo "So now we can remove the existing links, and then make new ones!"
for f in ${FILES[*]}; do
    rm -f ~/$f
    ln -s $(pwd)/${f} $HOME/${f}
done

# nvim config has to go somewhere special
NVIM_CONFIG="init.vim"
cp "$NVIM_CONFIG" backups/backup${NVIM_CONFIG}
rm -f ~/"$NVIM_CONFIG"
ln -s "$NVIM_CONFIG" ~/.nvim/"$NVIM_CONFIG"

echo "Nvim config has been linked to ~/.nvim, but this may not be suitable"
echo "for your configuration - please check and move appropriately"

echo "Done!"
