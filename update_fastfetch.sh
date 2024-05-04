#!/bin/bash

readonly REPO="fastfetch-cli/fastfetch"
NEW_VERSION=$(curl --silent https://api.github.com/repos/$REPO/releases/latest | jq .name -r)
readonly ARCHIVE_FILE_NAME="fastfetch-linux-amd64"
NEW_VERSION_ASSETS="https://github.com/fastfetch-cli/fastfetch/releases/download/$NEW_VERSION/$ARCHIVE_FILE_NAME.tar.gz"
c_dir=$(pwd)
w_dir=$(mktemp -d)
cd "$w_dir" || exit

wget "$NEW_VERSION_ASSETS"
tar xvf "$ARCHIVE_FILE_NAME.tar.gz"
cd "$ARCHIVE_FILE_NAME" || exit
cp ./usr/bin/fastfetch ~/.local/bin/fastfetch
cp ./usr/bin/flashfetch ~/.local/bin/flashfetch
cp ./usr/share/fish/vendor_completions.d/fastfetch.fish ~/.config/fish/completions/fastfetch.fish

cd "$c_dir" || exit
rm -rf "$w_dir"
