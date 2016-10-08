#!/usr/bin/zsh
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
ln -s "${ZDOTDIR:-$HOME}/.zprezto/tmux/tmux.conf" "${ZDOTDIR:-$HOME}/.tmux.conf"
ln -s "${ZDOTDIR:-$HOME}/.zprezto/vim/vimrc" "${ZDOTDIR:-$HOME}/.vimrc"

git clone https://github.com/VundleVim/Vundle.vim.git "${ZDOTDIR:-$HOME}/.vim/bundle/Vundle.vim"
vim +PluginInstall +qall
