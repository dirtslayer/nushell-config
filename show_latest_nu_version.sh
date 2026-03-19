#!/usr/bin/env sh

# requires: wget grep 

# determine latest verion number
latest=$(wget -O - -q  https://github.com/nushell/nushell/releases/latest  |  grep -oP  "nushell/nushell/releases/tag/\K[0-9]+\.+[0-9]+\.[0-9]+" -m 1)

echo $latest
