" .vimrc
" Author: Furkan Cayci

" Essentials       {{{

set nocompatible

filetype on
filetype plugin on
filetype indent on
set omnifunc=syntaxcomplete#Complete

" change leader keys
let mapleader = ","
let maplocalleader = "\\"

" tags locations
set tags=./tags,tags;$HOME

" }}}
" Colorscheme      {{{

" MacOS BigSur Tab fix
"let &t_ZH="\e[3m"
"let &t_ZR="\e[23m"

syntax enable
colorscheme nord

" change bar color
hi StatusLine ctermbg=red ctermfg=white

" terminal fix
" set termguicolors

" }}}
" Basic Options    {{{

" > General           {{{

set encoding=utf-8
set fileencoding=utf-8

" no bells
set novisualbell
set noerrorbells
set t_vb=

set modelines=0
set hidden
set ttyfast
set laststatus=2
set history=1000
set undoreload=10000
set lazyredraw
set matchtime=3
set splitbelow splitright
set shiftround
set title
set colorcolumn=+1
set backspace=indent,eol,start
set nojoinspaces

" show whitespaces
set list

"set listchars=tab:» ,space:·
"set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set listchars=tab:▸\ ,extends:❯,precedes:❮

" show trailing whitespace:
"au BufWinEnter * :set listchars+=trail:·

set linebreak
set showbreak=↪

" don't highlight longer than x chars
set synmaxcol=800

" set text width to x characters
"set textwidth=80

set magic
set mat=2

" show ruler on the status bar
set ruler

" show the line number of the current line
set number

" show the relative numbers
set relativenumber

" better Completion
set complete=.,w,b,u,t
set completeopt=longest,menuone,preview

" resize splits when the window is resized
au VimResized * :wincmd =

" only show cursorline in the current window and in normal mode.
augroup cline
    au!
    au WinLeave,InsertEnter * set nocursorline
    au WinEnter,InsertLeave * set cursorline
augroup END

" Make sure Vim returns to the same line when you reopen a file.
augroup line_return
  au!
  au BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \     execute 'normal! g`"zvzz' |
    \ endif
augroup END

"}}}
" > Timeout           {{{

" Time out on key codes but not mappings.
" Basically this makes terminal Vim work sanely.
set notimeout
set ttimeout
set ttimeoutlen=10

" }}}
" > Backup            {{{

" disable all backups
set noundofile
set nobackup
set noswapfile
set nowb

" }}}
" > Tabs, space, wrap {{{

" Automatically wrap left and right. This allows to move the cursor to the
" previous/next line after reaching first/last character in the line using the
" arrow keys in normal-, insert- (<,>) and visual mode ([,]) or the h and
" l keys.
set whichwrap+=<,>,h,l,[,]
set wrap
set formatoptions=qrn1j

set signcolumn=auto

" indentation
set autoindent
set smartindent
set smarttab
set softtabstop=4 " aka: sts
set tabstop=4 " aka: ts
set shiftwidth=4
set expandtab " fill with spaces
"set noexpandtab " fill with tabs

" }}}
" > Search and Move   {{{

" Use sane regexes.
nnoremap / /\v
vnoremap / /\v

set ignorecase
"set smartcase
set hlsearch
set incsearch
set showmatch

set virtualedit+=block

"search will center on the line it is found in
nnoremap n nzzzv
nnoremap N Nzzzv

" dont move on *
nnoremap * *<c-o>
nnoremap # <nop>

nnoremap j gj
nnoremap k gk

" easier move between windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" more convenient way of moving back and forth
nnoremap H ^
nnoremap L g_
nnoremap J <c-f>M
nnoremap K <c-b>M

vnoremap H ^
vnoremap L g_
vnoremap J <c-f>M
vnoremap K <c-b>M

map <tab> %

" }}}

" }}}
" Path & Wildmenu  {{{

" search in the directory
set path+=**

set wildmenu
set wildmode=list:longest
set wildignore=*~,*.pyc
set wildignore+=.git,.hg,.svn
set wildignore+=*.png,*.jpg,*.jpeg,*.bmp,*.gif,*.pdf
set wildignore+=*.o,*.obj,*.exe,*.dll

"}}}
" Folding          {{{

set nofoldenable
"set foldlevelstart=0

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> zf

function! MyFoldText() " {{{
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction " }}}
set foldtext=MyFoldText()

" }}}
" FileTypes        {{{

" > ASM               {{{

    au FileType asm setlocal noexpandtab shiftwidth=4 tabstop=4 softtabstop=4

" }}}
" > C / C++           {{{

    au FileType c,cpp setlocal textwidth=80
    au FileType c,cpp setlocal foldmethod=syntax
    au FileType c,cpp normal zR
    au FileType c,cpp map <F6> :!make<cr>

" }}}
" > Python            {{{

augroup ft_python
    au!

    au FileType python setlocal textwidth=80
    au FileType python setlocal foldmethod=indent foldnestmax=2 define=^\s*\\(def\\\\|class\\)
    au FileType python normal zR

    "au FileType python if exists("python_space_error_highlight") | unlet python_space_error_highlight | endif
    "au FileType python iabbrev <buffer> afo assert False, "Okay"
    au FileType python map <F6> :!python %<cr>

augroup END

" }}}
" > ReStructuredText  {{{

augroup ft_rst
    au!

    au BufNewFile,BufRead *.rst setlocal filetype=rst fo+=aw
    au Filetype rst nnoremap <buffer> <localleader>1 yyppVr=2kVr=3j:redraw<cr>
    au Filetype rst nnoremap <buffer> <localleader>2 yypVr-:redraw<cr>
    au Filetype rst nnoremap <buffer> <localleader>3 yypVr~:redraw<cr>
    au Filetype rst nnoremap <buffer> <localleader>4 yypVr`:redraw<cr>

    au FileType rst setl suffixesadd=.rst
    au BufWritePost *.rst silent! execute "!make html >/dev/null 2>&1" | redraw!
    au FileType rst map <F6> :!make html &> /dev/null&<cr><cr>
augroup END

" }}}
" > Markdown          {{{

augroup ft_md
    au!

    au FileType markdown setlocal textwidth=80 softtabstop=2 tabstop=2 shiftwidth=2
    au BufNewFile,BufRead *.md setlocal filetype=markdown fo+=w
    au FileType markdown setl suffixesadd=.md

    let g:markdown_folding = 1

augroup END

" }}}
" > Vim               {{{

augroup ft_vim
    au!

    au FileType vim setlocal foldmethod=marker
    au FileType help setlocal textwidth=80
    au FileType vim normal zR
    au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
augroup END

" }}}
" > Mutt              {{{
"
augroup ft_mutt
    au!

    au FileType muttrc setlocal foldmethod=marker foldmarker={{{,}}}
    au FileType mail setlocal comments+=nb:> tw=72 fo+=aw nojs nosmartindent

augroup END

" }}}
" > Tex               {{{

augroup ft_tex
    au!

    au FileType tex setlocal foldmethod=marker foldmarker={{{,}}}
    au BufRead *.tex setlocal fo+=w
    au FileType tex map <F6> :!lualatex %<cr>
augroup END

" }}}
" > Conf              {{{
" Generic conf
augroup ft_conf
    au!

    "au FileType man nnoremap <buffer> <cr> :q<cr>
    au FileType conf setlocal foldmethod=marker foldmarker={{{,}}}
augroup END

" }}}

" }}}
" Custom Mappigns  {{{

" disable u in visual mode
vnoremap u <nop>

" I use o esc a lot. move it to enter in normal mode
nnoremap <cr> o<esc>

" overload save
nnoremap S :w<cr>

" disable ex mode
noremap Q <nop>

" Select the text that was last edited/pasted.
nmap gV `[v`]

" Keep the cursor in place while joining lines
"nnoremap gj mzJ`z

" Split line (sister to [J]oin lines)
"nnoremap gk i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w

" Redraw screen
nnoremap U :syntax sync fromstart<cr>:redraw!<cr>

" Un-highlight search matches
nnoremap <leader><leader> :noh<cr>

" Toggle line numbers
nnoremap <leader>n :set nonumber!<cr>:set norelativenumber!<cr>

" Toggle [i]nvisible characters
nnoremap <leader>i :set list!<cr>

" Formatting, TextMate style
nnoremap Q gqip
vnoremap Q gq

nnoremap vv ^vg_

" create a split on the given side.
" From http://technotales.wordpress.com/2010/04/29/vim-splits-a-guide-to-doing-exactly-what-you-want/ via joakimk.
nmap <leader><left>   :leftabove  vsp<cr>
nmap <leader><right>  :rightbelow vsp<cr>
nmap <leader><up>     :leftabove  sp<cr>
nmap <leader><down>   :rightbelow sp<cr>

" Tab/shift-tab to indent/outdent in visual mode.
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Keep selection when indenting/outdenting.
vnoremap > >gv
vnoremap < <gv

" nnoremap <leader>t :TlistToggle<cr>
map <F10> <ESC>ggg?G``

" Copy pase with visual selection
vnoremap <C-C> :w !xclip -i -sel c<CR><CR>
vnoremap <C-V> :r !xclip -o -sel c<CR><CR>

nnoremap ; :buffers<CR>:buffer<Space>

" Rebuild Ctags (mnemonic RC -> cr -> <cr>)
"nnoremap <leader><cr> :silent !myctags >/dev/null 2>&1 &<cr>:redraw!<cr>

" }}}
" Plugins          {{{

" > junegunn/fzf            {{{

set rtp+=/opt/homebrew/Cellar/fzf/0.27.2

" open files
"map ; :Files<cr>
"map gb :Buffers<cr>

nnoremap <leader>f :Rg<cr>

" Rg current word
nnoremap <silent> <Leader>rg :Rg <C-R><C-W><CR>

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

" }}}
" > preservim/nerdtree      {{{

map <F2> :NERDTreeToggle<cr>

" open NERDTree if no files are were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let NERDTreeIgnore=['\.pyc$', '\~$']

" }}}
" > itchyny/lightline.vim   {{{

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
" }}}
" > neoclide/coc            {{{

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" use <tab> for trigger completion and navigate to the next complete item
"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

function! s:check_back_space() abort " {{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction " }}}

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use M to show documentation in preview window.
nnoremap <silent> M :call <SID>show_documentation()<cr>

function! s:show_documentation() " {{{
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction " }}}

" }}}
" > tpope/vim-commentary    {{{

autocmd FileType cpp setlocal commentstring=//\ %s

" }}}

" }}}

