#!/bin/sh

set -e

cd "$(dirname $0)"
base_path="$(pwd)"
dotfiles_path="$base_path/dotfiles"

LN="ln -shf"

# Setup dot files and directories
for file in $(ls "$dotfiles_path"); do
  $LN "$dotfiles_path"/$file ~/.$file
done
