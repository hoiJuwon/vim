call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-surround'
Plug 'neoclide/coc.nvim'
Plug 'w0rp/ale'
Plug 'prettier/vim-prettier'
Plug 'raimondi/delimitmate'
Plug 'owickstrom/vim-colors-paramount'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
call plug#end()

let mapleader = ","

colorscheme paramount

" for typescript
let g:coc_global_extensions = [ 'coc-tsserver' ]
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" for eslint
let g:ale_fixers = {
 \ 'javascript': ['eslint']
 \ }
let g:ale_fix_on_save = 1

" for prettier
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0

" for fzf
nnoremap <silent> <C-f> :Files<CR>

set encoding=UTF-8
set fileencodings=UTF-8

set et
set ts=2
set sts=2
set sw=2
setlocal wildignore=*/__pycacehe__/*,*.pyc
setlocal wildignore=*/.node_modules
set wildignore=*/node_modules/*
set cursorline

syntax enable
set number
set mousehide
set bg=dark

set hlsearch
set incsearch
set smartcase

set path+=**

set autoindent
set smartindent
set nowrap

set history=100
set autowrite
set laststatus=2
set wildmenu

" SNIPPETS:
nnoremap ,html :-1read $HOME/.vim/.skeleton.html<CR>10G
nnoremap ,rt :-1read $HOME/.vim/.skeleton.js<CR>9Geeeciw<C-R>=expand("%:t:r")<cr>

function! MyStatusLine()
    let statusline = ""
    " Filename (F -> full, f -> relative)
    let statusline .= "%f"
    " Buffer flags
    let statusline .= "%( %h%1*%m%*%r%w%) "
    " File format and type
    let statusline .= "%="
    " Line & column
    let statusline .= "(%l,%c%V) "
    return statusline
endfunction

" Status line
set statusline=%!MyStatusLine()

" netrw
let g:netrw_liststyle = 3
let g:netrw_list_hide = '^\.\.\=/\=$,.DS_Store,.idea,.git,__pycache__,venv,node_modules,*\.o,*\.pyc,.*\.swp'
let g:netrw_hide = 1
