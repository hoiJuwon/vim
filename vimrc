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

set number relativenumber

" set cursorline
syntax enable
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
set modifiable

" SNIPPETS:
nnoremap ,html :-1read $HOME/.vim/.skeleton.html<CR>10G
nnoremap ,rt :-1read $HOME/.vim/.skeleton.js<CR>9Geeeciw<C-R>=expand("%:t:r")<cr>

" using buffer 
nnoremap <leader>f :ls<CR>:b<Space>

" using tabnew
nnoremap <leader>t :tabnew<CR>:Files<CR>

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

command! MakeTags !ctags -R .

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <ESC> <C-C>
inoremap jj <ESC>
set updatetime=250

call plug#begin('~/.vim/plugged')
Plug 'dense-analysis/ale'
Plug 'alvan/vim-closetag'
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-surround'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree'
Plug 'raimondi/delimitmate'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'leafgarland/typescript-vim'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'tomlion/vim-solidity'
Plug 'rust-lang/rust.vim'
Plug 'vyperlang/vim-vyper'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'ambv/black'


call plug#end()
" for typescript
" let g:coc_global_extensions = [ 'coc-tsserver' ]

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" for fzf
nnoremap <silent> <C-f> :Files<CR>

" for fzf
nnoremap <silent> <C-g> :Ag<CR>

" for nerdtree
let g:NERDTreeRespectWildIgnore = 1

" for closetag
let g:closetag_filenames = '*.html,*.xhtml,*.phtml, *.jsx, *.tsx'

" for delimitmate
let delimitMate_expand_cr=1

" use <Tab> key to trigger completion and navigate to the next complete item
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(0) : "\<C-h>"
" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument

" vim-gitgutter
" Use fontawesome icons as signs
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '>'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = '<'

augroup black_on_save
  autocmd!
  autocmd BufWritePre *.py Black
augroup end
let g:black_quiet = 1

let g:ale_linters={
\ 'python': ['pylint'],
\}
let g:ale_completion_enabled = 1

autocmd BufWritePost *.py execute ':Black'
