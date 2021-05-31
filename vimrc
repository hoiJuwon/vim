let mapleader = ","

set encoding=UTF-8
set fileencodings=UTF-8
set et
set ts=2
set sts=2
set sw=2
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype solidity setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
setlocal wildignore=*/__pycacehe__/*,*.pyc
setlocal wildignore=*/.node_modules
set wildignore=*/.node_modules/* 

" set cursorline
syntax enable
" set number
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

" using buffer 
nnoremap <leader>f :ls<CR>:b<Space>

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

highlight clear SignColumn
hi Pmenu ctermbg=darkgray ctermfg=white

call plug#begin('~/.vim/plugged')
Plug 'alvan/vim-closetag'
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-surround'
Plug 'neoclide/coc.nvim'
Plug 'scrooloose/nerdtree'
Plug 'prettier/vim-prettier'
Plug 'raimondi/delimitmate'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'leafgarland/typescript-vim'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'tomlion/vim-solidity'
"Plug 'w0rp/ale'
call plug#end()
" for typescript
" let g:coc_global_extensions = [ 'coc-tsserver' ]

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" for eslint
"let g:ale_fixers = {
" \ 'javascript': ['eslint']
" \ }
"let g:ale_fix_on_save = 1

" for prettier
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0

" for fzf
nnoremap <silent> <C-f> :Files<CR>

" for nerdtree
let g:NERDTreeRespectWildIgnore = 1

" for closetag
let g:closetag_filenames = '*.html,*.xhtml,*.phtml, *.jsx, *.tsx'

" for delimitmate
let delimitMate_expand_cr=1

" use <Tab> key to trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
