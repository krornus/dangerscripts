set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()


Plugin 'gmarik/vundle'
Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-e>"
let g:UltiSnipsJumpBackwardTrigger="<c-q>"

filetype plugin indent on

set number
set autoindent
set smartindent
set tabstop=4
set expandtab
set shiftwidth=3
set softtabstop=3

colorscheme rbog

inoremap <c-c> <esc>yyi
inoremap <c-v> <esc>pi
syntax on
