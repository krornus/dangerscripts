declare-option str compiler

hook -group make-rust global WinSetOption filetype=rust %[
    set-option window makecmd cargo
    set-option global compiler cargo
]

hook global WinSetOption filetype=c %[
    set-option window makecmd %{make -j4}
    set-option global compiler make
]

hook global WinSetOption filetype=cpp %[
    set-option window makecmd %{make -j4}
    set-option global compiler make
]

hook global WinSetOption filetype=python %[
    set-option window makecmd %{python2 %reg{%}}
    set-option global compiler python
]
