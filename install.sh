#!/bin/bash

cp .screenrc ~/.screenrc
cp .gitconfig ~/.gitconfig
cp .zshrc ~/.zshrc

cp -r .vim ~/.vim
cp .vimrc ~/.vimrc


wget -P ~/.vim/spell/ http://ftp.vim.org/vim/runtime/spell/en.utf-8.spl
wget -P ~/.vim/spell/ http://ftp.vim.org/vim/runtime/spell/pl.utf-8.spl

mkdir ~/.fonts
cp SourceCodePro-powerline/* ~/.fonts/
fc-cache -fv

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

