set nocompatible              " be iMproved, required
filetype off                  " required


call plug#begin()

Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'easymotion/vim-easymotion'
Plug 'chrisbra/vim-diff-enhanced'

Plug 'xolox/vim-misc' " needed for vim-session
Plug 'xolox/vim-session' " store state across vim
Plug 'ctrlpvim/ctrlp.vim' " search files and buffer
Plug 'dense-analysis/ale' " linting and fixing async
Plug 'godlygeek/tabular' " align tabular data
Plug 'terryma/vim-multiple-cursors'

" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Raimondi/delimitMate' " auto insertion of )]}
Plug 'tpope/vim-surround' " move around and edit surrounding elements
Plug 'matze/vim-move'
Plug 'Yggdroot/indentLine' " sets indent guidelines
"Plug 'elzr/vim-json'

"Plug 'integralist/vim-mypy'
"Plug 'othree/vim-autocomplpop'
"Plug 'autowitch/hive.vim'
"Plug 'ervandew/snipmate.vim'
"Plug 'benmills/vimux'
"
" Follow https://github.com/ycm-core/YouCompleteMe#installation) for
" installation
Plug 'ycm-core/YouCompleteMe' " Auto-compelte


"
"
"Plug 'tpope/vim-endwise' " problem with delimitMate
"Plug 'ervandew/supertab'
"Plug 'tpope/vim-fugitive'
"Plug 'tpope/vim-rails'
"Plug 'klen/python-mode'
"Plug 'jalvesaq/R-Vim-runtime'
"Plug 'Vim-R-plugin'
"Plug 'pangloss/vim-javascript'
"Plug 'bkad/CamelCaseMotion'
"Plug 'ervandew/screen'


"Plug 'NERD_Tree-and-ack'
"Plug 'airblade/vim-gitgutter'
"Plug 'bling/vim-bufferline'
"Plug 'mileszs/ack.vim'
"Plug 'tpope/vim-dispatch'

"Plug 'xolox/vim-session'
"Plug 'vim-misc'

" colors
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'jonathanfilip/vim-lucius'
Plug 'w0ng/vim-hybrid'
Plug 'chriskempson/base16-vim'
"Plug "daylerees/colour-schemes", { "rtp": "vim/" }
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
"Plug 'ascenator/L9', {'name': 'newL9'}

" All of your Plugs must be added before the following line
call plug#end()
filetype plugin indent on    " required


" note that you neeed to install https://github.com/chriskempson/base16-shell
let base16colorspace=256  " Access colors present in 256 colorspace

"colorscheme base16-default-dark

set nocompatible   " be IMproved
set bs=2           " backspace should work as we expect it to
set history=50     " remember last 50 commands
set ruler          " show cursor position in the bottom line
syntax on          " turn on syntax highlighting if not available by default
set synmaxcol=100000  " don't highlight more than 300 character
set encoding=utf-8 " Encode utf-8

" Indentation related issues
set autoindent
set expandtab
"set tabstop=2
"set softtabstop=2
"set shiftwidth=2

  set tabstop=2
  set softtabstop=2
  set shiftwidth=2

"set foldmethod=indent
"set foldlevel=20

