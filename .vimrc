" ~/.vimrc

set nocompatible          " Use vim instead of vi settings; this must come first

source ~/.vim/config.vim  " Core configuration
source ~/.vim/vundle.vim  " Plugins contained within are installed via Vundle
"source ~/.vim/plugins.vim " Plugin-specific configuration

filetype plugin indent on " Load filetype-specific indent and plugin files
