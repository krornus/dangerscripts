fpath=(.zsh/completions $fpath)


HISTFILE=~/.histfile
SAVEHIST=1000

CASE_SENSITIVE="true"

plugins=(git)

function strlen {
    python -c "print(len('$1'))"
}

function shd {
    setsid $@ >/dev/null 2>&1 < /dev/null &
}

function twitch {
    shd streamlink https://go.twitch.tv/$1 720p
    weechat -r "/connect irc://$TWITCHNICK@irc.chat.twitch.tv:6667/$1" -password=$TWITCHOAUTH
}

setopt autocd
setopt extended_glob

bindkey -v

PROMPT="%B%K{blue} %T %k%b -> "
RPROMPT='%~'

setopt no_share_history

DIRSTACKSIZE=32
setopt autopushd pushdminus pushdsilent pushdtohome

alias dh='dirs -v'
alias vzm='vim $(fzf)'
alias vless="vim -c 'setlocal buftype=nofile' -"
alias gdb="gdb -q"
alias copy="xclip -selection c"
alias paste="xclip -o -selection c"

export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/src/

autoload -U compinit promptinit
compinit
promptinit

zstyle ':completion:*' menu select
setopt COMPLETE_ALIASES

alias ls="ls -F --color=auto"
export PYTHONSTARTUP="$HOME/.pystartup"

if [[ "$CASE_SENSITIVE" = true ]]; then
    zstyle ':completion:*' matcher-list 'r:|=*' 'l:|=* r:|=*'
fi

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search


function virtualenv {
    export WORKON_HOME=~/.virtualenvs
    source /usr/bin/virtualenvwrapper.sh
}

function command_not_found_handler() {
    output=$(python2 -c '$1' 2> /dev/null)
    if [ $? -eq 0 ]; then
        echo $output
    else
        echo "zsh: command not found: $1"
    fi
}

