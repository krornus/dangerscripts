bindkey -v

alias gdb="gdb -q"
alias ip="ip -c"
alias make="make -j `nproc`"

alias -g ...="../.."
alias -g ....="../../.."
alias -g .....="../../../.."
alias -g ......="../../../../.."
alias -g .......="../../../../../.."
alias -g ........="../../../../../../.."
alias -g .........="../../../../../../../.."

# Created by newuser for 5.9
autoload -Uz compinit
compinit

autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':completion:*:*:cdr:*:*' menu selection

eval "$(direnv hook zsh)"
