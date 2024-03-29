#!/usr/bin/env bash

URL="https://github.com/dandavison/delta/releases/download"
VERSION="0.17.0"
DELTA="delta-${VERSION}-x86_64-unknown-linux-gnu.tar.gz"

pushd "$(mktemp -d)" &>/dev/null || exit 1

curl -L "$URL/$VERSION/$DELTA" -o "$DELTA"
tar -xvf "$DELTA"
cp "$(basename $DELTA .tar.gz)/delta" ~/.local/bin

popd &>/dev/null || exit 1
