declare-option str followcmd "tail --retry -n +0 -f"

define-command -params 1.. -shell-completion \
    -docstring %{fifo <cmd> [<args>]: run a command a view its result in a fifo buffer} \
    fifo %{ evaluate-commands %sh{
     output=$(mktemp -d "${TMPDIR:-/tmp}"/kak-fifo.XXXXXXXX)/fifo
     mkfifo ${output}
     (stdbuf -i0 -o0 -e0 $@ | stdbuf -i0 -o0 -e0 tr -d '\r' > ${output} 2>&1 & ) > /dev/null 2>&1 < /dev/null
     printf %s\\n "evaluate-commands -try-client '$kak_opt_toolsclient' %{
               edit! -scroll -fifo ${output} '*fifo - ${1}*'
               hook -always -once buffer BufCloseFifo .* %{ nop %sh{ rm -r $(dirname ${output}) } }
           }"
}}

define-command -params 1 -file-completion \
    -docstring %{follow <file>: read a file as a fifo (like tail -f)} \
    follow %{ evaluate-commands %sh{
     output=$(mktemp -d "${TMPDIR:-/tmp}"/kak-follow.XXXXXXXX)/fifo
     mkfifo ${output}
     (stdbuf -i0 -o0 -e0 ${kak_opt_followcmd} "$1" | stdbuf -i0 -o0 -e0 tr -d '\r' > ${output} 2>&1 & ) > /dev/null 2>&1 < /dev/null
     printf %s\\n "evaluate-commands -try-client '$kak_opt_toolsclient' %{
               edit! -scroll -fifo ${output} '*follow - ${1}*'
               hook -always -once buffer BufCloseFifo .* %{ nop %sh{ rm -r $(dirname ${output}) } }
           }"
}}
