#!/bin/bash

# get absolute path to dotfiles directory
DIR="$(cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd | sed 's/\(^.*dotfiles\).*/\1/')"

# tmux config file
ln -snfv $DIR/tmux/tmux.conf ~/.tmux.conf

# git config
ln -snfv $DIR/git/gitconfig ~/.gitconfig

# git prompt and completion scripts
ln -snfv $DIR/git/git-completion.bash ~/git-completion.bash
ln -snfv $DIR/git/git-prompt.sh ~/git-prompt.sh

# config directories
# rm -rf ~/.config/bat
# ln -snfv $DIR/config/bat ~/.config/bat
# rm -rf ~/.config/karabiner
# ln -snfv $DIR/config/karabiner ~/.config/karabiner
# rm -rf ~/.config/neofetch
# ln -snfv $DIR/config/neofetch ~/.config/neofetch
rm -rf ~/.config/nvim
ln -snfv $DIR/config/neovim-config ~/.config/nvim
# rm -rf ~/.config/ranger
# ln -snfv $DIR/config/ranger-config ~/.config/ranger

# install vim-plug
if [ ! -f ~/".local/share/nvim/site/autoload/plug.vim" ]; then
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim \
           --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi

# install neovim plugins
nvim --headless +PlugInstall +qall

# copy custom vim airline theme
mkdir -p ~/.local/share/nvim/plugged/vim-airline-themes/autoload/airline/themes
ln -snfv $DIR/vim-airline-theme/luna_neil.vim ~/.local/share/nvim/plugged/vim-airline-themes/autoload/airline/themes/luna_neil.vim

# install patched font
mkdir -p ~/.local/share/fonts
cp -v $DIR/fonts/Menlo\ Patched.ttf ~/.local/share/fonts/Menlo\ Patched.ttf

# bash profile
ln -snfv $DIR/bash_profile ~/.bash_profile
source ~/.bash_profile

# bashrc
ln -snfv $DIR/bashrc ~/.bashrc
source ~/.bashrc
