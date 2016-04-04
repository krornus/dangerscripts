set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Plugin 'gmarik/vundle'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-e>"
let g:UltiSnipsJumpBackwardTrigger="<c-q>"

let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]

call vundle#end()
filetype plugin indent on

set number
set autoindent
set smartindent
set tabstop=4
set expandtab
set shiftwidth=4
set softtabstop=4

colorscheme rbog

set mouse=a

inoremap <c-c> <esc>yyi
inoremap <c-v> <esc>pi
syntax on

nmap <F1> <nop>
imap <F1> <nop>

