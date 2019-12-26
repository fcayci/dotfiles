" ~/.vim/config.vim

syntax on
set encoding=utf-8
set visualbell t_vb=      " Turn off bell

set nobackup

colorscheme yin

" show whitespaces
set list
set listchars=tab:→ ,space:·

set showcmd               " In Visual mode, show selected characters, lines, etc
set wildmenu              " Turn on menu-based tab completion for commands
set autoread              " Read file if it has changed outside of Vim
set splitbelow splitright " More intuitive than default split behavior
set noswapfile            " Not much need for swapfiles in the 21st century
set nojoinspaces          " Use only one space after period when joining lines

" Use TABs
" set tabstop=4     " Size of a hard tabstop (ts).
" set shiftwidth=4  " Size of an indentation (sw).
" set noexpandtab   " Always uses tabs instead of space characters (noet).

" Use Spaces
set tabstop=4     " Size of a hard tabstop (ts).
set shiftwidth=4  " Size of an indentation (sw).
set softtabstop=0 " Number of spaces a <Tab> counts for. When 0, featuer is off (sts).
set smarttab      " Inserts blanks on a <Tab> key (as per sw, ts and sts).
set expandtab     " Always uses spaces instead of tab characters (et).

set autoindent    " Copy indent from current line when starting a new line.

set number                " show line numbers
set showmode              " show mode at bottom of screen
set hlsearch              " highlight all search results
set incsearch             " increment search
set ignorecase            " case-insensitive search
"set smartcase             " upper-case sensitive search
set laststatus=2
"set paste
"set runtimepath+=/usr/share/vim
set mouse=a

set ruler                        " show me where the cursor is
set rulerformat=%l/%L(%p%%),%c   " a better ruler
set showmatch                    " show matching brackets

"search will center on the line it is found in
nnoremap n nzzzv
nnoremap N Nzzzv

" Remove trailing whitespace on save
"autocmd BufWritePre * %s/\s\+$//e
augroup TrailingSpaces
    autocmd!
    autocmd BufWritePre *.{py,vhd,v,html,js,json,c,cpp,h,hpp,lua} let w:wv = winsaveview() | %s/\s\+$//e | call winrestview(w:wv)
augroup END

" Toggle dark/light default color theme for shitty terms
map <F3> :let &background = ( &background == "dark" ? "light" : "dark" )<CR>

" toggle on/off line numbers by pressing F* key
nnoremap <F5> :set nonumber!<CR>:set foldcolumn=0<CR>

" apply rot13 for people snooping over shoulder, good fun
map <F10> <ESC>ggg?G``

" Compile and run keymappings
au FileType php map <F6> :!php %<CR>
au FileType python map <F6> :!python3 %<CR>
au FileType perl map <F6> :!perl %<CR>
au FileType ruby map <F6> :!ruby %<CR>
au FileType lua map <F6> :!lua %<CR>
au FileType html,xhtml map <F6> :!firefox %<CR>
au FileType tex map <F6> :!texi2pdf -c %<CR>

" screen
if !has("gui_running")
  if &term == "screen"
    imap <C-Right> <ESC>:bn<RETURN>
    imap <C-Left> <ESC>:bp<RETURN>
  endif
  set vb
endif

" For gvim gui
if has("gui_running")
  " colorscheme lucius
  " Change tabs using Shift right & left
  nnoremap <S-Left> :tabprevious<CR>
  nnoremap <S-Right> :tabnext<CR>
  set guioptions-=T " Removes top toolbar
  set guioptions-=r " Removes right hand scroll bar
  set go-=L " Removes left hand scroll bar
  set guioptions-=m
endif
