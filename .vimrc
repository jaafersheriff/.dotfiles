
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

" Vertical line
set colorcolumn=80
highlight ColorColumn ctermbg=2

" Folding
set foldmethod=syntax
set foldnestmax=2
set nofoldenable
set foldlevel=2
set foldopen-=block

set belloff=all

if $COLORTERM == 'gnome-terminal'
	set t_Co=256
endif

