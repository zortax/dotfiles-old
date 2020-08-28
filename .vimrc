let vimplug_exists=expand('~/.vim/autoload/plug.vim')

if !filereadable(vimplug_exists)
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!\curl -fLo " . vimplug_exists . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

" map leader
let mapleader=','

" Enable omnifunc
filetype plugin on
set omnifunc=syntaxcomplete#Complete

"""""""""""""""""""""
" Plugins
"""""""""""""""""""""
" Required:
call plug#begin(expand('~/.vim/plugged'))

Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'zortax/lightline.vim'
Plug 'Yggdroot/indentLine'
if isdirectory('/usr/local/opt/fzf')
  Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
endif
Plug 'lervag/vimtex'
Plug 'Chiel92/vim-autoformat'
Plug 'ayu-theme/ayu-vim'
Plug 'ciaranm/detectindent'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'junegunn/goyo.vim'
Plug 'zortax/vim-two-firewatch'
Plug 'tpope/vim-fugitive'
Plug 'majutsushi/tagbar'

call plug#end()

""""""""""""""""""""""""
" Plugin Configuration
""""""""""""""""""""""""

" nerdtree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

let g:NERDTreeShowHidden=1

map <C-o> :NERDTreeToggle<CR>


" indentLine
let g:indentLine_char = '┊'

" fzf
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"

if executable('ag')
  let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
  set grepprg=ag\ --nogroup\ --nocolor
endif

if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif

cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>e :FZF -m<CR>
nmap <leader>y :History:<CR>
nnoremap <silent> <leader>l :Lines<CR>


" YouCompleteMe

let g:ycm_global_ycm_extra_conf = '~/.scripts/global_extra_conf.py'

nmap <C-d> <plug>(YCMHover)
nmap <C-b> :YcmCompleter GoTo<CR>

let g:ycm_complete_in_comments = 1

set completeopt-=preview

if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
endif

" vimtex
let g:vimtex_view_method = 'zathura'
let g:ycm_semantic_triggers.tex = [
    \ 're!\\[A-Za-z]*cite[A-Za-z]*(\[[^]]*\]){0,2}{[^}]*',
    \ 're!\\[A-Za-z]*ref({[^}]*|range{([^,{}]*(}{)?))',
    \ 're!\\hyperref\[[^]]*',
    \ 're!\\includegraphics\*?(\[[^]]*\]){0,2}{[^}]*',
    \ 're!\\(include(only)?|input){[^}]*',
    \ 're!\\\a*(gls|Gls|GLS)(pl)?\a*(\s*\[[^]]*\]){0,2}\s*\{[^}]*',
    \ 're!\\includepdf(\s*\[[^]]*\])?\s*\{[^}]*',
    \ 're!\\includestandalone(\s*\[[^]]*\])?\s*\{[^}]*',
    \ 're!\\usepackage(\s*\[[^]]*\])?\s*\{[^}]*',
    \ 're!\\documentclass(\s*\[[^]]*\])?\s*\{[^}]*',
    \ 're!\\[A-Za-z]*',
    \ ]

let g:vimtex_quickfix_enabled = 0

let g:tex_conceal = "a"

let g:tex_flavor = 'latex'

" vim-autoformat
nmap <C-l> :Autoformat<CR>

"""""""""
" Setup
"""""""""

" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencoding=utf-8
set ttyfast

set backspace=indent,eol,start

" 4 Spaces instead of tabs
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab

set hidden

" Search
set hlsearch
set incsearch
set ignorecase
set smartcase

set fileformats=unix,dos,mac

if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif

" Syntax, Linenumbers,...
syntax on
set ruler
set number
"set cursorline

if &term =~ '256color'
    set t_ut=
endif

" Disable blinking cursor
set gcr=a:blinkon0
set scrolloff=5

" Enable status bar
set laststatus=2

set modeline
set modelines=10

set title
set titleold="Terminal"
set titlestring=%F

set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)

nnoremap n nzzzv
noremap N Nzzzv

" Autoindent
set autoindent
filetype plugin indent on

" Use systemclipboard
set clipboard=unnamedplus

set ttimeoutlen=0

"""""""""""""""""""""""
" Commands
"""""""""""""""""""""""

" remove trailing whitesoaces
command! FixWhitespace :%s/\s\+$//e


" autoformat JSON
command! FormatJson %!python -m json.tool


""""""""""""""""""
" Theme Overrides
""""""""""""""""""
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors
set background=dark

" Colorscheme
silent! colorscheme two-firewatch

" Airline Theme
set noshowmode
source ~/.scripts/lightline_theme.vim
let g:lightline = {
      \ 'colorscheme': 'dark_qualitative',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ]],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype', 'gitbranch' ]]
      \ },
      \ 'separator': {
      \   'left': '',
      \   'right': ''
      \ },
      \ 'component_function': {
      \   'readonly': 'LightlineReadonly',
      \   'gitbranch': 'LightlineGitbranch'
      \ },
      \ }

function! LightlineReadonly()
    return &readonly ? '' : ''
endfunction

function! LightlineGitbranch()
    return FugitiveHead() !=# '' ? " " . FugitiveHead() : ''
endfunction

