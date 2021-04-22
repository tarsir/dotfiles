#!/bin/bash

echo "Backing up existing files to this directory just in case"
FILES=(".bashrc" ".dockerbash" ".gitbash" ".promptbash" "nvim.vim")
mkdir -p backups
for f in ${FILES[*]}; do
    cp $f backups/backup$f
done

echo "So now we can remove the existing links, and then make new ones!"
for f in ${FILES[*]}; do
    rm ~/$f
    ln -s $(pwd)/${f} $HOME/${f}
done

echo "Done!"
