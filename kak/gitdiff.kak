declare-option -hidden str gitdiff_head "^diff\s+--git\s+((?:(?:[^\s])|(\\\s))+)\s+((?:(?:[^\s])|(\\\s))+)$"
declare-option -hidden str object_mode ""

add-highlighter shared/git-diff group
add-highlighter shared/git-diff/ regex %opt{gitdiff_head} 0:white+b

hook global NormalKey (<a-i>|<a-a>|\[|\]|\{|\}|<a-\[>|<a-\]|<a-\{>|<a-\}) %{
    set-option global object_mode %val{hook_param}
}

hook -group git-diff-highlight global WinSetOption filetype=diff %{
    add-highlighter window/git-diff ref git-diff
}

hook -group git-diff-hook global WinSetOption filetype=diff %{
    hook buffer -group git-diff-hooks NormalKey p git-diff-next-chunk

    map buffer normal n :git-diff-next-chunk<ret>
    map buffer normal N :git-diff-extend-next-chunk<ret>
    map buffer normal <a-n> :git-diff-prev-chunk<ret>
    map buffer normal <a-N> :git-diff-extend-prev-chunk<ret>
    map -docstring "git-diff chunk" buffer object c <esc>:git-diff-select-chunk<ret>
}

hook -group git-diff-highlight global WinSetOption filetype=(?!diff).* %{
    remove-highlighter window/git-diff
}

hook -group git-diff-hook global WinSetOption filetype=(?!diff).* %{
    map buffer normal n n
    map buffer normal <a-n> <a-n>
}

define-command git-diff-next-chunk -docstring "Jump to the next git-diff chunk" %{
    evaluate-commands -itersel %{
        execute-keys -save-regs / ';<esc>:set-register / %opt{gitdiff_head}<ret>n<a-h>;<ret>'
    }
}

define-command git-diff-prev-chunk -docstring "Jump to the previous git-diff chunk" %{
    evaluate-commands -itersel %{
        execute-keys  -save-regs / ';<esc>:set-register / %opt{gitdiff_head}<ret><a-n><a-h>;<ret>'
    }
}

define-command git-diff-current-chunk -docstring "Go to head of current chunk" %{
    evaluate-commands %{
        git-diff-next-chunk
        git-diff-prev-chunk
    }
}

define-command git-diff-select-chunk -docstring "Select current git-diff chunk" %{
    evaluate-commands -itersel %{
        git-diff-current-chunk
        execute-keys -save-regs ^ 'Z:git-diff-next-chunk<ret>h<a-z>u<a-x><a-;><ret><a-;>'
    }
}

define-command git-diff-extend-next-chunk -docstring "Extend selection to next git-diff chunk" %{
    evaluate-commands -save-regs ab -itersel %{
        evaluate-commands %sh{
            # convert anchor,offset to an array
            s=($(echo $kak_selection_desc | tr ,. " "))

            if [[ "${s[2]}" -lt "${s[0]}"  || ("${s[2]}" == "${s[0]}" && "${s[3]}" -lt "${s[1]}") ]]; then
                echo 'execute-keys %{"aZ<a-:>;"bZ"az<a-:><a-;>}'
                # our cursor should end here
                echo 'git-diff-next-chunk'
                echo 'execute-keys %{"b<a-z>u<a-;>:<esc>}'
            else
                echo 'execute-keys %{"aZ<a-:><a-;>;"bZ"az<a-:>}'
                # our cursor should end here
                echo 'git-diff-next-chunk'
                echo 'execute-keys %{"b<a-z>u<a-;><a-;>:<esc>}'
            fi
        }
    }
}

define-command git-diff-extend-prev-chunk -docstring "Extend selection to previous git-diff chunk" %{
    evaluate-commands -save-regs ab -itersel %{
        evaluate-commands %sh{
            # convert anchor,offset to an array
            s=($(echo $kak_selection_desc | tr ,. " "))

            if [[ "${s[2]}" -lt "${s[0]}"  || ("${s[2]}" == "${s[0]}" && "${s[3]}" -le "${s[1]}") ]]; then
                echo 'execute-keys %{"aZ<a-:>;"bZ"az<a-:><a-;>}'
                # our cursor should end here
                echo 'git-diff-prev-chunk'
                echo 'execute-keys %{"b<a-z>u<a-;>:<esc>}'
            else
                echo 'execute-keys %{"aZ<a-:><a-;>;"bZ"az<a-:>}'
                # our cursor should end here
                echo 'git-diff-prev-chunk'
                echo 'execute-keys %{"b<a-z>u<a-;><a-;>:<esc>}'
            fi
        }
    }
}
