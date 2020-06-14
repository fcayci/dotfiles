" .vimrc

"---------"
" Plugins "
"---------"

" preservim/nerdtree
map <F2> :NERDTreeToggle<CR>

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" itchyny/lightline.vim
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'nord',
      \ 'active': {
      \   'left': [
      \     [ 'mode', 'paste' ],
      \     [ 'fugitive', 'filename' ]
      \   ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightlineFugitive',
      \   'readonly': 'LightlineReadonly',
      \   'modified': 'LightlineModified',
      \   'filename': 'LightlineFilename'
      \ },
      \ 'separator': {
      \   'left': '',
      \   'right': ''
      \ },
      \ 'subseparator': {
      \   'left': '',
      \   'right': ''
      \ }
    \ }

function! LightlineModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! LightlineReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return ""
  else
    return ""
  endif
endfunction

function! LightlineFugitive()
  if exists("*fugitive#head")
    let branch = fugitive#head()
    return branch !=# '' ? ' '.branch : ''
  endif
  return ''
endfunction

function! LightlineFilename()
  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
       \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
       \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

"
" preservim/nerdcommenter
" Add spaces after comment delimiters
let g:NERDSpaceDelims = 1

"
" ale
" dense-analysis/ale
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0

"
" junegunn/fzf 
" junegunn/fzf.vim

" For inserting links for zettel
" make_note_link: List -> Str
" returned string: [Title](YYYYMMDDHH.md)
function! s:make_note_link(l)
  " fzf#vim#complete returns a list with all info in index 0
  let line = split(a:l[0], ':')
  let ztk_id = l:line[0]
  try
    let ztk_title = substitute(l:line[2], '\#\+\s\+', '', 'g')
  catch
    let ztk_title = substitute(l:line[1], '\#\+\s\+', '', 'g')
  endtry
    let mdlink = "[" . ztk_title ."](". ztk_id .")"
    return mdlink
endfunction

" mnemonic link zettel
inoremap <expr> <c-l>z fzf#vim#complete({
  \ 'source':  'rg --no-heading --smart-case  .',
  \ 'reducer': function('<sid>make_note_link'),
  \ 'options': '--multi --reverse --margin 15%,0',
  \ 'up':    5})

command! -bang -nargs=* Ag
  \ call fzf#vim#grep(
  \   'ag --column --numbers --noheading --color --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" open files
map ; :Files<CR>
nnoremap <leader>t :call fzf#vim#files(FindRootDirectory())<CR>

" Zettelkasten work flow
let g:zettelkasten = "/tank/notebooks/"

command! -nargs=1 NewNote :execute ":e" zettelkasten . strftime("%Y%m%d%H%M") . "-<args>.md"

"----------------"
" Configurations "
"----------------"

set tags=./tags,tags;$HOME

"syntax enable
colorscheme nord

filetype on
filetype plugin on
filetype indent on

set autochdir
set binary
set nobackup
set nocompatible
set noswapfile
set nowb
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set ttyfast
set viminfo=
set updatetime=250

if has("gui_running")
  set mouse=a
endif

" UI
set ffs=unix,dos,mac
set gfn=Source\ Code\ Pro\ Regular\ 12
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=L
set termguicolors
set hidden
set laststatus=2
set lazyredraw
set noerrorbells
set noshowmode
set novisualbell
set number
set ruler
"set rulerformat=%l/%L(%p%%),%c   " a better ruler
set t_vb=
set tm=500
set wildmenu
set wildignore=*~,*.pyc
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*

"+--- Editor ---+
set autoindent
set backspace=indent,eol,start
set cursorline
set colorcolumn=160
set foldcolumn=1
set foldenable
set foldlevelstart=10
"set guicursor=a:ver25-Cursor/lCursor
set linebreak
set list
"set listchars=tab:→ ,space:·
"set listchars=eol:¬,space:·,tab:»\
set listchars=tab:» ,space:·
set magic
set mat=2
set showmatch
"set textwidth=160

