#!/usr/bin/env bash

BIN_DIR="$HOME/.local/bin"
APP_DIR="$HOME/.local/share/applications"

mkdir -p "$BIN_DIR"
mkdir -p "$APP_DIR"

# Install pre-built binary
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

# Create a symbolic link to add kitty to PATH
ln -s ~/.local/kitty.app/bin/kitty "$BIN_DIR"

# Place the kitty.desktop file somewhere it can be found by the OS
cp ~/.local/kitty.app/share/applications/kitty.desktop "$APP_DIR"

# Update the path to the kitty icon in the kitty.desktop file
sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" \
  "${APP_DIR}/kitty.desktop"
