#!/usr/bin/env bash

URL="https://github.com/sharkdp/fd/releases/download"
VERSION="v9.0.0"
FD="fd-${VERSION}-x86_64-unknown-linux-gnu.tar.gz"

pushd "$(mktemp -d)" &>/dev/null || exit 1

curl -L "$URL/$VERSION/$FD" -o "$FD"
tar -xvf "$FD"
cp "$(basename $FD .tar.gz)" ~/.local/bin

popd &>/dev/null || exit 1
