colorscheme kalisi

execute pathogen#infect()

set listchars=trail:·,tab:→\
set list
set timeoutlen=100

set tabstop=4
set shiftwidth=4
set expandtab

set autoindent
set hidden
set number
set relativenumber
set mouse=a
set relativenumber
set diffopt+=vertical

syntax on
filetype plugin on
set omnifunc=syntaxcomplete#Complete

inoremap <F1> <nop>

nnoremap <F3> :set hlsearch!<CR>
vnoremap <F3> :set hlsearch!<CR>

nnoremap <F4> :set paste!<CR>
vnoremap <F4> :set paste!<CR>

nnoremap <F5> :%s/\(\<<c-r>=expand("<cword>")<CR>\>\)/

nnoremap <F6> :make<CR>

nnoremap <C-Up> :cN<CR>
nnoremap <C-Down> :cn<CR>

nnoremap <C-Left>  :bN<CR>
nnoremap <C-Right> :bn<CR>
nnoremap <F12> :%s/\v\s+$//g<CR>

nnoremap \ :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>


inoremap jk <ESC>

cnoremap jk <c-f>

vnoremap K k
vnoremap J j

nnoremap Q <nop>

set laststatus=2

set t_Co=256
set encoding=utf-8
let g:Powerline_symbols='unicode'

hi Normal ctermbg=none
highlight NonText ctermbg=none

nnoremap g<C-]> :cs find 3 <C-R>=expand("<cword>")<CR><CR>
nnoremap g<C-\> :cs find 0 <C-R>=expand("<cword>")<CR><CR>

vnoremap g<C-]> :cs find 3 <C-R>=expand("<cword>")<CR><CR>
vnoremap g<C-\> :cs find 0 <C-R>=expand("<cword>")<CR><CR>

cnoremap <C-n> <C-f>i<C-n>

autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/
autocmd BufWrite *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" <bar> redraw!

