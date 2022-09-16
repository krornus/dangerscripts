# save the current buffer to its file as root
# (optionally pass the user password to sudo if not cached)

define-command -hidden sudo-write-impl %{
    eval -save-regs f %{
        # TOOD this could take the content of the buffer from stdin instead
        reg f %sh{ mktemp --tmpdir XXXXX }
        write -force %reg{f}
        eval %sh{
            sudo -n -- dd if="$kak_main_reg_f" of="$kak_buffile" >/dev/null 2>&1
            if [ $? -eq 0 ]; then
                echo "edit!"
            else
                echo "echo -markup '{Error}Something went wrong'"
            fi
            rm -f "$kak_main_reg_f"
        }
    }
}

define-command -hidden -params 1 sudo-password %{
    prompt -password 'password:' %{
        eval -no-hooks %sh{
            printf "$1\n" | sudo -S true
            ok=$?
            if [ $ok -eq 0 ]; then
                echo sudo-write-impl
            else
                echo fail "password is incorrect"
            fi
        }
    }
}

define-command sudo-write -docstring "Write the content of the buffer using sudo" %{
    eval %sh{
        # tricky posix-way of getting the first character of a variable
        # no subprocess!
        if [ "${kak_buffile%"${kak_buffile#?}"}" != "/" ]; then
            # not entirely foolproof as a scratch buffer may start with '/', but good enough
            printf 'fail "Not a file"'
            exit
        fi
        # check if the password is cached
        if sudo -n true > /dev/null 2>&1; then
            printf sudo-write-impl
        else
            printf "sudo-password\n"
            printf sudo-write-impl
        fi
    }
}
