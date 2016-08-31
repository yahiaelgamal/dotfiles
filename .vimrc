filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
" Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}

" vim-scripts repos
Bundle 'yahiaelgamal/vim-airline'
Bundle 'godlygeek/tabular'
Bundle 'The-NERD-Commenter'
Bundle 'ctrlp.vim'
" Bundle 'ervandew/supertab'
Bundle 'Valloric/YouCompleteMe'
Bundle 'matze/vim-move'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'digitaltoad/vim-pug'
"Bundle 'tpope/vim-endwise' " problem with delimitMate

"Bundle 'tpope/vim-fugitive'
"Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-surround'
Bundle 'klen/python-mode'
"Bundle 'jalvesaq/R-Vim-runtime'
"Bundle 'Vim-R-plugin'
"Bundle 'pangloss/vim-javascript'
"Bundle 'ervandew/snipmate.vim'
Bundle 'Raimondi/delimitMate'
Bundle 'bkad/CamelCaseMotion'
"Bundle 'ervandew/screen'
Bundle 'benmills/vimux'


"Bundle 'Lokaltog/vim-easymotion'
"Bundle 'NERD_Tree-and-ack'
"Bundle 'airblade/vim-gitgutter'
Bundle 'bling/vim-bufferline'
"Bundle 'mileszs/ack.vim'
"Bundle 'tpope/vim-dispatch'
"
"Bundle 'xolox/vim-session'
"Bundle 'vim-misc'

" colors
Bundle 'chriskempson/vim-tomorrow-theme'
Bundle 'Lucius'
"Bundle "daylerees/colour-schemes", { "rtp": "vim/" }

filetype plugin indent on     " required!

" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..
" Really?

" =============== VUNDLER END ==============



set nocompatible   " be IMproved
set bs=2           " backspace should work as we expect it to
set history=50     " remember last 50 commands
set ruler          " show cursor position in the bottom line
syntax on          " turn on syntax highlighting if not available by default
set synmaxcol=400  " don't highlight more than 300 character
set encoding=utf-8 " Encode utf-8

" Indentation related issues
set autoindent
set shiftwidth=2
set expandtab
set tabstop=4
set softtabstop=2

set foldmethod=indent
set foldlevel=20

