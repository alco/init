" Turn off vi compatibility (must be the first line in .vimrc)
set nocompatible

" Pathgen.vim stuff described in https://github.com/tpope/vim-pathogen/blob/master/README.markdown
call pathogen#infect()

" Line moving shortcuts, require unimpaired
nmap <C-up> [e
nmap <C-down> ]e
vmap <C-up> [egv
vmap <C-down> ]egv

let mapleader="'"

nmap <Leader>b i<CR><ESC>

"nmap <Leader>f :CommandTFlush<CR>
map K <nop>
map <F1> <nop>
imap <F1> <ESC>

map H <nop>
map L <nop>

nmap j gj
nmap k gk
vmap j gj
vmap k gk

nnoremap <Leader>o :CtrlP<CR>
nnoremap <Leader>b :CtrlPBuffer<CR>
nnoremap <Leader>s :w<CR>
nnoremap <CR> G

" Tagged tuple from a value
nmap <Leader>ct ysaw}a, <Esc>hi:

let g:ctrlp_working_path_mode = 0

" Set a different key to update the cache for ctrlp
let g:ctrlp_prompt_mappings = {'PrtClearCache()': ['<Tab>']}"

" Disable arrow keys
"nnoremap <up> <nop>
"nnoremap <down> <nop>
"nnoremap <left> <nop>
"nnoremap <right> <nop>
"inoremap <up> <C-p>
"inoremap <down> <C-n>
"inoremap <left> <nop>
"inoremap <right> <nop>

" Simplify tab navigation
map <C-Tab> :tabn<CR>
map <D-1> 1gt
map <D-2> 2gt
map <D-3> 3gt
map <D-4> 4gt
map <D-5> 5gt
map <D-6> 6gt
map <D-7> 7gt
map <D-8> 8gt
map <D-9> 9gt
map <D-0> :tablast<CR>

" Basic functionality
syntax on
filetype plugin indent on
set encoding=utf-8
set showcmd
set ruler                       " show the line and column numbers
set showmode
set scrolloff=3                 " minimum number of lines displayed around the cursor
set autoindent
set backspace=indent,eol,start
set hidden                      " don't ask to save a buffer before hiding it
set nospell
set autoread

""new in vim 7.3
"set relativenumber
"set undofile

nmap <Leader>cw :e <C-R>=expand("%:h") . "/" <CR>
"nmap <Leader>et :tabe <C-R>=expand("%:h") . "/" <CR>
"set list
set listchars=tab:▸\ ,eol:¬

nnoremap <C-q> {gq}                 " fill current paragraph


" It is said that modelines bit has some security problems
set modelines=0

" Tab settings
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Don't wrap long lines automatically
"set nowrap

set hlsearch
" Turn off highlighted search words when <C-L> is pressed
nnoremap <silent> <C-L> :set hlsearch! hlsearch?<CR>
set incsearch
set ignorecase
set smartcase

" NERDTree
function! ToggleNerdTree()
    let t:nerd_hidden = exists('t:nerd_hidden') ? !t:nerd_hidden : 1

    if t:nerd_hidden
        :NERDTree
    else
        :NERDTreeClose
    endif
endfunction
nmap <C-N> :call ToggleNerdTree()<CR>

function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
""
"" function! ChromeRefresh()
""     let script_text="tell application \"Google Chrome\"\n tell window 1\n repeat with i from 1 to (count tabs)\n set var to title of tab i\n if var = \"Template\" then\n tell tab i to reload\n exit repeat\n end if\n end repeat\n end tell\n end tell\n"
""     call system("osascript", script_text)
"" endfunction
""
"" "nmap <Leader>r :w<CR>:call ChromeRefresh()<CR>
"" "imap <C-C> <ESC>:w<CR>:call ChromeRefresh()<CR>a
""
" Only do this part when compiled with support for autocommands
if has("autocmd")

  " Treat .md files as Markdown
  autocmd BufEnter *.md set filetype=markdown
  autocmd BufEnter *.go set filetype=go
  autocmd BufEnter *.go setlocal noexpandtab

  autocmd BufEnter *.ex,*.exs setlocal tabstop=2 shiftwidth=2 softtabstop=2
  autocmd BufEnter *.js,*.jsx setlocal tabstop=2 shiftwidth=2 softtabstop=2
  autocmd BufEnter *.html setlocal tabstop=2 shiftwidth=2 softtabstop=2
  autocmd BufEnter *.html.eex setlocal tabstop=2 shiftwidth=2 softtabstop=2
  autocmd BufEnter *.hbs setlocal tabstop=2 shiftwidth=2 softtabstop=2
  autocmd BufEnter .vimrc setlocal tabstop=2 shiftwidth=2 softtabstop=2

  autocmd BufEnter *.html setlocal tabstop=2 shiftwidth=2 softtabstop=2
  autocmd BufEnter *.html.eex set filetype=html
  autocmd BufEnter *.hbs set filetype=html

  autocmd BufEnter *.fish set filetype=sh

  " Remove trailing whitespace when saving a file
  autocmd BufWritePre *.lua,*.t,*.rs,*.ae,*.go,*.html,*.li,*.h,*.m,*.c,*.cc,*.cpp,*.md,*.markdown,*.py,*.js,.vimrc,*.clj,*.ex,*.exs,*.erl :call <SID>StripTrailingWhitespaces()
