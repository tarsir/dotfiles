#!/bin/bash

echo "Backing up existing files to this directory just in case"
FILES=(".bashrc" ".dockerbash" ".gitbash" ".promptbash" ".vimrc")
mkdir -p backups
for f in ${FILES[*]}; do
    cp $f backups/backup$f
done

echo "So now we can remove the existing links, and then make new ones!"
for f in ${FILES[*]}; do
    rm ~/$f
    ln -s $(pwd)/${f} $HOME/${f}
done

# ln -s $(pwd)/.dockerbash $HOME/.dockerbash
# ln -s $(pwd)/.gitbash $HOME/.gitbash
# ln -s $(pwd)/.promptbash $HOME/.promptbash
# ln -s $(pwd)/.venvbash $HOME/.venvbash
# ln -s $(pwd)/.bashrc $HOME/.bashrc
# ln -s $(pwd)/.bashrc $HOME/.bashrc
# ln -s $(pwd)/.vimrc $HOME/.vimrc

echo "Done!"
