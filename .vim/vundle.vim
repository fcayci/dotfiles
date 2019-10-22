" ~/.vim/vundle.vim

filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
" notorious tree
Plugin 'scrooloose/nerdtree'
" Automatic syntax checking
"Plugin 'scrooloose/syntastic'
" Fuzzy file finder
Plugin 'ctrlpvim/ctrlp.vim'
" Distraction free writing
Plugin 'junegunn/goyo.vim'
" status bar like thingy
Plugin 'itchyny/lightline.vim'
" universal comment toggle
Plugin 'tomtom/tcomment_vim'
"Plugin 'nathanaelkane/vim-indent-guides'
"Plugin 'airblade/vim-gitgutter'
" typescript support
"Plugin 'leafgarland/typescript-vim'
" javascript support
"Plugin 'pangloss/vim-javascript'
"Bundle 'Valloric/YouCompleteMe'

call vundle#end()            " required

filetype plugin indent on    " required

" YouCompleteMe
"let g:clang_complete_copen=1
"let g:clang_hl_errors=1

" Powerline setup
"set guifont=Inconsolata\ for\ Powerline\ 9
"set guifont=Monaco:h12
"set laststatus=2
"let g:Powerline_symbols = 'fancy'

" vim-indent-guides setup
"let g:indent_guides_guide_size = 1
"let g:indent_guides_color_change_percent = 3
"let g:indent_guides_enable_on_vim_startup = 1

" NerdTree setup
autocmd vimenter * NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
nnoremap <F2> :NERDTreeToggle<CR>
