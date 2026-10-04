#!/bin/zsh

# Define color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No color

function print_message() {
    MESSAGE=$1
    COLOR=$2
    printf "${COLOR}${MESSAGE}${NC}\n"
}

# returns 0 (and prints a note) if the command is already available
function already_installed() {
    if command -v "$1" >/dev/null 2>&1; then
        print_message "$1 already installed at $(command -v $1), skipping" $GREEN
        return 0
    fi
    return 1
}

# check andd set zsh as default shell
if [ "$SHELL" = "/bin/zsh" ] || [ "$SHELL" = "/usr/bin/zsh" ]; then
  print_message "zsh already default" $GREEN
else
  echo "Setting zsh as default"
  chsh -s $(which zsh)
fi

echo "Linking dotfiles"

setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -sf "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
ln -sf "${ZDOTDIR:-$HOME}/.zprezto/tmux/tmux.conf" "${ZDOTDIR:-$HOME}/.tmux.conf"
ln -sf "${ZDOTDIR:-$HOME}/.zprezto/vim/vimrc" "${ZDOTDIR:-$HOME}/.vimrc"
# for neovim
mkdir -p "${ZDOTDIR:-$HOME}/.config/nvim"
# ln -s "${ZDOTDIR:-$HOME}/.zprezto/vim/vimrc" "${ZDOTDIR:-$HOME}/.config/nvim/init.vim"
git clone git@github.com:tran2/LazyVimConfig.git "${ZDOTDIR:-$HOME}/.config/nvim"

ln -sf "${ZDOTDIR:-$HOME}/.zprezto/ctags/ctags" "${ZDOTDIR:-$HOME}/.ctags"

ln -sf "${ZDOTDIR:-$HOME}/.zprezto/other/.ideavimrc" "${ZDOTDIR:-$HOME}/.ideavimrc"

ln -sf "${ZDOTDIR:-$HOME}/.zprezto/other/wezterm.lua" "${ZDOTDIR:-$HOME}/.wezterm.lua"

# ghostty
mkdir -p "${ZDOTDIR:-$HOME}/.config/ghostty"
ln -sf "${ZDOTDIR:-$HOME}/.zprezto/other/ghostty.config" "${ZDOTDIR:-$HOME}/.config/ghostty/config"

# herdr
mkdir -p "${ZDOTDIR:-$HOME}/.config/herdr"
ln -sf "${ZDOTDIR:-$HOME}/.zprezto/other/herdr.config" "${ZDOTDIR:-$HOME}/.config/herdr/config.toml"

touch $HOME/.zshrc.local;

# $(which zsh)

echo "Installing dependencies"
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  os=$(awk -F= '/^NAME/{print $2}' /etc/os-release | tr -d '"')
  if [ "$os" = "Ubuntu" ] || [ "$os" = "Linux Mint" ]; then
    echo "installing for Ubuntu"
    echo "attempting to install python"
    sudo apt-get install python3 -y
    echo "attempting to install neovim"
    already_installed nvim || sudo apt-get install neovim -y
    sudo apt-get install python3-pynvim -y
    echo "installing powerline fonts"
    sudo apt-get install fonts-powerline -y
    echo "attempting to install nvm"
    sudo apt-get install curl -y
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

    echo "install ripgrep, ag, fzf, xsel"
    sudo apt install ripgrep silversearcher-ag xsel -y
    already_installed fzf || sudo apt install fzf -y
  elif [ "$os" = "Fedora Linux" ] || [ "$os" = "Fedora" ]; then
    echo "installing for Fedora"
    echo "attempting to install python and neovim"
    sudo dnf install -y python3 python3-neovim
    already_installed nvim || sudo dnf install -y neovim
    echo "installing powerline fonts"
    sudo dnf install -y powerline-fonts
    echo "attempting to install nvm"
    sudo dnf install -y curl
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

    echo "install ripgrep, ag, fzf, xsel"
    sudo dnf install -y ripgrep the_silver_searcher xsel
    already_installed fzf || sudo dnf install -y fzf
  fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
  print_message "MacOS"

  # install brew
  if [[ $(command -v brew) == "" ]]; then
    print_message "Homebrew is not installed. Installing now..." $GREEN
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || {
      print_message "Homebrew installation failed." $RED
      exit 1
    }
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    source ~/.zprofile
    print_message "Homebrew installation complete." $GREEN
  else
    print_message "Homebrew is already installed." $GREEN
  fi

  # install neovim
  already_installed nvim || brew install neovim || { print_message "neovim install failed" $RED }
  already_installed fzf || brew install fzf
  brew install ripgrep
  brew install the_silver_searcher
  print_message "Installing powerline fonts from git"
  git clone https://github.com/powerline/fonts.git "${ZDOTDIR:-$HOME}/fonts"
  ${ZDOTDIR:-$HOME}/fonts/install.sh

  # install nerdfont
  brew tap homebrew/cask-fonts
  brew install font-hack-nerd-font font-jetbrains-mono-nerd-font
fi

# print_message "Adding vimplug for vim and plugins"
# sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
#        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
# print_message "Make sure to install the plugs (might need nodejs)"

echo "adding tmux"
"${ZDOTDIR:-$HOME}"/.zprezto/install_tmux.zsh
git clone https://github.com/tmux-plugins/tpm "${ZDOTDIR:-$HOME}"/.tmux/plugins/tpm

echo "Please do nvm install <node-version>"
echo "Done! Check if there are errors, else reload the terminal for changes"




