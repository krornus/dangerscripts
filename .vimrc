execute pathogen#infect()

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-h>"
let g:UltiSnipsJumpBackwardTrigger="<c-l>"

let g:UltiSnipsEditSplit="vertical"

set number
set autoindent
set timeoutlen=100
set smartindent

set tabstop=4
set shiftwidth=4
set expandtab

colorscheme rbog

set mouse=a

syntax on

nnoremap <F1> :set mouse=<CR>
nnoremap <F2> :set mouse=a<CR>
nnoremap <F3> :set hlsearch!<CR>
nnoremap <F4> :set paste!<CR>
nnoremap <F5> #:%s/<c-r>//

inoremap <F1> <ESC>:set mouse=<CR>
inoremap <F2> <ESC>:set mouse=a<CR>
inoremap <F3> <ESC>:set hlsearch!<CR>
inoremap <F4> <ESC>:set paste!<CR>
inoremap jk <ESC>

nnoremap Q <nop>

set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/

set laststatus=2

set t_Co=256

set encoding=utf-8
let g:Powerline_symbols='unicode'

hi Normal ctermbg=none
highlight NonText ctermbg=none
