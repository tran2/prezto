#!/bin/zsh
# set zsh as default shell
echo "Setting zsh as default"
chsh -s $(which zsh)

echo "Linking dotfiles"

#setopt EXTENDED_GLOB
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

echo "Installing neovim"
os=$(awk -F= '/^NAME/{print $2}' /etc/os-release)
if [ os="Ubuntu" ]; then
  echo "installing for Ubuntu"
  sudo add-apt-repository ppa:neovim-ppa/stable -y
  sudo apt-get update -y
  sudo apt-get install neovim -y
  echo "installing powerline fonts"
  sudo apt-get install fonts-powerline -y
else
  # TODO: check macos
  # install brew
  # install neovim
  brew install ripgrep
  brew install the_silver_searcher
  echo "Installing powerline fonts from git"
  git clone https://github.com/powerline/fonts.git "${ZDOTDIR:-$HOME}/fonts
  "${ZDOTDIR:-$HOME}/fonts/install.sh
fi

echo "Adding Vundle for vim and plugins"
git clone https://github.com/VundleVim/Vundle.vim.git "${ZDOTDIR:-$HOME}/.vim/bundle/Vundle.vim"
vim +PluginInstall +qall

"${ZDOTDIR:-$HOME}"/install_tmux.zsh



