#!/bin/bash

echo "Backing up existing files to this directory just in case"
FILES=(".averbash" ".gitbash" ".promptbash" ".venvbash" ".vimrc")
mkdir -p backups
for f in ${FILES[*]}; do
    cp $f backups/backup$f
done

echo "So now we can remove the existing links!"
for f in ${FILES[*]}; do
    rm ~/$f
done

echo "And now we make the links anew"
ln -s .averbash ~/.averbash
ln -s .gitbash ~/.gitbash
ln -s .promptbash ~/.promptbash
ln -s .venvbash ~/.venvbash
ln -s .vimrc ~/.vimrc

echo "Done!"
