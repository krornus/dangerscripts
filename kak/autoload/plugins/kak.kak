require-module x11

define-command x11-kakoune -params .. -file-completion -docstring '
x11-kakoune [file]: create a new terminal as an x11 window
The new window will be an instance of kakoune attached to the current session
Arguments are passed to kakoune' \
%{
    evaluate-commands %sh{
        echo x11-terminal kak -c $kak_session $@
    }
}
