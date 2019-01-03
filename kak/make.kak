
# resets the make commands when the compiler is set back to make after being changed (i.e. cargo)
# commands are copied from core/make.kak

define-command -hidden make-compiler-jump %{
    evaluate-commands %{
        try %{
            execute-keys gl<a-?> "Entering directory" <ret><a-:>
            # Try to parse the error into capture groups, failing on absolute paths
            execute-keys s "Entering directory [`']([^']+)'.*\n([^:/][^:]*):(\d+):(?:(\d+):)?([^\n]+)\z" <ret>l
            set-option buffer make_current_error_line %val{cursor_line}
            make-open-error "%reg{1}/%reg{2}" "%reg{3}" "%reg{4}" "%reg{5}"
        } catch %{
            execute-keys <a-h><a-l> s "((?:\w:)?[^:]+):(\d+):(?:(\d+):)?([^\n]+)\z" <ret>l
            set-option buffer make_current_error_line %val{cursor_line}
            make-open-error "%reg{1}" "%reg{2}" "%reg{3}" "%reg{4}"
        }
    }
}

define-command -hidden make-compiler-next-error -docstring 'Jump to the next make error' %{
    evaluate-commands -try-client %opt{jumpclient} %{
        buffer '*make*'
        execute-keys "%opt{make_current_error_line}ggl" "/^(?:\w:)?[^:\n]+:\d+:(?:\d+:)?%opt{make_error_pattern}<ret>"
        make-jump
    }
    try %{ evaluate-commands -client %opt{toolsclient} %{ execute-keys %opt{make_current_error_line}g } }
}

define-command -hidden make-compiler-previous-error -docstring 'Jump to the previous make error' %{
    evaluate-commands -try-client %opt{jumpclient} %{
        buffer '*make*'
        execute-keys "%opt{make_current_error_line}g" "<a-/>^(?:\w:)?[^:\n]+:\d+:(?:\d+:)?%opt{make_error_pattern}<ret>"
        make-jump
    }
    try %{ evaluate-commands -client %opt{toolsclient} %{ execute-keys %opt{make_current_error_line}g } }
}

hook -group make-compiler global WinSetOption compiler=make %{
    define-command -hidden -override make-jump make-compiler-jump
    define-command -override make-next-error make-compiler-next-error
    define-command -override make-previous-error make-compiler-previous-error
}
