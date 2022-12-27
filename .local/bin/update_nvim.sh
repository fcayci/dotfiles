#!/usr/bin/env bash

if [ ! -d "~/.local/share/nvim/site/pack/plugins/start" ]; then
  mkdir -p ~/.local/share/nvim/site/pack/plugins/start
fi

pushd ~/.local/share/nvim/site/pack/plugins/start

echo "## Setting up fuzzy finder..."
if [ -d "fzf.vim" ]; then
  pushd fzf.vim
  git pull origin master
  popd
else
  git clone https://github.com/junegunn/fzf.vim --depth=1
fi

echo "## Setting up lightline..."
if [ -d "lightline.vim" ]; then
  pushd lightline.vim
  git pull origin master
  popd
else
  git clone https://github.com/itchyny/lightline.vim --depth=1
fi 

echo "## Setting up nerdtree..."
if [ -d "nerdtree" ]; then
  pushd nerdtree
  git pull origin master
  popd
else
  git clone https://github.com/preservim/nerdtree.git --depth=1
fi

echo "## Setting up vim-commentary..."
if [ -d "vim-commentary" ]; then
  pushd vim-commentary
  git pull origin master
  popd
else
  git clone https://github.com/tpope/vim-commentary --depth=1
  vim -u NONE -c "helptags commentary/doc" -c q
fi

echo "## Setting up taglist..."
if [ -d "taglist" ]; then
  pushd taglist
  git pull origin master
  popd
else
  git clone https://github.com/yegappan/taglist --depth=1
fi

echo "## Setting up vim-fugitive..."
if [ -d "vim-fugitive" ]; then
  pushd vim-fugitive
  git pull origin master
  popd
else
  git clone https://github.com/tpope/vim-fugitive --depth=1
  vim -u NONE -c "helptags fugitive/doc" -c q
fi

echo "## Setting up rust.vim..."
if [ -d "rust.vim" ]; then
  pushd rust.vim
  git pull origin master
  popd
else
  git clone https://github.com/rust-lang/rust.vim --depth=1
fi

echo "## Setting up coc.nvim..."
if [ -d "coc.nvim" ]; then
  pushd coc.nvim
  git pull origin release
  nvim -u NONE -c "helptags coc.nvim/doc/" -c q
  popd
else
  git clone --branch release https://github.com/neoclide/coc.nvim.git --depth=1
  nvim -u NONE -c "helptags coc.nvim/doc/" -c q
fi

popd
echo "Done..."
