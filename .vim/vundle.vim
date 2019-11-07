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
" autocomplete
"Plugin 'davidhalter/jedi-vim'
" typescript support
"Plugin 'leafgarland/typescript-vim'
" javascript support
"Plugin 'pangloss/vim-javascript'
"Bundle 'Valloric/YouCompleteMe'
" hexmode. open with -b
Plugin 'fidian/hexmode'

call vundle#end()            " required

filetype plugin indent on    " required

" YouCompleteMe
"let g:clang_complete_copen=1
"let g:clang_hl_errors=1

" Hexmode
nnoremap <C-H> :Hexmode<CR>
inoremap <C-H> <Esc>:Hexmode<CR>
vnoremap <C-H> :<C-U>Hexmode<CR>

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
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.vim$', '\~$', '\.git$', '.DS_Store']

autocmd vimenter * NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
nnoremap <F2> :NERDTreeToggle<CR>

" syntastic setup
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

"let g:syntastic_quiet_messages = {
"    \ 'regex': [ 'snake_case', 'invalid-name', 'line-too-long', 'too-many-arguments']
"    \ }

" Goyo and LimeLight integration
"autocmd! User GoyoEnter Limelight
"autocmd! User GoyoLeave Limelight!

" Auto enable indent guides
"let g:indent_guides_enable_on_vim_startup = 0
"let g:indent_guides_auto_colors = 0
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=darkgrey
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=grey
