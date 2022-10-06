#!/usr/bin/env bash

if [ ! -d "~/.local/share/nvim/site/pack/plugins/start" ]; then
  mkdir -p ~/.local/share/nvim/site/pack/plugins/start
fi

cd ~/.local/share/nvim/site/pack/plugins/start

echo "## Setting up fuzzy finder..."
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

echo "## Setting up vim-commentary..."
if [ -d "vim-commentary" ]; then
  cd vim-commentary
  git pull origin master
  cd ..
else
  git clone https://github.com/tpope/vim-commentary
  vim -u NONE -c "helptags commentary/doc" -c q
fi

echo "## Setting up taglist..."
if [ -d "taglist" ]; then
  cd taglist
  git pull origin master
  cd ..
else
  git clone https://github.com/yegappan/taglist
fi

echo "## Setting up vim-fugitive..."
if [ -d "vim-fugitive" ]; then
    cd vim-fugitive
    git pull origin master
    cd ..
else
    git clone https://github.com/tpope/vim-fugitive
    vim -u NONE -c "helptags fugitive/doc" -c q
fi

echo "Done..."
