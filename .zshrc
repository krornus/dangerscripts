export ZSH=/home/spowell/.oh-my-zsh

ZSH_THEME="agnoster_patch"

alias dim="xbacklight -set 5"
alias hi="xbacklight -set 75"
alias gdb="gdb -q"
alias r2="r2 -A"
alias pstrace="sudo strace -x -i -s 100 -e trace=!mmap2,mprotect,munmap"
alias sstart="sudo systemctl start"
alias senable="sudo systemctl enable"
alias sstat="sudo systemctl status"
alias srel="sudo systemctl daemon-reload"

plugins=(git, z)

source $ZSH/oh-my-zsh.sh
CASE_SENSITIVE="true"

function strlen {
python -c "print(len('$1'))"
}

setopt autocd
bindkey -v

PROMPT='%{%f%b%k%}$(build_prompt) '
RPROMT='%~'

setopt no_share_history


