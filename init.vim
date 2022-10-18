

set clipboard=unnamed
if has("unnamedplus")
        set clipboard+=unnamedplus
endif

colorscheme default
syntax on
set background=dark

set number
set nowrap
set hidden

" Search
set incsearch
set hlsearch
set ignorecase
set smartcase
" Set search register to empty
let @/ = ""
" Yank line
nnoremap yy ^y$
" Yank entire file
nnoremap YY ggVGy

" Indentation
set autoindent
set smartindent
set shiftwidth=4
set expandtab
set smarttab
set tabstop=4
set softtabstop=4
set shiftround

" Folding
set foldmethod=syntax
set foldnestmax=10
set nofoldenable
set foldlevel=1

" Other
set scrolloff=3 " Vertical
set sidescroll=1
set sidescrolloff=10 " Horizontal
set showcmd
set cursorline
set cursorcolumn
set laststatus=2
set backspace=indent,eol,start
set notimeout
set ttimeout
set ttimeoutlen=10
set showbreak=>
set splitright
set splitbelow
set lazyredraw
set synmaxcol=300

" If an xterm or rxvt terminal, change cursor for mode
if &term =~ "xterm\\|rxvt"
    let &t_SI="\033[5 q"
    let &t_EI="\033[1 q"
endif

" set dictionary += ...
set completeopt=menuone,noinsert
set wildmode=longest,list

" Whitespace
set list
set listchars=extends:>,precedes:<,tab:\|\ ,eol:↲

set wildignore+=*.pyc,*.luac
set wildignore+=*.DS_Store
set wildignore+=*.hg,*.git,*.svn

" Some plugins require external dependencies
" ripgrep
if !executable('rg')
    let v:errmsg = "rg not found!, some plugins may not work\n" .
                \ "Please install ripgrep: https://github.co/BurntSushi/ripgrep#installation"
    echo v:errmsg
endif



" Plugins!
call plug#begin(stdpath('data') . '/plugged')

Plug 'tpope/vim-sensible'               " Some sensible defaults

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } " A nice filemanager
" Plug 'vim-airline/vim-airline'          " Status line modifications
" Plug 'vim-airline/vim-airline-themes'   " Themes for Status line
Plug 'tpope/vim-fugitive'               " Git integration (gutter)
Plug 'tpope/vim-surround'               " Surrounding with things
Plug 'crusoexia/vim-monokai'            " Monokai color scheme
Plug 'ryanoasis/vim-devicons'          " Dev icons for common filetypes
" Plug 'godlygeek/tabular'                " Tabulate lines of text
Plug 'flazz/vim-colorschemes'           " Pack of colorschemes
Plug 'github/copilot.vim'               " Github Copilot
Plug 'bronson/vim-trailing-whitespace'  " Shows trailing whitespace in red, :FixWhitespace
Plug 'rgarver/Kwbd.vim'                 " Close a buffer without closing the window
Plug 'chrisbra/NrrwRgn'                 " Edit a selected region in isolation
Plug 'jeetsukumaran/vim-indentwise'     " Cursor movement based on indentation levels
Plug 'garbas/vim-snipmate'              " Provides Textmate style snippet completion
        Plug 'MarcWeber/vim-addon-mw-utils'     " Dependency for Snipmate
        Plug 'tomtom/tlib_vim'                  " Dependency for Snipmate
        Plug 'honza/vim-snippets'               " Provides snippets for Snipmate
Plug 'nvim-telescope/telescope.nvim'    " Provides a fuzzy finder
        Plug 'nvim-lua/plenary.nvim'    " Dependency of Telescope
        " Plug 'BruntSushi/ripgrep.nvim'  " Dependency of Telescope
        Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' } " FIXME: Requires further setup
        Plug 'chip/telescope-software-licenses.nvim'    " FIXME: Requires further setup
        Plug 'nvim-telescope/telescope-symbols.nvim'    " 
