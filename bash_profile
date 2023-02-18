#!/usr/bin/env bash

# to silence ""The default interactive shell is now zsh" message
export BASH_SILENCE_DEPRECATION_WARNING=1

export PATH="/usr/local/bin:HOME/.jenv/bin:$PATH"
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH" # for gnu-sed
export PATH="/usr/local/sbin:$PATH" # brew asked me to do this
#export JAVA_HOME="$HOME/.jenv/versions/`jenv version-name`"
#alias jenv_set_java_home='export JAVA_HOME="$HOME/.jenv/versions/`jenv version-name`"'

# Enable git prompt and tab completion
source ~/.git-completion.bash
source ~/.git-prompt.sh

# colors!
green="\[\033[0;32m\]"
blue="\[\033[0;34m\]"
purple="\[\033[0;35m\]"
cyan="\[\033[0;96m\]"
orange="\[\033[38;5;208m\]"
color="\[\033[38;2;251;126;20m\]"  # rgb color code
reset="\[\033[0m\]"

export GIT_PS1_SHOWDIRTYSTATE=1
# '\u' adds the name of the current user to the prompt
# '\$(__git_ps1)' adds git-related stuff
# '\W' adds the name of the current directory
lambda="λ"
export PS1="$purple\u$green\$(__git_ps1)$cyan \W $color$lambda $reset"

# use nvim for man pages
export MANPAGER='nvim +Man!'
export MANWIDTH=999

# env variable for ranger editor
export EDITOR="nvim"

# Aliases
alias ls="exa-ls"
alias op="open ."
alias diff="delta"
alias less="less -i -R"
alias cat="bat" # bat options in ~./config/bat/config
alias grep="grep --color"
alias ssh='TERM=xterm-256color ssh'
alias ra="ranger"
alias rac="ranger-cd"

# Init jenv
if which jenv > /dev/null; then eval "$(jenv init -)"; fi

ranger-cd() {
       tempfile='/tmp/chosendir'
       /usr/local/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
       test -f "$tempfile" &&
       if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
         cd -- "$(cat "$tempfile")"
       fi
       rm -f -- "$tempfile"
}

# kinda janky ://
exa-ls () {
    if [[ $1 = "-l"* ]]
    then
        exa -F --color always --icons "$@"
    else
        exa -F --color always --icons --oneline "$@"
    fi
}

eval "$(jenv init -)" # for jenv

# FZF settings
# Bindings need to be in quotes for some reason (otherwise execute command breaks)
export FZF_DEFAULT_OPTS="--height=40% --multi --border --layout=reverse --cycle \
                         --margin=4%,2% --prompt='λ ' --info=inline \
                         --bind 'ctrl-g:top' \
                         --bind 'ctrl-e:execute(echo {+} | xargs -o nvim)+abort'"

# Source FZF bash key bindings and completion
source ~/.fzf.bash

# Put here by rustup
. "$HOME/.cargo/env"

source /Users/neilweidinger/.config/broot/launcher/bash/br
