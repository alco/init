set -x EDITOR vim
set -x LC_ALL en_US.UTF-8

set PATH ~/Library/Python/2.7/bin/ $PATH

set -x PATH ~/home/bin $PATH "$GOPATH/bin"

set PATH ~/.rbenv/bin $PATH
set PATH ~/.rbenv/shims $PATH
rbenv rehash >/dev/null ^&1

set -x IPFS_PATH ~/tmp/ipfs
source ~/.asdf/asdf.fish
