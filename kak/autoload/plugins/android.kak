define-command -params .. \
    -docstring %{adb [<arguments>]: adb utility wrapper
All the optional arguments are forwarded to the adb utility} \
    adb %{ evaluate-commands %sh{
        BUF="adb"

        output=$(mktemp -d "${TMPDIR:-/tmp}"/kak-adb.XXXXXXXX)/fifo
        mkfifo ${output}
        tmpargs=("${@}")
        for i in $(seq 0 $(($#-1))); do
            case ${tmpargs[$i]} in
                -*)
                    continue
                    ;;
                *)
                    CMD=${tmpargs[$i]}
                    BUF="adb-$CMD"
                    IN_ARGS=${tmpargs[@]:$(($i+1))}
                    break
                    ;;
            esac
        done

        # specific command handlers
        case $CMD in
            logcat)
                # host-side support this var
                # if no filters, use ANDROID_LOG_TAGS
                if [ -z $IN_ARGS ]; then
                    OUT_ARGS="$ANDROID_LOG_TAGS"
                fi
                break
                ;;
        esac

        echo "echo -debug adb $@ $OUT_ARGS"
        (stdbuf -i0 -o0 -e0 adb $@ $OUT_ARGS  | stdbuf -i0 -o0 -e0 tr -d '\015' > ${output} 2>&1) > /dev/null 2>&1 < /dev/null &
        printf %s\\n "evaluate-commands -try-client '$kak_opt_toolsclient' %{
                  edit! -fifo ${output} -scroll *$BUF*
                  hook -always -once buffer BufCloseFifo .* %{ nop %sh{ rm -r $(dirname ${output}) } }
              }"
    }
}
