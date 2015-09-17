#!/bin/sh

set -e
set -x

cd "$(dirname $0)"
base_path="$(pwd)"
dotfiles_path="$base_path/dotfiles"
misc_path="$base_path/misc"

LN="ln -shi"

# Setup dot files and directories
for file in $(ls "$dotfiles_path"); do
    $LN "$dotfiles_path/$file" ~/."$file"
done

# Setup fish shell
mkdir -p ~/.config
$LN "$misc_path/fish" ~/.config/fish

# Setup vimwiki
$LN ~/Dropbox/vimwiki ~/home/vimwiki
mkdir -p ~/tmp

# Setup Karabiner
sh "$base_path/karabiner/karabiner_import.sh"

echo "All done."
