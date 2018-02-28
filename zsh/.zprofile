export PLAN9=/usr/local/plan9port
export PATH=$PATH:$PLAN9/bin
export WORKON_HOME=$HOME/.virtualenvs
export TMUX_TMPDIR=/tmp
export VIM_ANYWHERE_TERM="sakura -x '%s'"
export EDITOR=vim
export XDG_CONFIG_HOME=$HOME/.config
export PATH=$PATH:/home/spowell/bin

if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
    exec startx
elif [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 2 ]; then
    exec way-cooler
fi

background --server
