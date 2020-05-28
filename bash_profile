#!/bin/bash

export PATH="/usr/local/bin:HOME/.jenv/bin:$PATH"
export PATH="$PATH:`yarn global bin`:/usr/local/nodejs/bin:/usr/local/sbin"
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH" # for gnu-sed
#export JAVA_HOME="$HOME/.jenv/versions/`jenv version-name`"
#alias jenv_set_java_home='export JAVA_HOME="$HOME/.jenv/versions/`jenv version-name`"'

# Enable git tab completion
source ~/git-completion.bash

# set -o vi

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

# use bat for man pages
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# env variable for ranger editor
export EDITOR="nvim"

# Aliases
alias ls="exa-ls"
alias op="open ."
alias diff="colordiff"
alias less="less -i -R"
alias cat="bat" # bat options in ~./config/bat/config
alias grep="grep --color"
alias ssh='TERM=xterm-256color ssh'
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
alias vim="/usr/local/bin/vim"
alias mvim="open -a MacVim.app $1"
alias ra="ranger"
alias rac="ranger-cd"
alias glog="git log --oneline --graph --all"
alias yt-1080="youtube-dl --ignore-errors -f 'bestvideo[ext=mp4][height>=1080]+bestaudio[ext=m4a]/best[ext=mp4]/best' -o '%(title)s.%(ext)s'"
alias yt-best="youtube-dl --ignore-errors -f 'best[ext=mp4]/best' -o '%(title)s.%(ext)s'"
alias books-icloud="rsync -azP --exclude='.DS_Store' /Users/neilweidinger/Documents/University/Textbooks /Users/neilweidinger/Library/Mobile\ Documents/com~apple~CloudDocs"
alias books-school="rsync -azP --exclude='.DS_Store' /Users/neilweidinger/Documents/University/Textbooks s1759126@student.ssh.inf.ed.ac.uk:~/Documents"

# Init jenv
if which jenv > /dev/null; then eval "$(jenv init -)"; fi

# colors for ls command
# alias ls="ls -p -G"
# export LSCOLORS="Gxfxcxdxbxegedabagacad"

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

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/neilweidinger/google-cloud-sdk/path.bash.inc' ]; then . '/Users/neilweidinger/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/neilweidinger/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/neilweidinger/google-cloud-sdk/completion.bash.inc'; fi

# FZF settings
# Bindings need to be in quotes for some reason (otherwise execute command breaks)
export FZF_DEFAULT_OPTS="--height=40% --multi --border --layout=reverse \
                         --margin=4%,2% --prompt='λ ' --info=inline \
                         --bind 'ctrl-g:top' \
                         --bind 'ctrl-e:execute(echo {+} | xargs -o nvim)+abort'"

# Source FZF bash key bindings and completion
source ~/.fzf.bash
