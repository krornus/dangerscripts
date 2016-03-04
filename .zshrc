# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
bindkey -v

alias dim="xbacklight -set 5"
alias hi="xbacklight -set 75"
alias gdb="gdb -q"
alias r2="r2 -A"
export PATH=$PATH:~/.bin:~/Documents/Programming/VSCode:~/programming/racket/bin 
export TERMINAL=sakura

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/spowell/.zshrc'
autoload -U colors
colors
autoload -Uz compinit
compinit
# End of lines added by compinstall
PROMPT="%(?,%{$fg[green]%}+ %{$reset_color%},%{$fg[red]%}- %{$reset_color%}) - %T: "
RPROMPT="%~"
