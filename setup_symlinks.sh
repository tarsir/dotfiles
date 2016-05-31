#!/bin/bash

echo "Backing up existing files to this directory just in case"
FILES=(".bashrc" ".dockerbash" ".gitbash" ".promptbash" ".venvbash" ".vimrc")
mkdir -p backups
for f in ${FILES[*]}; do
    cp $f backups/backup$f
done

echo "So now we can remove the existing links!"
for f in ${FILES[*]}; do
    rm ~/$f
done

echo "And now we make the links anew"
ln -s $(pwd)/.dockerbash $HOME/.dockerbash
ln -s $(pwd)/.gitbash $HOME/.gitbash
ln -s $(pwd)/.promptbash $HOME/.promptbash
ln -s $(pwd)/.venvbash $HOME/.venvbash
ln -s $(pwd)/.bashrc $HOME/.bashrc
# dunno why vimrc can't be symlinked without breaking shit
ln -s $(pwd)/.vimrc $HOME/.vimrc

echo "Done!"
