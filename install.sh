#!/bin/bash

cp .screenrc ~/.screenrc
cp .gitconfig ~/.gitconfig
cp .zshrc ~/.zshrc
# TODO instalacja vifm

cp -r .vim ~/.vim
cp .vimrc ~/.vimrc
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

# usefull programs shutter (screenshot), simple screen recorder, ncdu (ncurses du)
# binwalk, 
