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
set notermguicolors

autocmd FileType markdown setlocal conceallevel=2

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

" highlight clear SignColumn
" hi Pmenu ctermbg=darkgray ctermfg=white

command! MakeTags !ctags -R .

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <ESC> <C-C>
inoremap jj <ESC>
set updatetime=250

call plug#begin('~/.vim/plugged')
Plug 'alvan/vim-closetag'
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-surround'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree'
Plug 'raimondi/delimitmate'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'leafgarland/typescript-vim'
Plug 'tomlion/vim-solidity'
Plug 'rust-lang/rust.vim'
Plug 'vyperlang/vim-vyper'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" Telescope 및 필수/추천 플러그인
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" 속도 향상을 위한 C 확장 (make나 gcc 필요, 없으면 생략 가능하지만 설치 추천)
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

Plug 'epwalsh/obsidian.nvim'
" Plug 'junegunn/fzf.vim'
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

call plug#end()
" for typescript
" let g:coc_global_extensions = [ 'coc-tsserver' ]

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" for fzf
" nnoremap <silent> <C-f> :Files<CR>

" for fzf
" nnoremap <silent> <C-g> :Ag<CR>

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

" disable copilot
let g:copilot_enabled = v:false

" 파일 저장 직전, pyright의 전용 import 정리 명령어를 실행
autocmd BufWritePre *.py CocCommand pyright.organizeimports

nnoremap <silent> <C-f> <cmd>Telescope find_files<cr>
nnoremap <silent> <C-g> <cmd>Telescope live_grep<cr>
nnoremap <leader>f <cmd>Telescope buffers<cr>
nnoremap <leader>t :tabnew<CR><cmd>Telescope find_files<CR>

" for 'obsidian'
" 새 노트 만들기 (:ObsidianNew 제목)
nnoremap <leader>on :ObsidianNew<Space>
" 백링크 보기 (현재 노트를 언급한 다른 노트들) -> Telescope UI
nnoremap <leader>ob :ObsidianBacklinks<CR>
" 태그 검색
nnoremap <leader>ot :ObsidianTags<CR>
" Daily Note 열기/생성
nnoremap <leader>od :ObsidianToday<CR>

" --- lua 설정
lua << EOF
local telescope = require('telescope')
local builtin = require('telescope.builtin')

telescope.setup{
  defaults = {
    -- UI 설정 (원하는 스타일로 변경 가능)
    layout_strategy = 'horizontal',
    layout_config = { prompt_position = "top" },
    sorting_strategy = "ascending",
    winblend = 0,
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  }
}

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = {"*"},
  callback = function()
    local current_file = vim.fn.expand("%:p")
    if string.find(current_file, "ObsidianVault") then
      vim.opt_local.wrap = true
      vim.opt_local.linebreak = true
      vim.opt_local.breakindent = true
    end
  end,
})

local function switch_to_english()
  vim.fn.system({'im-select', 'com.apple.keylayout.ABC'})
end

vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  callback = switch_to_english,
})

-- FZF Native 확장 로드 (설치했다면)
pcall(telescope.load_extension, 'fzf')
require("obsidian").setup({
  workspaces = {
    {
      name = "personal",
      path = "/Users/choijuwon/Library/Mobile Documents/iCloud~md~obsidian/Documents/ObsidianVault/", -- [수정필요] 아까 만든 실제 폴더 경로
    },
  },

  -- [중요] CoC를 사용 중이므로 nvim-cmp 자동완성은 끕니다 (충돌 방지)
  completion = {
    nvim_cmp = false,
    min_chars = 2,
  },

  -- [UI 설정] 체크박스, 불렛 등을 예쁘게 보여줍니다
  ui = {
    enable = true,
  },

  -- [키 매핑] 노트 안에서 작동하는 핵심 키
  mappings = {
    -- 'gf': 커서 아래의 [[링크]] 파일로 이동 (없으면 생성할지 물어봄)
    ["gf"] = {
      action = function()
        return require("obsidian").util.gf_passthrough()
      end,
      opts = { noremap = false, expr = true, buffer = true },
    },
    -- 'Enter': 링크 파일로 이동 (gf와 유사하지만 좀 더 스마트함)
    ["<cr>"] = {
      action = function()
        return require("obsidian").util.smart_action()
      end,
      opts = { buffer = true, expr = true },
    },
    -- 체크박스 토글 (선택 사항)
    ["<leader>ch"] = {
      action = function()
        return require("obsidian").util.toggle_checkbox()
      end,
      opts = { buffer = true },
    },
  },
  
  disable_frontmatter = false,
  daily_notes = {
    folder = "daily_notes",
    date_format = "%Y/%m/%Y-%m-%d",
    alias_format = "%B %-d, %Y",
    template = "Daily.md",
    auto_create_if_missing = true,
  },
  templates = {
    subdir = "templates",
    date_format = "%Y-%m-%d",
    time_format = "%H:%M",
    substitutions = {},
  },
  note_id_func = function(title)
    -- 제목이 있으면 그대로 파일명으로 사용
    local suffix = ""
    if title ~= nil then
      -- 특수문자만 대충 걸러내고 제목 그대로 사용
      return title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
    else
      -- 제목 없이 생성하면 랜덤 4자리 ID 부여
      for _ = 1, 4 do
        suffix = suffix .. string.char(math.random(65, 90))
      end
      return tostring(os.time()) .. "-" .. suffix
    end
  end,
})
EOF