endif

if has("autocmd") && !exists("autocommands_loaded")
  let autocommands_loaded = 1

  " Perform a specific refresh command if the PostSaveRefresh variable is set
  function! PostSaveRefresh()
    if exists('g:PostSaveRefresh') && g:PostSaveRefresh
      execute "silent !kill -USR1 `ps | grep 'ruby refresh-server.rb' -m 1 | awk '{print $1}'`"
    endif
  endfunction

  function! TogglePostSaveRefresh()
    let g:PostSaveRefresh = exists('g:PostSaveRefresh') ? !g:PostSaveRefresh : 1
  endfunction
  nmap <Leader>ps :call TogglePostSaveRefresh()<CR>

  autocmd BufWritePost * execute 'call PostSaveRefresh()'
endif

" set proper ctags path
let Tlist_Ctags_Cmd = "/usr/local/bin/ctags"

let g:vimwiki_list = [{'path': '~/home/vimwiki/'}]

" Store swap-files and backups in a single place
set directory=~/tmp//,/var/tmp//,/tmp//
set backupdir=~/tmp//,/var/tmp//,/tmp//






" Color scheme
"colorscheme hemisu
"colorscheme jellybeans
"colorscheme PaperColor
"colorscheme default
"hi Search cterm=underline ctermfg=yellow ctermbg=none
"hi Visual cterm=none ctermfg=none ctermbg=lightmagenta
set number
"" The cursorline can slow down scrolling when the system key repetition rate
"" is too fast
"set cursorline
"nmap <Leader>' :silent execute "if &updatetime == 200<CR>:set updatetime=4000<CR>:else<CR>:set updatetime=200<CR>:endif<CR>"<CR>
set updatetime=20
"" Show the cursorline temporarily when idle
autocmd CursorHold * setlocal cursorline cursorcolumn
autocmd CursorMoved,InsertEnter *
    \ if &l:cursorline | setlocal nocursorline nocursorcolumn | endif
set colorcolumn=100
set textwidth=100


" Highlight the columns exceeding the width of 80 characters
highlight OverLength ctermfg=red guibg=#592929
match OverLength /\%101v.\+/

" Set default font for the MacVim
set guifont=MonacoB2:h16
"set guifont=Source\ Code\ Pro:h16
set guioptions-=T               " Hide the toolbar in MacVim

set laststatus=2
"set paste  " Fixes indentation problems with pasting

" select the whole line without the newline char
nmap <Leader>l ^v$h
" execute the whole line as a vim command
nmap <Leader>y <Leader>ly:<C-R>0<CR>

" highlight trailing whitespace
nmap <Leader>r /\s\+$<CR>

" copy to system pasteboard
vmap <Leader>p :w !pbcopy<CR><CR>

set wildmode=list:longest,full
set wildmenu

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'π'
let g:airline_symbols.whitespace = 'Ξ'

"let g:airline_theme = 'badwolf'
let g:airline_theme='light'
hi CursorLine cterm=none ctermbg=white ctermfg=none
hi CursorColumn cterm=none ctermbg=white ctermfg=none
hi ColorColumn ctermbg=white

"let g:bufferline_echo = 0

"set timeoutlen=50 ttimeoutlen=10
set noesckeys

" Unite setup to fuzzy-match full paths in the current dir recursively
call unite#filters#matcher_default#use(['matcher_fuzzy'])
nmap <Leader>af :Unite file_rec<CR>i
nmap <Leader>ab :Unite buffer<CR>

" Switch cursor in INSERT mode
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" Use s to replace the first match of a search
" while search highlighting is enabled
function! KillNextHighlighted()
  if &hlsearch == 1
    call feedkeys("cgn")
  endif
endfunction
nmap s :call KillNextHighlighted()<CR>

" Set Silver Search as the backend for CtrlP
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
