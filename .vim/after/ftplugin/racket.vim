au BufRead,BufNewFile *.rkt setfiletype racket

nmap <F5> :w \| !(clear; racket %)<enter>
imap <F5> <Esc>:w \| !(clear; racket %)<enter>

