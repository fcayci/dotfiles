" .config/nvim/init.vim
" Author: Furkan Cayci

" Essentials       {{{

filetype on
filetype plugin on
filetype indent on

" Leader
let mapleader = ","
let maplocalleader = "\\"

" tags locations
set tags=./tags,tags;$HOME

" enable mouse
set mouse=nic

" }}}
" Colorscheme      {{{

syntax enable
colorscheme onehalfdark

" Enable true color support. Do not set this option if your terminal does not
" support true colors! For a comprehensive list of terminals supporting true
" colors.
" https://github.com/termstandard/colors
set termguicolors

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
set laststatus=2
set history=1000
set undoreload=10000
set lazyredraw
set ttyfast
set matchtime=3
set splitbelow splitright
set shiftround
set title
set colorcolumn=+1
set backspace=indent,eol,start
set nojoinspaces

set autochdir
set autoindent

" minimum lines to keep above and below cursor when scrolling
set scrolloff=3

" show whitespaces
set list

"set listchars=tab:» ,space:·
"set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set listchars=tab:▸\ ,extends:❯,precedes:❮

" show trailing whitespace:
au BufWinEnter * :set listchars+=trail:·

set linebreak
set showbreak=↪

" dont highlight longer than this many chars
set synmaxcol=200

set textwidth=100

set magic
set mat=2

set ruler
set number
set relativenumber

" better Completion
set complete=.,w,b,u,t
set completeopt=longest,menuone,preview

" resize splits when the window is resized
au VimResized * :wincmd =

" Clipboard settings, always use clipboard for all delete, yank, change, put
" operation
" https://stackoverflow.com/q/30691466/6064933
if !empty(provider#clipboard#Executable())
  set clipboard+=unnamedplus
endif

set spelllang=en
set spellsuggest+=9

"}}}
" > Timeout           {{{

" time out on key codes but not mappings.
" basically this makes terminal Vim work sanely.
set notimeout
set ttimeout
set ttimeoutlen=400
set updatetime=500

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
set autoindent
set smartindent
set smarttab
set softtabstop=4 " (sts)
set tabstop=4 " (ts)
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

nnoremap <tab> %

" diff options
set diffopt=
set diffopt+=vertical   " show diff in vertical position
set diffopt+=filler     " show filler for deleted lines
set diffopt+=closeoff   " turn off diff when one file window is closed
set diffopt+=context:3  " context for diff
set diffopt+=internal,indent-heuristic,algorithm:histogram

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
set wildignore+=*.o,*.so,*.dylib,*.obj,*.exe,*.dll

"}}}
" Folding          {{{

set nofoldenable
"set foldlevelstart=0

set fillchars=fold:\ ,vert:\│,eob:\ ,msgsep:‾

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

" > C / C++           {{{

augroup ft_c
    au!

    au FileType c,cpp setlocal foldmethod=syntax
    au FileType c,cpp normal zR
    au FileType c,cpp map <F6> :!make<cr>
augroup END

" }}}
" > Python            {{{

augroup ft_python
    au!

    au FileType python setlocal foldmethod=indent foldnestmax=2 define=^\s*\\(def\\\\|class\\)
    au FileType python normal zR
    au FileType python map <F6> :!python %<cr>
augroup END

" }}}
" > ReStructuredText  {{{

augroup ft_rst
    au!

    au BufNewFile,BufRead *.rst setlocal filetype=rst fo+=aw
    au FileType rst setl suffixesadd=.rst
    au BufWritePost *.rst silent! execute "!make html >/dev/null 2>&1" | redraw!
    au FileType rst map <F6> :!make html &> /dev/null&<cr><cr>
augroup END

" }}}
" > Markdown          {{{

augroup ft_md
    au!

    au FileType markdown setlocal softtabstop=2 tabstop=2 shiftwidth=2
    au BufNewFile,BufRead *.md setlocal filetype=markdown fo+=w
    au FileType markdown setl suffixesadd=.md

    let g:markdown_folding = 1
augroup END

" }}}
" > Vim               {{{

augroup ft_vim
    au!

    au FileType vim setlocal foldmethod=marker
    au FileType vim normal zR
    au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
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

    au FileType conf setlocal foldmethod=marker foldmarker={{{,}}}
augroup END

" }}}

" }}}
" Custom Mappings  {{{

" clean trailing whitespace (all / only empty)
nnoremap <leader>wa mz:%s/\s\+$//<cr>:let @/=''<cr>`z
nnoremap <leader>ww mz:%s/^\s\+$//<cr>:let @/=''<cr>`z

" disable u in visual mode
vnoremap u <nop>

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
nnoremap <leader>l :set nonumber!<cr>:set norelativenumber!<cr>

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

" Keep selection when indenting/outdenting.
vnoremap > >gv
vnoremap < <gv

map <F10> <ESC>ggg?G``

" Copy paste with visual selection
vnoremap <C-C> :w !pbcopy<CR><CR>
"vnoremap <C-V> :r !pbpaste<CR><CR>

" clang-format
function! ClangFormat(...)
  execute ":" . a:1 . "," . a:2 . "!clang-format"
endfunction

nnoremap <silent> <leader>f :<c-u>call ClangFormat(line("."), line(".")+v:count1)<cr>

"nnoremap ; :buffers<CR>:buffer<Space>

" }}}
" Autocommands     {{{

" only show cursorline in the current window and in normal mode.
augroup cline
  au!
  au WinLeave,InsertEnter * set nocursorline
  au WinEnter,InsertLeave * set cursorline
augroup END

" do not use smart case in command line mode
augroup dynamic_smartcase
  autocmd!
  autocmd CmdLineEnter : set nosmartcase
  autocmd CmdLineLeave : set smartcase
augroup END

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
augroup END

" more accurate syntax highlighting? (see `:h syn-sync`)
augroup accurate_syn_highlight
  autocmd!
  autocmd BufEnter * :syntax sync fromstart
augroup END

" Return to last cursor position when opening a file
augroup resume_cursor_position
  autocmd!
  autocmd BufReadPost * call s:resume_cursor_position()
augroup END

" Only resume last cursor position when there is no go-to-line command
function s:resume_cursor_position() abort
  if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    let l:args = v:argv  " command line arguments
    for l:cur_arg in l:args
      " Check if a go-to-line command is given.
      let idx = match(l:cur_arg, '\v^\+(\d){1,}$')
      if idx != -1
        return
      endif
    endfor

    execute "normal! g`\"zvzz"
  endif
endfunction

" }}}
" Plugins          {{{

" > junegunn/fzf            {{{

set rtp+=/opt/homebrew/opt/fzf

" open files
map ; :Files<cr>
map gb :Buffers<cr>

" RipGrep
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

" Silver Searcher
command! -bang -nargs=* Ag
  \ call fzf#vim#grep(
  \   'ag --column --numbers --literal --nobreak --noheading --color --smart-case '.shellescape(<q-args>), 1,
  \fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

" Git Grep
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number --color=always -w -- '.shellescape(<q-args>), 1,
  \fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

" Rg current word
nnoremap <silent> <leader>rg :Rg <c-r><c-w><cr>

" Git grep current word
nnoremap <silent> <leader>g :GGrep <c-r><c-w><cr>

" }}}
" > preservim/nerdtree      {{{

map <leader>n :NERDTreeToggle<cr>

" open NERDTree if no files are were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let NERDTreeIgnore=['\.pyc$', '\~$']

" }}}
" > itchyny/lightline.vim   {{{

let g:airline_theme='onehalfdark'

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
" > yegappan/taglist        {{{

nnoremap <leader>t :TlistToggle<cr>

" }}}

" }}}
