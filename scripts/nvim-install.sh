#!/usr/bin/env bash

URL="https://github.com/neovim/neovim/releases/download/"
VERSION="stable"
NVIM="nvim-linux64.tar.gz"

# pushd "$(mktemp -d)" &>/dev/null || exit 1

curl -L "$URL/$VERSION/$NVIM" -o "$NVIM"
tar xzvf "$NVIM"
mkdir -p ~/.local/bin/
cp "$(basename $NVIM .tar.gz)/bin/nvim" ~/.local/bin
mv "$NVIM/bin/nvim" ~/.local/bin/nvim

# popd &>/dev/null || exit 1