Plug 'Acks1D/nvim-neoclip.lua'                  " FIXME: Requires further setup
" Language
Plug 'numirias/semshi'                  " Python semantic highlighting.
Plug 'dhruvasagar/vim-table-mode'       " Provides table manipulation. FIXME: Requires further setup
Plug 'junegunn/vim-easy-align'          " Like Tabular, but more feature rich. FIXME: Requires further setup
Plug 'dimfred/resize-mode.nvim'         " Window resizing. TODO: Evaluate FIXME: Requires further setup
Plug 'neovim/nvim-lspconfig'            " Configs for Neovim LSP. FIXME: Requires further setup
Plug 'nvim-lualine/lualine.nvim'        " Like Airline, but better and faster. FIXME: Requires further setup
Plug 'numToStr/Comment.nvim'            " Manages creating and removing comments. FIXME: Requires further setup
Plug 'svermeulen/vimpeccable'           " Lua vimrc API. FIXME: Requires further setup

call plug#end()

" -------- Plugin Setup -------- "
lua << EOF
-- Comment
require("Comment").setup()

local api = require("Comment.api")
vim.keymap.set("n", "<C-/>", api.toggle.linewise.current)
vim.keymap.set("v", "<C-/>", function()
    -- vim.api.nvim_feedkeys(api.toggle.visual(), "n", true)
    api.toggle.blockwise(vim.fn.visualmode())
end)
--
EOF


" -------- Mappings -------- "

" Folding using spacebar
nnoremap <space> za
vnoremap <space> za
" Better line movement
nnoremap j gj
nnoremap k gk
" Esc removes highlighting
nnoremap <silent><esc> :noh<CR>
nnoremap <esc>^[ <esc>^[
" Goto Buffer
nnoremap ]b :bprev<CR>
nnoremap [b :bnext<CR>
nnoremap ]q :bd <bar> :bnext<CR>
nnoremap [q :bd <bar> :bprev<CR>
" TODO: Not sure what these do
nnoremap * *``
nnoremap # #``
" :W => :w
cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))
" F3
nnoremap <silent><F3> :set paste!<CR>
imap <silent><F3> <C-O><F3> " execute F3 in insert mode
vmap <silent><F3> <C-O><F3> " execute F3 in visual mode
" F4
nnoremap <silent><F4> :NERDTreeToggle<CR>
imap <silent><F4> <C-O><F4> " execute F4 in insert mode
" F6
nnoremap <silent><F6> :set spell!<CR>
imap <silent><F6> <C-O><F6> " execute F6 in insert mode
vmap <silent><F6> <C-O><F6> " execute F6 in visual mode
" Sensible Split Manipulation
" TODO: Implement later


" Display the F key mappings
function! FKeyMappings()
        for i in range(1, 12)
                let l:f = '<F'.i.'>'
                let l:map = mapcheck(l:f, 'n')
                if l:map != ""
                        echo l:f . ' = ' . l:map
                endif
        endfor
endfunction
command! FKeyMappings call FKeyMappings()
" F1
nmap <silent><F1> :FKeyMappings<CR>
" F10
map <F10> :echo 'hi<' . synIDattr(synID(line('.'),col('.'),1),'name') . '> trans<' . synIDattr(synID(line('.'),col('.'),0),'name') . '> lo<' . synIDattr(synIDtrans(synID(line('.'),col('.'),1)),'name') . '>' . ' FG:' . synIDattr(synIDtrans(synID(line('.'),col('.'),1)),'fg#')<CR>

" Number toggling
function! ToggleNumberMode()
        if(&relativenumber == 1)
                set norelativenumber
        else
                set relativenumber
        endif
endfunction
" F2
nnoremap <F2> :call ToggleNumberMode()<CR>

" Entering and leaving Buffer hooks
function BufEnter()
endfunction

function BufLeave()
endfunction

" autocmd's
augroup Focus
        autocmd!
        autocmd BufEnter,FocusGained,WinEnter,BufWinEnter * :call BufEnter()
        autocmd BufLeave,FocusLost,WinLeave,BufWinLeave * :call BufLeave()
augroup END


lua <<EOF

-- local Plug = vim.fn["plug#"]

-- vim.call("plug#begin")
-- vim.call("plug#end")

EOF
