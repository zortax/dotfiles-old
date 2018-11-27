call plug#begin('~/.vim/plugged')

Plug 'junegunn/vim-easy-align'

Plug 'https://github.com/rafi/awesome-vim-colorschemes'

if has ('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'}
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif

let g:deoplete#enable_at_startup = 1

Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jiangmiao/auto-pairs'
Plug 'jceb/vim-orgmode'
Plug 'racer-rust/vim-racer'
Plug 'wlangstroth/vim-racket'
Plug 'luochen1990/rainbow'

let g:racer_cmd = "/home/leo/.cargo/bin/racer"
let g:racer_experimental_completer = 1

let g:rainbow_active = 1

call plug#end()

colorscheme alduin

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set copyindent

set hidden
set number
set showcmd
set cursorline
set wildmenu
set showmatch

set wrap 
set linebreak
set nolist
set textwidth=0
set wrapmargin=0

nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j

set encoding=UTF-8

let NERDTreeShowHidden=1

map <C-o> :NERDTreeToggle<CR>

highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight CursorLine ctermbg=none
highlight LineNr ctermbg=none
highlight LineNr ctermfg=darkgrey
highlight Statement ctermfg=gray cterm=bold
highlight Function ctermfg=darkred cterm=bold
highlight Special ctermfg=darkred cterm =bold

