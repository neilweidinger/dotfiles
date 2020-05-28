#!/bin/bash

# install command line tools
xcode-select -p >/dev/null 2>&1 || xcode-select --install

# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# install homebrew packages, casks, etc.
brew bundle homebrew/Brewfile

# tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# tmux config file
ln -sv tmux/tmux.conf ~/.tmux.conf

# git config
ln -sv git/gitconfig ~/.gitconfig

# git prompt and completion scripts
ln -sv git/git-completion.bash ~/git-completion.bash
ln -sv git/git-prompt.sh ~/git-prompt.sh

# config directories
ln -sv config/bat ~/.config/bat
ln -sv config/karabiner ~/.config/karabiner
ln -sv config/neofetch ~/.config/neofetch
ln -sv config/neovim-config ~/.config/nvim
ln -sv config/ranger-config ~/.config/ranger

# install fzf bash integrations
$(brew --prefix)/opt/fzf/install

# bash profile
ln -sv bash_profile ~/.bash_profile
source ~/.bash_profile
