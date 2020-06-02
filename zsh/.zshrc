# The following lines were added by compinstall
zstyle ':completion:*' add-space true
zstyle ':completion:*' completer _expand _complete _ignored _match _approximate _prefix
zstyle ':completion:*' completions 1
zstyle ':completion:*' glob 1
zstyle ':completion:*' ignore-parents parent pwd
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._-]=** r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*' match-original both
zstyle ':completion:*' max-errors 2 not-numeric
zstyle ':completion:*' menu select=1
zstyle ':completion:*' original false
zstyle ':completion:*' prompt '?> %e'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' substitute 1
zstyle :compinstall filename '/home/spowell/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt autocd extendedglob
unsetopt appendhistory beep

setopt no_share_history
unsetopt share_history

bindkey -v
# End of lines configured by zsh-newuser-install

pl_slash=$(printf '\xee\x82\xbc')

function virtual_env_prompt () {
    if [ -z ${VENV_SOURCED} ]; then
        source /usr/bin/virtualenvwrapper.sh
        VENV_SOURCED=1
    fi
    REPLY=${VIRTUAL_ENV+(${VIRTUAL_ENV:t}) }
}

function copy() {
    xclip -selection c
}

function paste() {
    xclip -selection c -o
}

alias cdr="cd $(realpath $PWD)"

grml_theme_add_token arrow '--> ' '' ''
grml_theme_add_token pl-slash "${pl_slash}" '' '%f%b%k'
grml_theme_add_token virtual-env -f virtual_env_prompt '%F{26}' '%f'

zstyle ':prompt:grml:*:items:time' pre   '%B%K{blue}'
zstyle ':prompt:grml:*:items:time' post  '%f%k'
zstyle ':prompt:grml:*:items:time' token " %D{%H:%M} %b%F{blue}%K{89}${pl_slash}"

zstyle ':prompt:grml:*:items:path' pre   '%K{89}'
zstyle ':prompt:grml:*:items:path' post  '%b%k%f'
zstyle ':prompt:grml:*:items:path' token " %40<..<%~%<< %b%k%F{89}${pl_slash} "
zstyle ':prompt:grml:left:setup' items rc time change-root path vcs newline arrow

eval "$(direnv hook zsh)"
