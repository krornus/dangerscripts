execute pathogen#infect()

set number
set autoindent
set timeoutlen=100
set smartindent

set tabstop=2
set shiftwidth=2
set expandtab

colorscheme rbog

set mouse=a

syntax on

nnoremap <F1> :set mouse=<CR>
nnoremap <F2> :set mouse=a<CR>
nnoremap <F3> :set hlsearch!<CR>
nnoremap <F4> :set paste!<CR>

"keyboard pls"
nnoremap op o
nnoremap opy p
nnoremap ij i
nnoremap ijk j
"keyboard pls"

inoremap <F1> <ESC>:set mouse=<CR>
inoremap <F2> <ESC>:set mouse=a<CR>
inoremap <F3> <ESC>:set hlsearch!<CR>
inoremap <F4> <ESC>:set paste!<CR>
inoremap jk <ESC>

cnoremap X x
cnoremap W w
cnoremap Q q

nnoremap Q <nop>

set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/

" Always show statusline
set laststatus=2

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

