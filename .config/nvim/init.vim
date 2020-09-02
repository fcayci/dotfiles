" .config/nvim/init.vim
" Author: Furkan Cayci

" Essentials       {{{

filetype on
filetype plugin on
filetype indent on
set nocompatible

" Leader
let mapleader = ","
let maplocalleader = "\\"

" tags locations
set tags=./tags,tags;$HOME

" }}}
" Colorscheme      {{{

colorscheme nord

" }}}
" Basic Options    {{{

" > General           {{{
set encoding=utf-8
set fileencoding=utf-8
set fileencodings="utf-8,iso-8859-8"

set ffs=unix,dos,mac

set autochdir
set autoindent
"set showcmd
set modelines=0
set hidden
set novisualbell
set noerrorbells
set ttyfast
set laststatus=2
set history=1000
set undofile
set undoreload=10000
set lazyredraw
set matchtime=3
set splitbelow splitright
set shiftround
set title
set colorcolumn=+1
set t_vb=
set backspace=indent,eol,start
set nojoinspaces

set list
"set listchars=tab:» ,space:·
"set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set listchars=tab:▸\ ,extends:❯,precedes:❮
set linebreak
set showbreak=↪
"set textwidth=80
set synmaxcol=800 " Dont highlight longer than 800 chars

set magic
set mat=2

set ruler
set number
set relativenumber

" Better Completion
set complete=.,w,b,u,t
set completeopt=longest,menuone,preview

" Resize splits when the window is resized
au VimResized * :wincmd =

" Only show cursorline in the current window and in normal mode.
augroup cline
    au!
    au WinLeave,InsertEnter * set nocursorline
    au WinEnter,InsertLeave * set cursorline
augroup END

" Show trailing whitespace:
au BufWinEnter * :set listchars+=trail:·

" Clean trailing whitespace
nnoremap <leader>ww mz:%s/\s\+$//<cr>:let @/=''<cr>`z

" > Clean trailing whitespace on save {{{

" augroup cleantrailings
"     autocmd!
"     autocmd BufWritePre *.{py,vhd,sv,v,html,js,json,c,cpp,h,hpp,lua} let w:wv = winsaveview() | %s/\s\+$//e | call winrestview(w:wv)
" augroup END

" }}}

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

set nobackup
set noswapfile
set nowb

" }}}
" > Tabs, space, wrap {{{

" Automatically wrap left and right.
" This allows to move the cursor to the previous/next line after reaching first/last character in the line using the arrow keys in normal-, insert- (<,>) and visual mode ([,]) or the h and l keys.
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

map <tab> %

" }}}

" }}}
" Wildmenu         {{{

set wildmenu
set wildmode=list:longest
set wildignore=*~,*.pyc
set wildignore+=.git,.hg,.svn
set wildignore+=*.png,*.jpg,*.jpeg,*.bmp,*.gif,*.pdf
set wildignore+=*.o,*.obj,*.exe,*.dll

"}}}
" Spelling         {{{

set spellfile=~/.local/share/nvim/spell/dict-en.utf-8.add,~/.local/share/nvim/spell/dict-tr.utf-8.add

let g:myLang=0
let g:myLangList=["nospell","en_us","tr"]

function! ToggleSpell() " {{{
  let g:myLang=g:myLang+1
  if g:myLang>=len(g:myLangList) | let g:myLang=0 | endif
  if g:myLang==0
    setlocal nospell
  else
    execute "setlocal spell spelllang=".get(g:myLangList, g:myLang)
  endif
  echo "spell checking language:" g:myLangList[g:myLang]
endfunction " }}}
nnoremap <silent> <F7> :call ToggleSpell()<cr>

nnoremap zG 2zg

" }}}
" Folding          {{{

set foldlevelstart=0

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

" > Common            {{{
    au FileType asm setlocal noexpandtab shiftwidth=8 tabstop=8 softtabstop=8
    au FileType c setlocal foldmethod=marker foldmarker={,}
    au BufNewFile,BufRead *.m*down setlocal filetype=markdown foldlevel=1

" }}}
" > Python            {{{

augroup ft_python
    au!

    au FileType python setlocal foldmethod=indent foldnestmax=2 define=^\s*\\(def\\\\|class\\)
    au FileType man nnoremap <buffer> <cr> :q<cr>

    "au FileType python if exists("python_space_error_highlight") | unlet python_space_error_highlight | endif

    "au FileType python iabbrev <buffer> afo assert False, "Okay"
