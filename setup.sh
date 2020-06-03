#!/bin/bash

# get absolute path to dotfiles directory
DIR="$(cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd | sed 's/\(^.*dotfiles\).*/\1/')"

# install command line tools
xcode-select -p >/dev/null 2>&1 || xcode-select --install

# install homebrew
brew --version >/dev/null 2>&1 || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# install homebrew packages, casks, etc.
brew bundle install -v --file homebrew/Brewfile

# tmux config file
ln -snfv $DIR/tmux/tmux.conf ~/.tmux.conf

# git config
ln -snfv $DIR/git/gitconfig ~/.gitconfig

# git prompt and completion scripts
ln -snfv $DIR/git/git-completion.bash ~/git-completion.bash
ln -snfv $DIR/git/git-prompt.sh ~/git-prompt.sh

# config directories
ln -snfv $DIR/config/bat ~/.config/bat
ln -snfv $DIR/config/karabiner ~/.config/karabiner
ln -snfv $DIR/config/neofetch ~/.config/neofetch
ln -snfv $DIR/config/neovim-config ~/.config/nvim
ln -snfv $DIR/config/ranger-config ~/.config/ranger

# install fzf bash integrations
$(brew --prefix)/opt/fzf/install

# install vim-plug
if [ ! -f ~/".local/share/nvim/site/autoload/plug.vim" ]; then
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim \
           --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi

# copy custom vim airline theme
mkdir -p ~/.local/share/nvim/plugged/vim-airline-themes/autoload/airline/themes
ln -snfv $DIR/vim-airline-theme/luna_neil.vim ~/.local/share/nvim/plugged/vim-airline-themes/autoload/airline/themes/luna_neil.vim

# install patched font
ln -snfv $DIR/fonts/Menlo\ Patched.ttf ~/Library/Fonts/Menlo\ Patched.ttf

# bash profile
ln -snfv $DIR/bash_profile ~/.bash_profile
source ~/.bash_profile
