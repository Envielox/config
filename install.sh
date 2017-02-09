#!/bin/bash

cp .screenrc ~/.screenrc
cp .gitconfig ~/.gitconfig
cp .zshrc ~/.zshrc

cp -r .vim ~/.vim
cp .vimrc ~/.vimrc
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

