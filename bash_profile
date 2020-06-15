#!/bin/bash

# Enable git tab completion
source ~/git-completion.bash

# colors!
green="\[\033[0;32m\]"
blue="\[\033[0;34m\]"
purple="\[\033[0;35m\]"
cyan="\[\033[0;96m\]"
orange="\[\033[38;5;208m\]"
color="\[\033[38;2;251;126;20m\]"  # rgb color code
reset="\[\033[0m\]"

# Change command prompt
source ~/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1
# '\u' adds the name of the current user to the prompt
# '\$(__git_ps1)' adds git-related stuff
# '\W' adds the name of the current directory
lambda="λ"
export PS1="$purple\u$green\$(__git_ps1)$cyan \W $color$lambda $reset"

# Aliases
alias less="less -i -R"
alias grep="grep --color"
alias ssh='TERM=xterm-256color ssh'

# colors for ls command
alias ls="ls -p -G"
export LSCOLORS="Gxfxcxdxbxegedabagacad"

# FZF settings
# Bindings need to be in quotes for some reason (otherwise execute command breaks)
export FZF_DEFAULT_OPTS="--height=40% --multi --border --layout=reverse \
                         --margin=4%,2% --prompt='λ ' --info=inline \
                         --bind 'ctrl-g:top' \
                         --bind 'ctrl-e:execute(echo {+} | xargs -o nvim)+abort'"
