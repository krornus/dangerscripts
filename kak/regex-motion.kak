define-command -params 1 extend-to-offset %{
    evaluate-commands %{
        evaluate-commands %sh{
            if [ $kak_cursor_byte_offset -lt $1 ]; then
                offset=$(($1-$kak_cursor_byte_offset))
                echo execute-keys "${offset}L"
            else
                offset=$(($kak_cursor_byte_offset-$1))
                echo execute-keys "${offset}H"
            fi
        }
    }
}

define-command -params 1 select-to-offset %{
    evaluate-commands %{
        execute-keys ";"
        extend-to-offset %arg{1}
    }
}

define-command -params 1.. extend-by-command %{
    evaluate-commands -itersel -save-regs ab %{
        execute-keys '"aZ;'
        evaluate-commands %arg{@}
        set-register b %val{cursor_byte_offset}
        execute-keys '"az'
        extend-to-offset %reg{b}
    }
}

define-command -params 1.. select-by-command %{
    evaluate-commands %{
        execute-keys ";"
        extend-by-command %arg{@}
    }
}

define-command -params 1 jump-forward-regex-start %{
    evaluate-commands -itersel %{
        try %{
            search-no-wrap %arg{1}
            execute-keys "<a-;>;"
        } catch %{
            #jump-end
            fail "No selections remaining"
        }
    }
}

define-command -params 1 jump-forward-regex-end %{
    evaluate-commands -itersel %{
        try %{
            search-no-wrap %arg{1}
            execute-keys ";"
        } catch %{
            #jump-end
            fail "No selections remaining"
        }
    }
}

define-command -params 1 jump-backward-regex-start %{
    evaluate-commands -itersel %{
        try %{
            reverse-search-no-wrap %arg{1}
            execute-keys "<a-;>;"
        } catch %{
            #jump-start
            fail "No selections remaining"
        }
    }
}

define-command -params 1 jump-backward-regex-end %{
    evaluate-commands -itersel %{
        try %{
            reverse-search-no-wrap %arg{1}
            execute-keys ";"
        } catch %{
            #jump-start
            fail "No selections remaining"
        }
    }
}

define-command -params 2 create-movement-command %{
    evaluate-commands %sh{
        echo "
        define-command -params 1 select-$2 %{
            select-by-command $1 %arg{1}
        }
        define-command -params 1 extend-$2 %{
            extend-by-command $1 %arg{1}
        }"
    }
}

create-movement-command jump-forward-regex-start forward-regex-start
create-movement-command jump-forward-regex-end forward-regex-end
create-movement-command jump-backward-regex-start backward-regex-start
create-movement-command jump-backward-regex-end backward-regex-end

define-command jump-start %{
    execute-keys "gk<a-h>;"
}

define-command jump-end %{
    execute-keys "gj<a-l>;"
}

define-command -params 1 search-no-wrap %{
    evaluate-commands -save-regs ab/ %{

        set-register a %val{cursor_byte_offset}
        set-register / %arg{1}
        execute-keys '"bZ'
        try %{ execute-keys 'n<a-:>' } catch %{ fail 'No selections remaining' }

        evaluate-commands %sh{
            kak_cursor_byte_offset=$(echo $kak_cursor_byte_offset | tr -d "'")
            kak_reg_a=$(echo $kak_reg_a | tr -d "'")
            if [ $kak_cursor_byte_offset -le $kak_reg_a ]; then
                echo 'execute-keys %{"bz}'
                echo 'fail "No selections remaining"'
            fi
        }
    }
}

define-command -params 1 reverse-search-no-wrap %{
    evaluate-commands -save-regs ab/ %{
        set-register a %val{cursor_byte_offset}
        set-register / %arg{1}
        execute-keys '"bZ'
        try %{ execute-keys '<a-n><a-:>' } catch %{ fail 'No selections remaining' }

        evaluate-commands %sh{
            kak_cursor_byte_offset=$(echo $kak_cursor_byte_offset | tr -d "'")
            kak_reg_a=$(echo $kak_reg_a | tr -d "'")
            if [ $kak_cursor_byte_offset -ge $kak_reg_a ]; then
                echo 'execute-keys %{"bz}'
                echo 'fail "No selections remaining"'
            fi
        }
    }
}

