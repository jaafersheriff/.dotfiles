
set background=dark
syntax enable			" enable syntax processing

set tabstop=3			" set tabs to be the same as 3 spaces
" set expandtab

set number				" show line numbers

set showcmd				" show last command in ottom bar 

set cursorline
hi CursorLine term=bold cterm=bold	

set showmatch			" parenthesis highlighting
set hlsearch			" highlight matches 

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" higlight last inserted text
nnoremap gV '['v]

" Folding
set foldmethod=indent
set foldnestmax=2
set nofoldenable
set foldlevel=2
set foldopen-=block

" vertical bar 
highlight ColorColumn ctermbg=Cyan
set colorcolumn=108
"set textwidth=108

if $COLORTERM == 'gnome-terminal'
	set t_Co=256
endif

" yank to system clipboard
set clipboard=unnamed

" Block vs line cursor on Edit/Insert modes
let &t_SI = "\e[5 q"
let &t_EI = "\e[0 q"

" reset the cursor on start (for older versions of vim, usually not required)
augroup myCmds
au!
autocmd VimEnter * silent !echo -ne "\e[0 q"
augroup END
