
plugins=(git)

function strlen {
    python -c "print(len('$1'))"
}

function shd {
    setsid $@ >/dev/null 2>&1 < /dev/null &
}

function exit_color() {
    if [[ $? -ne 0 ]]; then
        echo '%K{red}'
    else
        echo '%K{blue}'
    fi
}

PROMPT='%B$(exit_color) %T %k%b -> '
RPROMPT='%~'

DIRSTACKSIZE=32
HISTFILE=~/.histfile
SAVEHIST=1000

CASE_SENSITIVE="true"

setopt autocd
setopt extended_glob

bindkey -v

setopt PROMPT_SUBST
setopt no_share_history
setopt autopushd pushdminus pushdsilent pushdtohome

alias gdb="gdb -q"
alias copy="xclip -selection c"
alias paste="xclip -o -selection c"

alias ls="ls --color=auto -F"
alias grep="grep --color=auto"
alias tree="tree -F -C"
alias ip="ip --color=auto"

autoload -U compinit promptinit
compinit
promptinit

zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

setopt COMPLETE_ALIASES

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search
