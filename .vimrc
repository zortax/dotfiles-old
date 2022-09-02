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
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sleuth'
Plug 'junegunn/goyo.vim'
Plug 'zortax/vim-two-firewatch'
Plug 'tpope/vim-fugitive'
Plug 'majutsushi/tagbar'
Plug 'tikhomirov/vim-glsl'
Plug 'guns/xterm-color-table.vim'
Plug 'cstrahan/vim-capnp'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'lambdalisue/glyph-palette.vim'
Plug 'terryma/vim-smooth-scroll'
Plug 'wellle/context.vim'
Plug 'mhartington/oceanic-next'
Plug 'christianchiarulli/nvcode-color-schemes.vim'
Plug 'sainnhe/everforest'


if has('nvim')
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'akinsho/bufferline.nvim'
  Plug 'nvim-treesitter/nvim-treesitter'
  Plug 'kyazdani42/nvim-tree.lua'
  Plug 'marko-cerovac/material.nvim'
else
  Plug 'preservim/nerdtree'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  Plug 'Xuyuanp/nerdtree-git-plugin'
endif

call plug#end()

""""""""""""""""""""""""
" Plugin Configuration
""""""""""""""""""""""""

""""""""""""""""""""""""""""
" Nvim Plugin Configuration
""""""""""""""""""""""""""""
if has('nvim')

set mouse=a    

" Bufferline

lua << EOF
require("bufferline").setup{
  options = {
    diagnostics = false,
    separator_style = "thin",
    offsets = {
      {
        filetype = "NvimTree",
        text = "Files",
        highlight = "BufferLineFill",
        text_align = "center"
      }
    },
  }
}
EOF

" Treesitter
lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  sync_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
EOF

" nvim-tree
lua << EOF
require'nvim-tree'.setup {
  view = {
    width = 40
  }
}
EOF
nnoremap <C-o> :NvimTreeToggle<CR>

else
  " Plugin configuration for non-nvim plugins
  
  " nerdtree
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
  autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

  let g:NERDTreeDirArrowExpandable = '▸'
  let g:NERDTreeDirArrowCollapsible = '▾'

  let g:NERDTreeShowHidden=1

  map <C-o> :NERDTreeToggle<CR>
endif




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

" coc

" Tigger completion with Tab

inoremap <silent><expr> <TAB>
  \ coc#pum#visible() ? coc#_select_confirm() :
  \ coc#expandableOrJumpable() ?
  \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Use <c-space> to trigger completion
if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

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
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Code actions
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>aw   <Plug>(coc-codeaction-selected)w

"set <a-cr>=^[^M
nmap <a-cr> <Plug>(coc-codeaction-selected)j


" vimtex
let g:vimtex_view_method = 'zathura'
let g:vimtex_quickfix_enabled = 0
let g:tex_conceal = ""
let g:tex_flavor = 'latex'

" vim-autoformat
nmap <C-l> :Autoformat<CR>
let g:formatter_yapf_style = 'pep8'

" GLSL support
autocmd! BufNewFile,BufRead *.vs,*.vsh,*.fs,*.fsh set ft=glsl

" Smoot Scroll
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

"""""""""
" Setup
"""""""""

" Python support
let g:python3_host_prog = '/usr/bin/python3'
let g:python2_host_prog = '/usr/bin/python2'

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
" Colorscheme

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
let g:everforest_background = 'soft'
silent! colorscheme everforest
hi Normal guibg=NONE ctermbg=NONE

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

let g:terminal_color_0 = '#101010'
let g:terminal_color_8 = '#39414E'

let g:terminal_color_1 = '#EFA6A2'
let g:terminal_color_9 = '#E0AF85'

let g:terminal_color_2 = '#80C990'
let g:terminal_color_10 = '#5ACCAF'

let g:terminal_color_3 = '#A69460'
let g:terminal_color_11 = '#C8C874'

let g:terminal_color_4 = '#A3B8EF'
let g:terminal_color_12 = '#CCACED'

let g:terminal_color_5 = '#E6A3DC'
let g:terminal_color_13 = '#F2A1C2'

let g:terminal_color_6 = '#50CACD'
let g:terminal_color_14 = '#74C3E4'

let g:terminal_color_7 = '#808080'
let g:terminal_color_15 = '#C0C0C0'

set conceallevel=0

" Undercurl errors/warning
hi CocErrorHighlight guifg=#dc5151 gui=undercurl
hi CocWarningHighlight guifg=#c4ab39 gui=undercurl

" Signs
hi CocErrorSign guifg=#dc5151
hi CocWarningSign guifg=#c4ab39
hi CocInfoSign guifg=#6580ad

if has('nvim')
  hi NvimTreeNormal guibg=#1F1F1F
  autocmd VimEnter * hi BufferLineFill guibg=#2C323C
  autocmd VimEnter * hi BufferLineBackground guibg=#2C323C
  autocmd VimEnter * hi BufferLineSeparator guibg=#2C323C
  autocmd VimEnter * hi BufferLineCloseButton guibg=#2C323C
  autocmd VimEnter * hi BufferLineModified guibg=#2C323C
  autocmd VimEnter * hi BufferLineDuplicate guibg=#2C323C
  autocmd VimEnter * hi Normal guibg=NONE ctermbg=NONE
  autocmd VimEnter * syntax on
endif

