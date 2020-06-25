" .config/nvim/init.vim

"
" Plugins
"

" preservim/nerdtree
map <F2> :NERDTreeToggle<CR>

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let NERDTreeIgnore=['\.pyc$', '\~$']


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


" preservim/nerdcommenter
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1


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

" Zettelkasten work flow
let g:zettelkasten = "/tank/notebooks/"

command! -nargs=1 NewNote :execute ":e" zettelkasten . strftime("%Y%m%d%H%M") . "-<args>.md"


" neoclide/coc.nvim
" Use tab for trigger completion with characters ahead and navigate.
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"
" Configurations
"

set tags=./tags,tags;$HOME

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

" UI configs
if has("gui_running")
  set mouse=a
endif

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
set t_vb=
set tm=500
set wildmenu
set wildignore=*~,*.pyc
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*

" Editor configs
set backspace=indent,eol,start
set cursorline
"set colorcolumn=160
set foldcolumn=1
set foldenable
set foldlevelstart=10
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

set signcolumn=auto
set autoindent
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

" Search configs
set ignorecase
"set smartcase
set hlsearch
set incsearch

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
map <F3> :TlistToggle<CR>
"map <F4> :let &background = ( &background == "dark" ? "light" : "dark" )<CR>
nnoremap <F5> :set nonumber!<CR>:set foldcolumn=0<CR>
set pastetoggle=<F7>
map <F10> <ESC>ggg?G``

" Compile and run keymappings
au FileType python map <F6> :!python %<CR>
au FileType html,xhtml map <F6> :!firefox %<CR>
au FileType tex map <F6> :!texi2pdf -c %<CR>

" mutt
au BufRead /tmp/mutt-* setlocal fo+=aw