set t_Co=256         " Tell vim that my terminal has 256 colors
set number           " Show line numbers
set pastetoggle=<F2> " look :h paste
set mouse=a          " Enables mouse scrolling and selecting.
set sidescroll=1     " not affecting zl and zh, affecting cursor motion
set colorcolumn=80   " Long lines are evil
set cursorline       " highlight curosr line But it somestimes makes vim slow

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/cache/*       " Ignore some files

"Normal split directions
set splitright
set splitbelow

"nmap <C-A> "+ggVG

" make search results always in the center
nnoremap n nzzzs50zh
nnoremap N Nzzzs50zh

" automatically save before each make/execute command
set autowrite

" automatically read when a file is changed
set autoread

" if I press <tab> in command line, show me all options if there is more than
" one
set wildmenu

" y and d put stuff into system clipboard (so that other apps can see it)
set clipboard=unnamed

" adjust timeout for mapped commands: 200 milliseconds should be enough for
" everyone
set timeout
set timeoutlen=600

" text search settings
set incsearch  " show the first match already while I type
set ignorecase
set smartcase  " only be case-sensitive if I use uppercase in my query
set hlsearch " I Don't hate when half of the text lights up

set virtualedit=block  " make selection better not bounded to end of lines

" show chars that cannot be displayed as <13> instead of ^M
set display+=uhex

" status line: we want it at all times
set laststatus=2

set lazyredraw " Lazy is always good
set ttyfast "fast terminal connection

set nowrap " don't wrap lines

"set nowrapscan " don't cycle when searching

" I would rather depend on git
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

  set softtabstop=4
  set tabstop=4
  noremap py :!python<CR>
  noremap apy :%!python<CR>
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
  " needs a tmux session to be open in the right directory
  nnoremap K :call VimuxRunCommand(RUN_RMARKDOWN())<CR>
  nnoremap KK :call VimuxRunCommand(OPEN_HTML())<CR>
  " if selection, put stuff in @r and run it, and move the cursor oneline
  " downwards
  vnoremap R "ry:call VimuxRunCommand(@r)<CR>gvvvj
  " if noselection, put current line stuff in @r and run it
  nnoremap R "ryy:call VimuxRunCommand(@r)<CR>j
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
  return "system('open ".s:html_name."')"
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
autocmd FileType r      call RSET()



" =============================================================================
" Specific settings for emacs-like movement:  {{{

inoremap <C-f> <C-o>l
inoremap <C-b> <C-o>h
inoremap <C-e> <C-o>$
inoremap <C-a> <C-o>^

" }}}
" =============================================================================

"colorscheme Tomorrow-Night-Bright
colorscheme Tomorrow-Night

filetype indent on " Don't remember what it does
filetype plugin on " Don't remember what it does

noremap <leader>s : set lines=120 columns=100<CR>
noremap <leader>b : set lines=2000 columns=2000<CR>

" JSON formatter
noremap <leader>j :%!python -m json.tool<CR>

nnoremap <leader>d :execute 'NERDTreeToggle' . getcwd()<CR>

" Shortcut to rapidly toggle `set list`
nnoremap <leader>l :set list!<CR>

" Comment using NERDCommneter
map <C-l> <leader>c<Space>

" Invisible chars
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59
set listchars=tab:▸\ ,eol:¬,trail:~,extends:▸,precedes:◂

" Clears search buffer
nnoremap // :noh<cr>

" Get out of insert mode fast
inoremap jj <ESC>

nnoremap <C-Space> <C-^>


" Tab navigation
nnoremap tj :tabprevious<CR>
nnoremap tk :tabnext<CR>
nnoremap th :tabfirst<CR>
nnoremap tl :tablast<CR>

"  Adding gitignore file to wildignore
let filename = '.gitignore'
if filereadable(filename)
    let igstring = ''
    for oline in readfile(filename)
        let line = substitute(oline, '\s|\n|\r', '', "g")
        if line =~ '^#' | con | endif
        if line == '' | con  | endif
        if line =~ '^!' | con  | endif
        if line =~ '/$' | let igstring .= "," . line . "*" | con | endif
        let igstring .= "," . line
    endfor
    let execstring = "set wildignore+=".substitute(igstring, '^,', '', "g")
    execute execstring
endif

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


noremap <leader>f :call FilenameCopy() <CR>
noremap <leader>F :call FilenameCopyFullPath() <CR>
command! FilenameCopy call FilenameCopy()
command! FilenameCopyFullPath call FilenameCopyFullPath()

" airline config
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_theme='tomorrow'
let g:airline_branch_prefix = '⎇ '
let g:airline_section_a = '%n %t'
let g:airline_section_y = ''
let g:airline_section_z = '%p%%:%l:%c'

" For bufferline
"let g:bufferline_echo = 0
"let g:bufferline_inactive_highlight = 'StatusLineNC'
"let g:bufferline_active_highlight = 'StatusLine'


" CtrlPTag
"noremap <C-t> :CtrlPTag <CR>
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_working_path_mode = 0


" Fast scrolling
noremap <Right> 20zl
noremap <Left> 20zh
noremap <Up> 20<C-y>
noremap <Down> 20<C-e>

" Because :Q :W, :E are just useless
cabbrev W w
cabbrev Q q
cabbrev E e

" I just don't like them
nnoremap K  k

" The pipe
imap <D-M>  %>% 
imap <D-N>  %<>% 

" Set filetype to be text for new buffers
autocmd BufEnter * if &filetype == "" | setlocal ft=txt | endif

" Syntastic
let g:syntastic_ruby_checkers = ['mri', 'rubocop']
"let g:syntastic_python_checkers = ['pylint', 'pyfalkes']
"let g:syntastic_mode_map = { 'mode': 'active',
                           "\ 'passive_filetypes': ['ruby', 'java'] }
                           "
let g:syntastic_enable_r_lintr_checker = 1
let g:syntastic_r_checkers = ['lintr']

let g:syntastic_javascript_checkers = ['eslint'] 
let g:syntastic_mode_map = { 'mode': 'passive',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': [] }


" Super tab configuration
"let g:SuperTabDefaultCompletionType =

" Black hole deletion/change (persist yanked lines in non-visual mode)
nnoremap d "_d
nnoremap dd "_dd
nnoremap D "_D
nnoremap c "_c
nnoremap C "_C
nnoremap x "_x
nnoremap X "_X



set omnifunc=syntaxcomplete#Complete
"let g:pymode_lint = 0
"let g:pymode_lint_message = 0


" Change cursor to single line instead of a box in terminal
let &t_SI = "\<Esc>]50;CursorShape=1\x7" 
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" Stuff for r
"let vimrplugin_assign = 0 " make underscore not convert to ->


" Delimter
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
" let g:SuperTabCrMapping = 0 " fix the problem

" session
"let g:session_autosave_periodic = 1
"let g:session_autosave = 'yes'
"let g:session_autoload = 'no'
"let g:session_default_overwrite = 1
"let g:session_default_to_last = 1

" move to end of pasted text, to ease multiple pastes
vnoremap y y`]
vnoremap p p`]
nnoremap p p`]

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


" to make use of YouCompleteMe, doesn't work
let g:snips_trigger_key = '<tab>'
let g:snips_trigger_key_backwards = '<s-tab>'

let g:snips_trigger_key = '<D-/>'
let g:snips_trigger_key_backwards = '<D-?>'

" change vim-move to command
let g:move_key_modifier = 'D'


" Blacklist 
let g:ycm_filetype_blacklist = {
      \ 'json' : 1,
      \ 'markdown' : 1,
      \}

set guifont=Monoid:h13

" The thing that hangs python files
let g:pymode_rope_lookup_project = 0
