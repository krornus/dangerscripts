if exists("current_compiler")
    finish
endif
let current_compiler = "python"

let s:cpo_save = &cpo
set cpo-=C

setlocal makeprg=python3\ %

setlocal errorformat=
    \%A\ \ File\ \"%f\"\\\,\ line\ %l\\\,%m,
    \%C\ \ \ \ %.%#,
    \%+Z%.%#Error\:\ %.%#,
    \%A\ \ File\ \"%f\"\\\,\ line\ %l,
    \%+C\ \ %.%#,
    \%-C%p^,
    \%Z%m,
    \%-G%.%#

let &cpo = s:cpo_save
unlet s:cpo_save

"vim: ft=vim
