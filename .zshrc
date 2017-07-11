HISTFILE=~/.histfile
SAVEHIST=1000

CASE_SENSITIVE="true"

plugins=(git)

function strlen {
    python -c "print(len('$1'))"
}

setopt autocd
bindkey -v

PROMPT="%B%K{blue} %T %k%b $ "
RPROMPT='%~'

setopt no_share_history

DIRSTACKSIZE=32
setopt autopushd pushdminus pushdsilent pushdtohome
alias dh='dirs -v'

autoload -U compinit promptinit
compinit
promptinit

zstyle ':completion:*' menu select
setopt COMPLETE_ALIASES

alias ls="ls -F --color=auto"

export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/src/

if [[ "$CASE_SENSITIVE" = true ]]; then
    zstyle ':completion:*' matcher-list 'r:|=*' 'l:|=* r:|=*'
else
    if [[ "$HYPHEN_INSENSITIVE" = true ]]; then
        zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
    else
        zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
    fi
fi

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search