augroup END

" }}}
" > ReStructuredText  {{{

augroup ft_rest
    au!

    au BufRead *.rst setlocal fo+=aw
    au Filetype rst nnoremap <buffer> <localleader>1 yypVr=:redraw<cr>
    au Filetype rst nnoremap <buffer> <localleader>2 yypVr-:redraw<cr>
    au Filetype rst nnoremap <buffer> <localleader>3 yypVr~:redraw<cr>
    au Filetype rst nnoremap <buffer> <localleader>4 yypVr`:redraw<cr>
augroup END

" }}}
" > Vim               {{{

augroup ft_vim
    au!

    au FileType vim setlocal foldmethod=marker
    au FileType help setlocal textwidth=78
    au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
augroup END

" }}}
" > Mutt              {{{
"
augroup ft_mutt
    au!

    au FileType muttrc setlocal foldmethod=marker foldmarker={{{,}}}
    au BufRead /tmp/mutt-* setlocal fo+=aw
    au BufRead /tmp/neomutt-* setlocal fo+=aw
augroup END

""
" }}}
" }}}
" Custom Mappigns  {{{

" disable u in visual mode
vnoremap u <nop>

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

" i use o esc a lot. move it to enter in normal mode
nnoremap <cr> o<esc>

nnoremap <F3> :TlistToggle<cr>
set pastetoggle=<F8>
map <F10> <ESC>ggg?G``

" Rebuild Ctags (mnemonic RC -> cr -> <cr>)
"nnoremap <leader><cr> :silent !myctags >/dev/null 2>&1 &<cr>:redraw!<cr>
" > FileType executions {{{

au FileType python map <F6> :!python %<cr>
au FileType html,xhtml map <F6> :!firefox %<cr>
au FileType tex map <F6> :!texi2pdf -c %<cr>
au FileType markdown map <F6> :!pandoc % --pdf-engine=pdflatex -o /tmp/%.pdf && xdg-open /tmp/%.pdf&<cr>
au FileType rst map <F6> :!make html &> /dev/null&<cr><cr>

autocmd BufWritePost *.rst silent! execute "!make html >/dev/null 2>&1" | redraw!

" }}}

" }}}
" Plugins          {{{

" > junegunn/fzf            {{{

" open files
map ; :Files<cr>
map gb :Buffers<cr>

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

" }}}
" Zettelkasten     {{{

" FIXME change this to rst
" For inserting links for zettel
" make_note_link: List -> Str
" returned string: [Title](YYYYMMDDHH.rst)

function! s:make_note_link(l) " {{{
  " fzf#vim#complete returns a list with all info in index 0
  let line = split(a:l[0], ':')
  let ztk_id = l:line[0]
  try
    let ztk_title = substitute(l:line[2], '\#\+\s\+', '', 'g')
  catch
    let ztk_title = substitute(l:line[1], '\#\+\s\+', '', 'g')
  endtry
    let rstlink = "[" . ztk_title ."](". ztk_id .")"
    return rstlink
endfunction " }}}

" mnemonic link zettel
inoremap <expr> <c-l>z fzf#vim#complete({
  \ 'source':  'rg --no-heading --smart-case  .',
  \ 'reducer': function('<sid>make_note_link'),
  \ 'options': '--multi --reverse --margin 15%,0',
  \ 'up':    5})

" Zettelkasten location
let g:zettelkasten = "/tank/notebooks/"

function! s:make_zettel_note(...) " {{{
  " build the filename
  let l:sep = ''
  if len(a:000) > 0
    let l:sep = '-'
  endif
  let l:fname = strftime("%Y%m%d%H%M") . l:sep . join(a:000, '-') . '.rst'

  " edit the new file
  execute "e " . g:zettelkasten . l:fname

  setlocal fo+=aw

  " enter the title and timestamp (using ultisnips) in the new file
  if len(a:000) > 0
    exec "normal ggO.. \<c-r>=strftime('%Y-%m-%d %H:%M')\<cr> " . join(a:000) . "\<cr>\.. index::\<cr>\<cr>\<esc>40i=\<esc>o" . join(a:000) . "\<esc>G40i=\<esc>:\<esc>o\<cr>"
  else
    exec "normal ggO\<c-r>=strftime('%Y-%m-%d %H:%M')\<cr>\<cr>\<esc>G"
  endif
endfunction " }}}
command! -nargs=* Newnote call s:make_zettel_note(<f-args>)

" }}}
