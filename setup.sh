#!/bin/bash

# get absolute path to dotfiles directory
DIR="$(cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd | sed 's/\(^.*dotfiles\).*/\1/')"

# install command line tools
xcode-select -p >/dev/null 2>&1 || xcode-select --install

# install homebrew
brew --version >/dev/null 2>&1 || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# install homebrew packages, casks, etc.
while true; do
    read -p $'Uninstall dependencies not listed in Brewfile?\n(yes/no) ' answer
    case $answer in
        [Yy]* )
            brew bundle install -v -f --cleanup --file homebrew/Brewfile
            break
            ;;
        [Nn]* )
            brew bundle install -v --file homebrew/Brewfile
            break
            ;;
        * )
            echo "Please answer yes or no."
            ;;
    esac
done

# tmux config file
ln -snfv $DIR/tmux/tmux.conf ~/.tmux.conf

# git config
ln -snfv $DIR/git/gitconfig ~/.gitconfig

# git prompt and completion scripts
ln -snfv $DIR/git/git-completion.bash ~/git-completion.bash
ln -snfv $DIR/git/git-prompt.sh ~/git-prompt.sh

# config directories
rm -rf ~/.config/bat
ln -snfv $DIR/config/bat ~/.config/bat
rm -rf ~/.config/karabiner
ln -snfv $DIR/config/karabiner ~/.config/karabiner
rm -rf ~/.config/neofetch
ln -snfv $DIR/config/neofetch ~/.config/neofetch
rm -rf ~/.config/nvim
ln -snfv $DIR/config/neovim-config ~/.config/nvim
rm -rf ~/.config/ranger
ln -snfv $DIR/config/ranger-config ~/.config/ranger
rm -rf ~/.config/alacritty
ln -snfv $DIR/config/alacritty ~/.config/alacritty
rm -rf ~/.config/spotifyd
ln -snfv $DIR/config/spotifyd ~/.config/spotifyd

# install fzf bash integrations
$(brew --prefix)/opt/fzf/install

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

# make clangd available on the command line (brew link llvm not used on purpose
# to avoid making *all* llvm tools available, we only want clangd)
ln -snfv /usr/local/Cellar/llvm/10.0.0_3/bin/clangd /usr/local/bin/clangd

# install patched font
cp -v $DIR/fonts/Menlo\ Patched.ttf ~/Library/Fonts/Menlo\ Patched.ttf

# install rectangle preferences
ln -snfv $DIR/rectangle/com.knollsoft.Rectangle.plist ~/Library/Preferences/com.knollsoft.Rectangle.plist

# bash profile
ln -snfv $DIR/bash_profile ~/.bash_profile
source ~/.bash_profile