set t_Co=256         " Tell vim that my terminal has 256 colors
set number           " Show line numbers
set pastetoggle=<F2> " look :h paste
set mouse=a          " Enables mouse scrolling and selecting.
set sidescroll=1     " not affecting zl and zh, affecting cursor motion
set colorcolumn=80   " Long lines are evil
set cursorline       " highlight curosr line But it somestimes makes vim slow

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/*cache/*       " Ignore some files

"Normal split directions
set splitright
set splitbelow

"nmap <C-A> "+ggVG

" automatically save before each make/execute command
set autowrite

" automatically read when a file is changed
set autoread

" if I press <tab> in command line, show me all options if there is more than
" one
set wildmenu

" y and d put stuff into system clipboard (so that other apps can see it)
"set clipboard+=unnamed
"set clipboard=unnamedplus
set clipboard=unnamed


" adjust timeout for mapped commands: 200 milliseconds should be enough for
" everyone
set timeout
set timeoutlen=400
set ttimeoutlen=50

" Alt+Backspace deletes a word in insert mode (terminal sends <Esc><BS>)
inoremap <M-BS> <C-w>
cnoremap <M-BS> <C-w>


" text search settings
"set incsearch  " show the first match already while I type
set ignorecase
set smartcase  " only be case-sensitive if I use uppercase in my query
set hlsearch " I Don't hate when half of the text lights up
set virtualedit=block  " make selection better not bounded to end of lines
" make search results always in the center
" nnoremap n nzzzs50zh
" nnoremap N Nzzzs50zh
set nowrapscan " don't cycle when searching
" Clears search buffer
nnoremap // :noh<cr>

" show chars that cannot be displayed as <13> instead of ^M
set display+=uhex

" status line: we want it at all times
set laststatus=2

set lazyredraw " Lazy is always good
set ttyfast "fast terminal connection

set nowrap " don't wrap lines


" no swap nor backup
set nobackup
set noswapfile

" vim scripts
function! VIMSET()
  set nowrap
  set comments+=b:\"
endfunction

" HTML/PHP
function! HTMLSET()
  set nowrap
endfunction

" Python
function! PYSET()
  set nowrap
  set fdm=indent

  set tabstop=4
  set softtabstop=4
  set shiftwidth=4
  noremap py :!python3<CR>
  noremap apy :%!python3<CR>
endfunction

function! RUBYSET()
  set nowrap
  noremap <leader>r :call RSpecCopy() <CR>
  command! RSpecCopy call RSpecCopy()
endfunction

function! ERBSET()
  set nowrap
endfunction

function! TXTSET()
  set wrap
  "noremap j gj
  "noremap k gk
  "noremap $ g$
  "noremap 0 g0
  set linebreak
  "set spell
  "noremap z z=1
endfunction

function! TEXSET()
  nnoremap K :!pdflatex %&& open typeinst.pdf<CR>
  nnoremap vi$ F$vf$
  set textwidth=80
  set linebreak
  set spell
endfunction

function! RMDSET()
  nnoremap K :call VimuxRunCommand(RUN_RMARKDOWN())<CR>
  nnoremap KK :call VimuxRunCommand(OPEN_HTML())<CR>
  " if selection, put stuff in @r and run it, and move the cursor oneline
  " downwards
  vnoremap R "ry:call VimuxRunCommand(@r)<CR>gvvvj
  " if noselection, put current line stuff in @r and run it
  nnoremap R "ryy:call VimuxRunCommand(@r)<CR>j
  setlocal commentstring="#%s"
endfunction

function! RSET()
  " needs a tmux session to be open in the right directory
  vnoremap R "ry:call VimuxRunCommand(@r)<CR>gvvvj
  " if noselection, put current line stuff in @r and run it
  nnoremap R "ryy:call VimuxRunCommand(@r)<CR>j
endfunction

function! RUN_RMARKDOWN()
  let s:file_name=expand('%')
  let s:html_name = substitute(s:file_name, '\..*', '.html', 'a')
  let s:cmd = 'rmarkdown::render("'.s:file_name.'")'
  echo s:cmd
  return s:cmd
endfunction

function! OPEN_HTML()
  let s:file_name=expand('%')
  let s:html_name = substitute(s:file_name, '\..*', '.html', 'a')
  return "system('open -a Safari ".s:html_name."')"
endfunction

" Autocommands for all languages:
autocmd FileType vim    call VIMSET()
autocmd FileType html   call HTMLSET()
autocmd FileType php    call HTMLSET()
autocmd FileType python call PYSET()
autocmd FileType ruby   call RUBYSET()
autocmd FileType eruby  call RUBYSET()
autocmd FileType text   call TXTSET()
autocmd FileType tex    call TEXSET()
autocmd FileType rmd    call RMDSET()
autocmd FileType rmd    call RMDSET()
"autocmd FileType r      call RSET()

" for .hql files
au BufNewFile,BufRead *.hql set filetype=hive expandtab
" for .q files
au BufNewFile,BufRead *.q set filetype=hive expandtab



" =============================================================================
" Specific settings for emacs-like movement:  {{{

inoremap <C-f> <C-o>l
inoremap <C-b> <C-o>h
inoremap <C-e> <C-o>$
inoremap <C-a> <C-o>^

" }}}
" =============================================================================


filetype indent on " Don't remember what it does
filetype plugin on " Don't remember what it does

noremap <leader>s : set lines=120 columns=100<CR>
noremap <leader>b : set lines=2000 columns=2000<CR>

" JSON formatter
noremap <leader>j :%!python3 -m json.tool<CR>

nnoremap <leader>d :execute 'NERDTreeToggle' . getcwd()<CR>

" Shortcut to rapidly toggle `set list`
"set list
nnoremap <leader>l :set list!<CR>

" Comment using NERDCommneter
map <C-l> <leader>c<Space>
" Align delimters (good for python)
let g:NERDDefaultAlign = 'left'


" Invisible chars
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59
set listchars=tab:▸\ ,eol:¬,trail:~,extends:▸,precedes:◂


" Get out of insert mode fast
inoremap <TAB> <ESC>
onoremap <TAB> <ESC>
vnoremap <TAB> <ESC>

"inoremap <ESC> <NOP>
"onoremap <ESC> <NOP>
"vnoremap <ESC> <NOP>


" don't ever use U to change upper/lower case
vnoremap u <NOP>

" Back to the previous buffer
nnoremap <C-Space> <C-^>


" Tab navigation
nnoremap tj :tabprevious<CR>
nnoremap tk :tabnext<CR>
nnoremap th :tabfirst<CR>
nnoremap tl :tablast<CR>

"  Adding gitignore file to wildignore
"let filename = '.gitignore'
"if filereadable(filename)
"    let igstring = ''
"    for oline in readfile(filename)
"        let line = substitute(oline, '\s|\n|\r', '', "g")
"        if line =~ '^#' | con | endif
"        if line == '' | con  | endif
"        if line =~ '^!' | con  | endif
"        if line =~ '/$' | let igstring .= "," . line . "*" | con | endif
"        let igstring .= "," . line
"    endfor
"    let execstring = "set wildignore+=".substitute(igstring, '^,', '', "g")
"    execute execstring
"endif

let g:gitgutter_enabled = 0

function! RSpecCopy()
  let @*= "rspec  " . expand("%p") . ":" . line(".")
endfunction

function! FilenameCopy()
  let @*= expand("%f")
endfunction

function! FilenameCopyFullPath()
  let @*= expand("%:p")
endfunction

function! PathCopy()
  let @*= expand("%:p:h")
endfunction

function! RmdCopyRender()
  let @*= 'rmarkdown::render("' . expand("%f") . '")'
endfunction

function! TabularSpace()
  Tabularize /\s\{1,}/
endfunction



command! FilenameCopy call FilenameCopy()
command! FilenameCopyFullPath call FilenameCopyFullPath()
command! PathCopy call PathCopy()

noremap <leader>f :call FilenameCopy() <CR>
noremap <leader>F :call FilenameCopyFullPath() <CR>
noremap <leader>D :call PathCopy() <CR>

command! RmdCopyRender call RmdCopyRender()
noremap <leader>rf :call RmdCopyRender() <CR>


function! TextEnableCodeSnip(filetype,start,end,textSnipHl) abort
  let ft=toupper(a:filetype)
  let group='textGroup'.ft
  if exists('b:current_syntax')
    let s:current_syntax=b:current_syntax
    " Remove current syntax definition, as some syntax files (e.g. cpp.vim)
    " do nothing if b:current_syntax is defined.
    unlet b:current_syntax
  endif
  execute 'syntax include @'.group.' syntax/'.a:filetype.'.vim'
  try
    execute 'syntax include @'.group.' after/syntax/'.a:filetype.'.vim'
  catch
  endtry
  if exists('s:current_syntax')
    let b:current_syntax=s:current_syntax
  else
    unlet b:current_syntax
  endif
  execute 'syntax region textSnip'.ft.'
  \ matchgroup='.a:textSnipHl.'
  \ start="'.a:start.'" end="'.a:end.'"
  \ contains=@'.group
endfunction

" https://stackoverflow.com/questions/25267160/can-i-have-vim-highlight-code-in-r-markup
autocmd BufNewFile,BufRead,BufEnter *.Rmd :call TextEnableCodeSnip('r',   '```{r.*}',   '```', 'SpecialComment')
au BufNewFile,BufRead *.Rmd set filetype=rmd

command! TabularSpace call TabularSpace()
noremap t<space> :call TabularSpace() <CR>

" airline config
let g:airline#extensions#tabline#enabled = 1

"let g:airline_left_sep = ''
"let g:airline_right_sep = ''
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'
" For bufferline
"let g:bufferline_echo = 0
"let g:bufferline_inactive_highlight = 'StatusLineNC'
"let g:bufferline_active_highlight = 'StatusLine'


" CtrlPTag
"noremap <C-t> :CtrlPTag <CR>
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_working_path_mode = 0
set tags=tags;/ "search for tags in the parent directory till you find one


" Fast scrolling
noremap <Right> 20zl
noremap <Left> 20zh
noremap <Up> 20<C-y>
noremap <Down> 20<C-e>

" Because :Q :W, :E are just useless
cabbrev W w
cabbrev Q q
cabbrev E e
cabbrev wQ! wq!


" I just don't like them
nnoremap K  k

" The pipe
imap <D-M> %>%
imap <D-N> %<>%
imap <S-D-Space> <Space>

" Set filetype to be text for new buffers
autocmd BufEnter * if &filetype == "" | setlocal ft=txt | endif
autocmd BufEnter * if &filetype == "hql" | setlocal ft=sql | endif

" Ale linting and fixing
" To add a linter, make sure the binary is available
"
let g:ale_virtualenv_dir_names = []
let g:ale_linters={
\'*': ['remove_trailing_lines', 'trim_whitespace'],
\'python': ['flake8', 'mypy'],
\'r': ['languageserver'],
\}

" pylint is good, but too strinct

let g:ale_fixers = {
\'*': ['remove_trailing_lines', 'trim_whitespace'],
\'python': ['black'],
\'r': ['styler'],
\}

let g:ale_fix_on_save = 1


" Auto Completion Config
set completeopt=longest,menuone

" <Enter> insers the currently highlighted mode
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" show completion while typing

" Black hole deletion/change (persist yanked lines in non-visual mode)
nnoremap d "_d
nnoremap dd "_dd
nnoremap D "_D
"nnoremap c "_c
"nnoremap C "_C
nnoremap x "_x
nnoremap X "_X


"set omnifunc=syntaxcomplete#Complete
"let g:pymode_lint = 0
"let g:pymode_lint_message = 0


" Change cursor to single line instead of a box in terminal

if !exists('$TMUX')
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
else
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
endif
"autocmd InsertEnter * set cul
"autocmd InsertLeave * set nocul

" Stuff for r
let vimrplugin_assign = 0 " make underscore not convert to ->


" Delimter
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
"let g:SuperTabCrMapping = 0 " fix the problem

" move to end of pasted (yanked) text, to ease multiple pastes
"vnoremap y y`]
"vnoremap p p`]
"nnoremap p p`]

" don't move the cursor to the start of line when jumping
set nosol

" use CamelCaseMotion
"map <silent> w <Plug>CamelCaseMotion_w
"map <silent> b <Plug>CamelCaseMotion_b
"map <silent> e <Plug>CamelCaseMotion_e

"sunmap w
"sunmap b
"sunmap e

"omap <silent> iw <Plug>CamelCaseMotion_iw
"xmap <silent> iw <Plug>CamelCaseMotion_iw
"omap <silent> ib <Plug>CamelCaseMotion_ib
"xmap <silent> ib <Plug>CamelCaseMotion_ib
"omap <silent> ie <Plug>CamelCaseMotion_ie
"xmap <silent> ie <Plug>CamelCaseMotion_ie

" why use shift if you can ignore it
nnoremap ; :

set guifont=Monoid-Retina:h11
"set guifont='Courier New'\ 10


" but you to search for the ``` first
let @r='jVnkytkptjnn'


" split the current window and scrollbind
let @s='<17>v<04><04><15><04>:set scrollbind=<80>kb<0d><17>h:set scb<0d>'

colorscheme hybrid
"set background=dark

"colorscheme Tomorrow-Night
"set background=light


" for remote copy/paste
vmap <leader>c :w !ssh localhost -p 9238 pbcopy<CR>
nmap <leader>p :r !ssh localhost -p 9238 pbpaste<CR>

" Use tab for esc (because esc is to far awy)
let g:multi_cursor_quit_key='<Tab>'


"session
let g:session_autoload='yes'
let g:session_autosave_periodic='yes'
let g:session_autosave='yes'
let g:session_default_overwrite='yes'
let g:session_default_to_last='yes'


" removes all breaklines (good for copying to bash)
command! RemoveBreakLines g/^\s*$/d


" Zooming in (just press +)
func! s:zoom_toggle() abort
  if 1 == winnr('$')
    return
  endif
  let restore_cmd = winrestcmd()
  wincmd |
  wincmd _
  if exists('t:zoom_restore')
    exe t:zoom_restore
    unlet t:zoom_restore
  else
    let t:zoom_restore = restore_cmd
  endif
  return '<Nop>'
endfunc

func! s:zoom_or_goto_column(cnt) abort
  if a:cnt
    exe 'norm! '.v:count.'|'
  else
    call s:zoom_toggle()
  endif
endfunc
nnoremap +     :<C-U>call <SID>zoom_or_goto_column(v:count)<CR>

function! SourceIfExists(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction

call SourceIfExists('~/.vimrc_fb')

" no trailing space
command! Notrailingspace execute '%s/\s\{1,}$//g'

let g:airline_section_c = '%t'

" move plugin
" only works in gvim, maybe move to .gvimrc or when alt button is not Meta
let g:move_normal_option =1
let g:move_key_modifier = 'A'



" YouCompleteMe Configs
" Use homebrew's clangd (for YouCompleteMe) (from https://github.com/ycm-core/YouCompleteMe#installation)
let g:ycm_clangd_binary_path = trim(system('brew --prefix llvm')).'/bin/clangd'

" we can go back using c-i and c-o
noremap <leader>jd :YcmCompleter GoTo<CR>
nmap <silent> <leader>h <plug>(YCMHover)

set rtp+=/opt/homebrew/opt/fzf
