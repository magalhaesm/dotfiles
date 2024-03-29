#!/usr/bin/env bash

URL="https://github.com/eza-community/eza/releases/download"
VERSION="v0.18.9"
EZA="eza_x86_64-unknown-linux-gnu.tar.gz"

pushd "$(mktemp -d)" &>/dev/null || exit 1

curl -L "$URL/$VERSION/$EZA" -o "$EZA"
tar -xvf "$EZA"
mv eza ~/.local/bin

popd &>/dev/null || exit 1
