#!/usr/bin/env bash

appimage_target="$1"

original_dir=$(pwd)
# make new dir for the appimage
appimage_name_no_extension=$(basename $appimage_target ".AppImage")
mkdir -p $appimage_name_no_extension

cp $appimage_target ./$appimage_name_no_extension/
cd $appimage_name_no_extension
chmod +x ${appimage_target}
./${appimage_target} --appimage-extract

icon_path=$(find ./squashfs-root -maxdepth 1 -name *.png)
icon_name=$(basename $icon_path)
icon_target_path="$HOME/.local/share/icons/$icon_name"
cp $icon_path $icon_target_path
echo "Moving icon to $icon_target_path"

desktop_entry=$(find ./squashfs-root -maxdepth 1 -name *.desktop)
desktop_entry_name=$(basename $desktop_entry)
desktop_target_path="$HOME/.local/share/applications/$desktop_entry_name"
cp $desktop_entry $desktop_target_path
echo "Moving launcher entry to $desktop_target_path"

# modify the desktop entry for the new paths
appimage_exec_path=$(printf "%s/%s" $(pwd) ${appimage_target})
sed -i "\,^Icon,s,.*,Icon=$icon_target_path," $desktop_target_path
sed -i "\,^Exec,s,.*,Exec=$appimage_exec_path %U," $desktop_target_path
sed -i "\,^TryExec,s,.*,TryExec=$appimage_exec_path," $desktop_target_path

# return to original directory
cd $original_dir
