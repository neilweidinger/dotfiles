#!/bin/bash

# install command line tools
xcode-select -p >/dev/null 2>&1 || xcode-select --install

# install homebrew
brew --version >/dev/null 2>&1 || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# install homebrew packages, casks, etc.
brew bundle install homebrew/Brewfile

# tmux plugin manager
if [ ! -d "~/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# tmux config file
ln -snfv tmux/tmux.conf ~/.tmux.conf

# git config
ln -snfv git/gitconfig ~/.gitconfig

# git prompt and completion scripts
ln -snfv git/git-completion.bash ~/git-completion.bash
ln -snfv git/git-prompt.sh ~/git-prompt.sh

# config directories
ln -snfv config/bat ~/.config/bat
ln -snfv config/karabiner ~/.config/karabiner
ln -snfv config/neofetch ~/.config/neofetch
ln -snfv config/neovim-config ~/.config/nvim
ln -snfv config/ranger-config ~/.config/ranger

# install fzf bash integrations
$(brew --prefix)/opt/fzf/install

# bash profile
ln -snfv bash_profile ~/.bash_profile
source ~/.bash_profile
