set -x EDITOR vim
set -x LC_ALL en_US.UTF-8
set -x COLORTERM truecolor

set -x PATH $PATH /usr/local/sbin

source /usr/local/opt/asdf/asdf.fish

# OPAM configuration
set -x PATH ~/.opam/system/bin $PATH
set -x OCAML_TOPLEVEL_PATH ~/.opam/system/lib/toplevel
set -x PERL5LIB "/Users/alco/.opam/system/lib/perl5:$PERL5LIB"
set -x MANPATH $MANPATH ~/.opam/system/man
set -x OPAMUTF8MSGS 1
set -x CAML_LD_LIBRARY_PATH "/Users/alco/.opam/system/lib/stublibs:/usr/local/lib/ocaml/stublibs"
