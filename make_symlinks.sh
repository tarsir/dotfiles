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

rm -f "$HOME/.config/gitui/key_bindings.ron"
cp "./key_bindings.ron" "$HOME/.config/gitui/key_bindings.ron"

# Do separately for nvim

echo "Now copying nvim config"

NVIM_CONFIG="nvim.lua"
NVIM_PLUGINS_PATH="lua/plugins"
NVIM_BASE_DIR="$HOME/.config/nvim/"
NVIM_TARGET_PATH="${NVIM_BASE_DIR}/${NVIM_CONFIG}"
cp "${NVIM_BASE_DIR}/init.lua" "backups/backup${NVIM_CONFIG}-${DATE}"
rm -rf "${NVIM_BASE_DIR}/init.lua" "${NVIM_BASE_DIR}/lua"
et "${NVIM_BASE_DIR}"
mkdir -p $(dirname $NVIM_TARGET_PATH)
mkdir -p "${NVIM_BASE_DIR}/${NVIM_PLUGINS_PATH}"
ln -s "$(pwd)/${NVIM_CONFIG}" "${NVIM_BASE_DIR}/init.lua"
for f in $(rg --files nvim_configs); do
  trimmed=$(printf '%s\n' $f | cut -f2- -d'/')
  final_path="${NVIM_BASE_DIR}/lua/${trimmed}"
  mkdir -p $(dirname $final_path)
  cp "$f" "$final_path"
done

et "${NVIM_BASE_DIR}"

echo "Done!"
