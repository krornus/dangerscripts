# requires grml zsh
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._-]=** r:|=**' 'l:|=* r:|=*'

bindkey -v

autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

eval "$(direnv hook zsh)"

alias copy="xclip -selection c"
alias paste="xclip -selection c -o"

alias gdb="gdb -q"
alias grep="grep --color=auto"
alias ip="ip -c"
alias make="make -j `nproc`"

alias -g ...="../.."
alias -g ....="../../.."
alias -g .....="../../../.."
alias -g ......="../../../../.."
alias -g .......="../../../../../.."
alias -g ........="../../../../../../.."
alias -g .........="../../../../../../../.."

grml_theme_add_token fullpath '%/' '%F{214}' '%f'
grml_theme_add_token dash '-' ' ' ' '
grml_theme_add_token arrow '>' '%(0?.%F{32}.%F{red})' '%f '

zstyle ':prompt:grml:*:items:time' pre ''
zstyle ':prompt:grml:*:items:time' post ''

zstyle ':prompt:grml:left:setup' items rc change-root fullpath dash time vcs newline arrow
