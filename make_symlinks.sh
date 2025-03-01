#!/bin/bash

echo "Backing up existing files"
FILES=(".bashrc" ".gitbash")
DATE=$(date +%Y%m%d)
mkdir -p backups
for f in ${FILES[*]}; do
  cp "$f" "backups/backup$f-${DATE}"
done

echo "Removing existing links for current versions"
for f in ${FILES[*]}; do
  rm -f "${HOME}/$f"
  echo "Linking $f to ~/$f"
  ln -s "$(pwd)/${f}" "$HOME/${f}"
done

ssh_config_path="${HOME}/.ssh/config"
echo "Copying ./ssh_config to ${ssh_config_path}"
rm -f "${ssh_config_path}"
cp "./ssh_config" "${ssh_config_path}"

mkdir -p "$HOME/.config/gitui"
mkdir -p "$HOME/.config/zellij"
rm -f "$HOME/.config/gitui/key_bindings.ron"
cp "./config/gitui/key_bindings.ron" "$HOME/.config/gitui/key_bindings.ron"
rm -f "$HOME/.config/starship.toml"
cp "./config/starship.toml" "$HOME/.config/starship.toml"
rm -f "$HOME/.config/zellij/config.kdl"
cp "./config/zellij/config.kdl" "$HOME/.config/zellij/config.kdl"

echo "Copying nushell config files: config.nu, env.nu, my_config.nu, my_env.nu"
NUSHELL_FILES=("config.nu" "env.nu" "my_config.nu" "my_env.nu")
NUSHELL_DIR="$HOME/.config/nushell/"
mkdir -p "$NUSHELL_DIR"
for f in ${NUSHELL_FILES[*]}; do
  rm -f "$NUSHELL_DIR/$f"
  ln -s "$(pwd)/${f}" "$NUSHELL_DIR/${f}"
done

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