"set showcmd
"set autoread
set splitbelow splitright " More intuitive than default split behavior
set nojoinspaces          " Use only one space after period when joining lines

" Toggle the sign column automatically when there are signs available to display.
set signcolumn=auto
set smartindent
set smarttab
set softtabstop=4 " (sts)
set tabstop=4 " (ts)
set shiftwidth=4
set expandtab " fill with spaces
"set noexpandtab " fill with tabs

" Automatically wrap left and right.
" This allows to move the cursor to the previous/next line after reaching first/last character in the line using the arrow keys in normal-, insert- (<,>) and visual mode ([,]) or the h and l keys.
set whichwrap+=<,>,h,l,[,]
set wrap

"+--- Search ---+
set ignorecase
"set smartcase
set hlsearch
set incsearch

" Shows syntax highlighting groups for the current cursor position
nmap <C-S-K> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

"search will center on the line it is found in
nnoremap n nzzzv
nnoremap N Nzzzv

" Remove trailing whitespace on save
"autocmd BufWritePre * %s/\s\+$//e
augroup TrailingSpaces
    autocmd!
    autocmd BufWritePre *.{py,vhd,v,html,js,json,c,cpp,h,hpp,lua} let w:wv = winsaveview() | %s/\s\+$//e | call winrestview(w:wv)
augroup END

" Open buffer
nnoremap gb :ls<CR>:b<space>
set pastetoggle=<F3>
map <F4> :let &background = ( &background == "dark" ? "light" : "dark" )<CR>
nnoremap <F5> :set nonumber!<CR>:set foldcolumn=0<CR>
map <F7> :TlistToggle<CR>
map <F10> <ESC>ggg?G``

" Compile and run keymappings
au FileType python map <F6> :!python3 %<CR>
au FileType html,xhtml map <F6> :!firefox %<CR>
au FileType tex map <F6> :!texi2pdf -c %<CR>

" mutt
au BufRead /tmp/mutt-* setlocal fo+=aw
" .config/nvim/init.vim

"
" Plugins
"

"
" preservim/nerdtree
map <F2> :NERDTreeToggle<CR>

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" itchyny/lightline.vim
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'nord',
      \ 'active': {
      \   'left': [
      \     [ 'mode', 'paste' ],
      \     [ 'fugitive', 'filename' ]
      \   ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightlineFugitive',
      \   'readonly': 'LightlineReadonly',
      \   'modified': 'LightlineModified',
      \   'filename': 'LightlineFilename'
      \ },
      \ 'separator': {
      \   'left': '',
      \   'right': ''
      \ },
      \ 'subseparator': {
      \   'left': '',
      \   'right': ''
      \ }
    \ }

function! LightlineModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! LightlineReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return ""
  else
    return ""
  endif
endfunction

function! LightlineFugitive()
  if exists("*fugitive#head")
    let branch = fugitive#head()
    return branch !=# '' ? ' '.branch : ''
  endif
  return ''
endfunction

function! LightlineFilename()
  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
       \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
       \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

"
" preservim/nerdcommenter
" Add spaces after comment delimiters
let g:NERDSpaceDelims = 1

"
" ale
" dense-analysis/ale
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0

"
" junegunn/fzf 
" junegunn/fzf.vim

" For inserting links for zettel
" make_note_link: List -> Str
" returned string: [Title](YYYYMMDDHH.md)
function! s:make_note_link(l)
  " fzf#vim#complete returns a list with all info in index 0
  let line = split(a:l[0], ':')
  let ztk_id = l:line[0]
  try
    let ztk_title = substitute(l:line[2], '\#\+\s\+', '', 'g')
  catch
    let ztk_title = substitute(l:line[1], '\#\+\s\+', '', 'g')
  endtry
    let mdlink = "[" . ztk_title ."](". ztk_id .")"
    return mdlink
endfunction

