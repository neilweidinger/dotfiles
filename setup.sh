#!/usr/bin/env bash

# how to make idempotent bash scripts:
# https://arslan.io/2019/07/03/how-to-write-idempotent-bash-scripts/

# get absolute path to dotfiles directory
DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit ; pwd -P )"

# install command line tools
xcode-select -p >/dev/null 2>&1 || xcode-select --install

# install homebrew
brew --version >/dev/null 2>&1 || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# install homebrew packages, casks, etc.
while true; do
    read -rp $'Uninstall dependencies not listed in Brewfile?\n(yes/no) ' answer
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

# config files found in `~/.config`
mkdir -p ~/.config
ln -snfFv "$DIR"/config/alacritty ~/.config/alacritty
ln -snfFv "$DIR"/config/bat ~/.config/bat
ln -snfFv "$DIR"/config/karabiner ~/.config/karabiner
ln -snfFv "$DIR"/config/neofetch ~/.config/neofetch
ln -snfFv "$DIR"/config/neovim-config ~/.config/nvim
ln -snfFv "$DIR"/config/ranger-config ~/.config/ranger

# other symlinks not in `~/.config`
ln -snfFv "$(brew --prefix --installed llvm)"/bin/clangd /usr/local/bin/clangd
ln -snfFv "$DIR"/bash_profile ~/.bash_profile
ln -snfFv "$DIR"/git/gitattributes ~/.gitattributes
ln -snfFv "$DIR"/git/gitconfig ~/.gitconfig
ln -snfFv "$DIR"/lldb/lldbinit ~/.lldbinit
ln -snfFv "$DIR"/tmux/tmux.conf ~/.tmux.conf

# we do this here once in `setup.sh` to avoid having to do the costy `brew --prefix` on each source
# of `.bash_profile`
ln -snfFv "$(brew --prefix --installed git)"/etc/bash_completion.d/git-completion.bash  ~/.git-completion.bash
ln -snfFv "$(brew --prefix --installed git)"/etc/bash_completion.d/git-prompt.sh ~/.git-prompt.sh

# automator services
mkdir -p ~/Library/Services
for file in "$DIR"/automator/Services/*
do
    # bash parameter expansion to get file basename
    # https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html
    # use double quotes to preserve spaces
    ln -snfFv "$file" ~/Library/Services/"${file##*/}"
done

# install fzf bash integrations
"$(brew --prefix --installed fzf)"/install --key-bindings --completion --update-rc --no-zsh --no-fish

# install vim-plug
if [ ! -f ~/".local/share/nvim/site/autoload/plug.vim" ]; then
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi

# install neovim plugins
nvim --headless +PlugInstall +qall

# copy custom vim airline theme
mkdir -p ~/.local/share/nvim/plugged/vim-airline-themes/autoload/airline/themes
ln -snfv "$DIR"/vim-airline-theme/luna_neil.vim ~/.local/share/nvim/plugged/vim-airline-themes/autoload/airline/themes/luna_neil.vim

# install patched font
cp -v "$DIR"/fonts/Menlo\ Patched.ttf ~/Library/Fonts/Menlo\ Patched.ttf

# install rectangle preferences
ln -snfv "$DIR"/rectangle/com.knollsoft.Rectangle.plist ~/Library/Preferences/com.knollsoft.Rectangle.plist

# set default shell to brew installed bash
# https://apple.stackexchange.com/a/292760/374139
# https://stackoverflow.com/a/3557165
# https://unix.stackexchange.com/a/4337/416001
grep -qxF '/usr/local/bin/bash' /etc/shells || echo '/usr/local/bin/bash' | sudo tee -a /etc/shells > /dev/null
chsh -s /usr/local/bin/bash

# source `~/.bash_profile` as final step
source ~/.bash_profile
