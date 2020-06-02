declare-option -hidden int tq_current_line 0

hook global WinSetOption filetype=tq %{
    hook buffer -group tq-hooks NormalKey <ret> tq-jump
}

define-command -override -buffer-completion -params 2.. \
    -docstring %{tq <query> <buffer> [<buffer> ...]: query ast in buffers for given query pattern} \
    tq %{ evaluate-commands %sh{
        output=$(mktemp -d "${TMPDIR:-/tmp}"/kak-grep.XXXXXXXX)/fifo
        mkfifo ${output}
        input="$1"
        shift
        (echo -n "${input}" | tree-sitter query -c /dev/stdin $@ > ${output} 2>&1) > /dev/null 2>&1 < /dev/null &
        printf %s\\n "evaluate-commands -try-client '$kak_opt_toolsclient' %{
               edit! -fifo ${output} -scroll *tq*
               set-option buffer filetype tq
               set-option buffer grep_current_line 0
               hook -always -once buffer BufCloseFifo .* %{ nop %sh{ rm -r $(dirname ${output}) } }
           }"
    }
}

define-command -override -params 2.. tqf %{
    evaluate-commands %sh{
        input=$1
        shift
        printf %s\\n tq $1 $@
    }
}

define-command -override -hidden tq-jump %{
    evaluate-commands -save-regs abc/ %{
        # execute-keys %{"cZ}
        # try %{
            execute-keys '<a-x>srow: ([0-9]+),<ret>'
            set-register a %sh{echo $((kak_reg_1 + 1))}
            set-option buffer tq_current_line %val{cursor_line}
            execute-keys '<a-{>ik<a-x>_' #}
            set-register b %reg{.}
            execute-keys "gg%opt{tq_current_line}g<a-h>"
            evaluate-commands -try-client %opt{jumpclient} edit -existing %reg{b} %reg{a}
            try %{ focus %opt{jumpclient} }
        # } catch %{
        #     execute-keys %{"cz}
        # }
    }
}

define-command tq-next-match -override -docstring 'Jump to the next tq match' %{
    evaluate-commands -try-client %opt{jumpclient} -save-regs / %{
        buffer '*tq*'
        # First jump to enf of buffer so that if grep_current_line == 0
        # 0g<a-l> will be a no-op and we'll jump to the first result.
        # Yeah, thats ugly...
        try %{ execute-keys "gg%opt{tq_current_line}g<a-l>/pattern:<ret>" }
        tq-jump
    }
    try %{ evaluate-commands -client %opt{toolsclient} %{ execute-keys gg %opt{tq_current_line}g } }
}
