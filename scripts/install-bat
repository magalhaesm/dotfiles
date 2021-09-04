#!/usr/bin/env bash

URL="https://github.com/sharkdp/bat/releases"
RELEASES="$URL/latest"
DOWNLOAD="$URL/download"

LATEST=$(curl -s $RELEASES | cut -d'"' -f2)
VERSION=$(basename "$LATEST")

ARCH="amd64"
DEB_AMD64="bat_${VERSION:1}_${ARCH}.deb"

pushd "$(mktemp -d)" &>/dev/null || exit 1

curl -L "$DOWNLOAD/$VERSION/$DEB_AMD64" -o "$DEB_AMD64"
sudo dpkg -i "$DEB_AMD64"

popd &>/dev/null || exit 1
