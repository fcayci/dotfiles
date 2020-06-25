#!/usr/bin/env bash

if [ ! -d "~/.local/share/nvim/site/pack/fcayci/start" ]; then
  mkdir -p ~/.local/share/nvim/site/pack/fcayci/start
fi

cd ~/.local/share/nvim/site/pack/fcayci/start

echo "## Setting up fuzzy finder..."
if [ -d "fzf" ]; then
  cd fzf
  git pull origin master
  cd ..
else
  git clone https://github.com/junegunn/fzf
fi
if [ -d "fzf.vim" ]; then
  cd fzf.vim
  git pull origin master
  cd ..
else
  git clone https://github.com/junegunn/fzf.vim
fi

echo "## Setting up lightline..."
if [ -d "lightline.vim" ]; then
  cd lightline.vim
  git pull origin master
  cd ..
else
  git clone https://github.com/itchyny/lightline.vim
fi 

echo "## Setting up nerdtree..."
if [ -d "nerdtree" ]; then
  cd nerdtree
  git pull origin master
  cd ..
else
  git clone https://github.com/preservim/nerdtree.git
fi

echo "## Setting up nerdcommenter..."
if [ -d "nerdcommenter" ]; then
  cd nerdcommenter
  git pull origin master
  cd ..
else
  git clone https://github.com/preservim/nerdcommenter
fi

echo "## Setting up taglist..."
if [ -d "taglist" ]; then
  cd taglist
  git pull origin master
  cd ..
else
  git clone https://github.com/yegappan/taglist
fi

echo "## Setting up coc..."
if [ -d "coc.nvim" ]; then
  cd coc.nvim
  git pull origin release
  cd ..
else
  git clone https://github.com/neoclide/coc.nvim
  cd coc.nvim
  git checkout origin/release
  cd ..
fi

echo "## Installing required packages..."
sudo pacman -Sy neovim ccls python-jedi python-pylint python-pynvim npm nodejs fzf

echo "Done..."
