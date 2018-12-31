
hook -group make-rust global WinSetOption filetype=rust %[
    set-option window makecmd cargo
    set-option window make_error_pattern "(?S)^(error)\[(E[0-9]+)\]: (.+)$"

    hook -group make-rust global WinCreate \*make\* %{
        add-highlighter global/rust-error regex "(?S)^(error)\[(E[0-9]+)\]: (.+)$" 1:red+b 2:cyan 3:default+b
        add-highlighter global/rust-line regex "(?S)^\s+(-->) (.+):([0-9]+):([0-9]+)$" \
            1:red+b 2:default+b 3:cyan+d 4:default+b
    }
]

hook global WinSetOption filetype=(?!rust) %[
    remove-hooks global make-rust
]

hook global WinSetOption filetype=c %[
    set-option window makecmd %{make -j4}
]

hook global WinSetOption filetype=cpp %[
    set-option window makecmd %{make -j4}
]

hook global WinSetOption filetype=python %[
    set-option window makecmd %{python2 %reg{%}}
]
