#!/usr/bin/env sh

# get the latest nushell -x86_64 release and install it to ~/.local/bin

# requires: wget tar grep cp

# determine latest verion number
latest=$(wget -O - -q  https://github.com/nushell/nushell/releases/latest  |  grep -oP  "nushell/nushell/releases/tag/\K[0-9]+\.+[0-9]+\.[0-9]+" -m 1)

# download release tar.gz into current folder
wget "https://github.com/nushell/nushell/releases/download/${latest}/nu-${latest}-x86_64-unknown-linux-gnu.tar.gz"

# extract tarball
tar zxvf "nu-${latest}-x86_64-unknown-linux-gnu.tar.gz"

# copy to path
cp "nu-${latest}-x86_64-unknown-linux-gnu/nu"* ~/.local/bin