" mnemonic link zettel
inoremap <expr> <c-l>z fzf#vim#complete({
  \ 'source':  'rg --no-heading --smart-case  .',
  \ 'reducer': function('<sid>make_note_link'),
  \ 'options': '--multi --reverse --margin 15%,0',
  \ 'up':    5})

command! -bang -nargs=* Ag
  \ call fzf#vim#grep(
  \   'ag --column --numbers --noheading --color --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" open files
map ; :Files<CR>
nnoremap <leader>t :call fzf#vim#files(FindRootDirectory())<CR>

" Zettelkasten work flow
let g:zettelkasten = "/tank/notebooks/"

command! -nargs=1 NewNote :execute ":e" zettelkasten . strftime("%Y%m%d%H%M") . "-<args>.md"

"
" Configurations
"

set tags=./tags,tags;$HOME

"syntax enable
colorscheme nord

filetype on
filetype plugin on
filetype indent on

set autochdir
set binary
set nobackup
set nocompatible
set noswapfile
set nowb
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set ttyfast
set viminfo=
set updatetime=250

if has("gui_running")
  set mouse=a
endif

" UI
set ffs=unix,dos,mac
set gfn=Source\ Code\ Pro\ Regular\ 12
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=L
set termguicolors
set hidden
set laststatus=2
set lazyredraw
set noerrorbells
set noshowmode
set novisualbell
set number
set ruler
"set rulerformat=%l/%L(%p%%),%c   " a better ruler
set t_vb=
set tm=500
set wildmenu
set wildignore=*~,*.pyc
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*

"+--- Editor ---+
set autoindent
set backspace=indent,eol,start
set cursorline
set colorcolumn=160
set foldcolumn=1
set foldenable
set foldlevelstart=10
"set guicursor=a:ver25-Cursor/lCursor
set linebreak
set list
"set listchars=tab:→ ,space:·
"set listchars=eol:¬,space:·,tab:»\
set listchars=tab:» ,space:·
set magic
set mat=2
set showmatch
"set textwidth=160

"set showcmd
"set autoread
set splitbelow splitright " More intuitive than default split behavior
set nojoinspaces          " Use only one space after period when joining lines

" Toggle the sign column automatically when there are signs available to display.
set signcolumn=auto
set smartindent
set smarttab
set softtabstop=4 " (sts)
set tabstop=4 " (ts)
set shiftwidth=4
set expandtab " fill with spaces
"set noexpandtab " fill with tabs

" Automatically wrap left and right.
" This allows to move the cursor to the previous/next line after reaching first/last character in the line using the arrow keys in normal-, insert- (<,>) and visual mode ([,]) or the h and l keys.
set whichwrap+=<,>,h,l,[,]
set wrap

"+--- Search ---+
set ignorecase
"set smartcase
set hlsearch
set incsearch

" Shows syntax highlighting groups for the current cursor position
nmap <C-S-K> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

"search will center on the line it is found in
nnoremap n nzzzv
nnoremap N Nzzzv

" Remove trailing whitespace on save
"autocmd BufWritePre * %s/\s\+$//e
augroup TrailingSpaces
    autocmd!
    autocmd BufWritePre *.{py,vhd,v,html,js,json,c,cpp,h,hpp,lua} let w:wv = winsaveview() | %s/\s\+$//e | call winrestview(w:wv)
augroup END

" Open buffer
nnoremap gb :ls<CR>:b<space>
set pastetoggle=<F3>
map <F4> :let &background = ( &background == "dark" ? "light" : "dark" )<CR>
nnoremap <F5> :set nonumber!<CR>:set foldcolumn=0<CR>
map <F7> :TlistToggle<CR>
map <F10> <ESC>ggg?G``

" Compile and run keymappings
au FileType python map <F6> :!python3 %<CR>
au FileType html,xhtml map <F6> :!firefox %<CR>
au FileType tex map <F6> :!texi2pdf -c %<CR>

" mutt
au BufRead /tmp/mutt-* setlocal fo+=aw
