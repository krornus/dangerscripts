set number
set autoindent
set smartindent
set tabstop=4
set expandtab
set shiftwidth=4
set softtabstop=4

colorscheme rbog

set mouse=a

syntax on

nnoremap <F1> :set mouse=<CR>
nnoremap <F2> :set mouse=a<CR>
nnoremap <F3> :set hlsearch!<CR>
nnoremap <F4> :set paste!<CR>

inoremap <F1> <ESC>:set mouse=<CR>
inoremap <F2> <ESC>:set mouse=a<CR>
inoremap <F3> <ESC>:set hlsearch!<CR>
inoremap <F4> <ESC>:set paste!<CR>
inoremap jk <ESC>

cnoremap X x
cnoremap W w
cnoremap Q q

nnoremap Q <nop>


