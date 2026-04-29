#!/usr/bin/env sh

# requires: wget grep sed

# determine latest verion number
latest=$(wget -O - -q  https://github.com/nushell/nushell/releases/latest \
  | grep -m 1 -o 'nushell/nushell/releases/tag/[0-9]\+\.[0-9]\+\.[0-9]\+' \
  | sed 's|.*/||')
   
echo $latest

