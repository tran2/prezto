#!/bin/zsh
# set zsh as default shell
STR = grep "^$USER" /etc/passwd
SUB = 'zsh'
if [[ "$STR" == *"$SUB"* ]]; then
  echo "zsh already default"
else
  echo "Setting zsh as default"
  chsh -s $(which zsh)
fi

echo "Linking dotfiles"

setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
ln -s "${ZDOTDIR:-$HOME}/.zprezto/tmux/tmux.conf" "${ZDOTDIR:-$HOME}/.tmux.conf"
ln -s "${ZDOTDIR:-$HOME}/.zprezto/vim/vimrc" "${ZDOTDIR:-$HOME}/.vimrc"
# for neovim
mkdir "${ZDOTDIR:-$HOME}/.config/nvim"
ln -s "${ZDOTDIR:-$HOME}/.zprezto/vim/vimrc" "${ZDOTDIR:-$HOME}/.config/nvim/init.vim"
ln -s "${ZDOTDIR:-$HOME}/.zprezto/ctags/ctags" "${ZDOTDIR:-$HOME}/.ctags"

touch $HOME/.zshrc.local;

# $(which zsh)

echo "Installing dependencies"
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  os=$(awk -F= '/^NAME/{print $2}' /etc/os-release)
  if [ os="Ubuntu" ]; then
    echo "installing for Ubuntu"
    echo "attempting to install python"
    sudo apt-get install python python3 -y
    echo "attempting to install neovim"
    sudo apt-get install neovim python-neovim python3-neovim -y
    echo "installing powerline fonts"
    sudo apt-get install fonts-powerline -y
    echo "attempting to install nvm"
    sudo apt-get install curl -y
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

    echo "install ripgrep, ag, xsel"
    sudo apt install ripgrep silversearcher-ag xsel -y
  fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "MacOS"
  # TODO: check macos
  # install brew
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # install neovim
  brew install neovim
  brew install ripgrep
  brew install the_silver_searcher
  echo "Installing powerline fonts from git"
  git clone https://github.com/powerline/fonts.git "${ZDOTDIR:-$HOME}/fonts"
  ${ZDOTDIR:-$HOME}/fonts/install.sh
fi

echo "Adding vimplug for vim and plugins"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

echo "adding tmux"
"${ZDOTDIR:-$HOME}"/.zprezto/install_tmux.zsh
git clone https://github.com/tmux-plugins/tpm "${ZDOTDIR:-$HOME}"/.tmux/plugins/tpm

echo "Please do nvm install <node-version>"
echo "Done! Check if there are errors, else reload the terminal for changes"




