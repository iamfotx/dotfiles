"Auto install Plug https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins

call plug#begin('~/.vim/plugs')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
" Plug 'preservim/nerdtree'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'wellle/targets.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
"Plug 'rstacruz/vim-closer'
"Plug 'Raimondi/delimitMate'
"Plug 'tpope/vim-endwise'
Plug 'jiangmiao/auto-pairs'
Plug 'ervandew/supertab'
"Plug 'lifepillar/vim-mucomplete'
Plug 'wincent/command-t', {
  \ 'do': 'cd ruby/command-t/ext/command-t && ruby extconf.rb && make' }
Plug 'wincent/terminus'
Plug 'sheerun/vim-polyglot'
Plug 'jxnblk/vim-mdx-js'
Plug 'mileszs/ack.vim'
Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'dense-analysis/ale'
Plug 'jparise/vim-graphql' "graphql syntax highlighting
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'pangloss/vim-javascript'

call plug#end()

" Keep .swp files in uniquely-named files in $HOME/.vim/swapfiles
set directory=$HOME/.vim/swapfiles//
set timeoutlen=1000        " speed vim up
set ttimeoutlen=0          " https://stackoverflow.com/questions/37644682/why-is-vim-so-slow/37645334
set ttyfast                " Rendering
set tw=500

" Use , as <Leader>
let mapleader = ","

" map jk to esc
:imap kj <Esc>

" Use %% on the command line to expand to the dir of the current file
cnoremap <Expr> %% expand("%:h") . "/"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Editing

" Use . in visual mode to execute the dot command on each selected line
xnoremap . :normal .<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Formatting

set expandtab           " use spaces instead of tabs
set tabstop=2           " use 2 char width for tabs
set shiftwidth=2        " use 2 spaces for indent
set textwidth=80        " auto wrap text at 80 chars
set linebreak           " when wrapping, break on word boundaries

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Linting

set signcolumn=yes                  " always show the signcolumn on LH side
let g:ale_set_highlights = 0        " don't highlight first char of errors
let g:ale_completion_enabled = 1    " enable completion when available

let g:ale_linters = {
\ 'javascript': ['eslint'],
\ 'typescript': ['eslint', 'tsserver']
\}
let g:ale_linters_ignore = {
\ 'typescript': ['tslint']
\}

let g:ale_fix_on_save = 1
let g:ale_fixers = {
\ 'css': ['prettier'],
\ 'html': ['prettier'],
\ 'javascript': ['prettier'],
\ 'typescript': ['prettier'],
\ 'json': ['prettier']
\}

" Use <Leader>aj or <Leader>ak for quickly jumping between lint errors
nmap <silent> <Leader>aj :ALENext<cr>
nmap <silent> <Leader>ak :ALEPrevious<cr>

" Blink cursor on error instead of beeping (grr)
set visualbell
set t_vb=

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Movement

" Always move linewise in normal mode
nnoremap k gk
nnoremap j gj

" Preserve indentation when moving lines
" See http://vim.wikia.com/wiki/Moving_lines_up_or_down
nnoremap <C-j> :m .+1<Return>==
nnoremap <C-k> :m .-2<Return>==
vnoremap <C-j> :m '>+1<Return>gv=gv
vnoremap <C-k> :m '<-2<Return>gv=gv

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Appearance

set splitbelow          " open split panes on bottom (instead of top)
set splitright          " open split panes on right (instead of left)

set laststatus=2        " always show status bar

" adds blue highlight to vim in visual mode selections
highlight Visual cterm=bold ctermbg=Blue ctermfg=NONE
" Change cursor shape between insert and normal mode in iTerm2.app
if $TERM_PROGRAM =~ "iTerm"
  let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
  let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif

" Shows the title within the window
set title titlestring=

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Copy/paste

set clipboard=unnamed   " copy to the clipboard when yanking

" Re-select the last pasted text with `gp`
nnoremap gp `[v`]

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Line numbers

:set relativenumber
:set nu

" Toggle line numbers with <Leader>n
noremap <Leader>n :set number!<Return>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Wrapping

set wrap                " wrap long lines by default
set linebreak           " when wrapping, break on word boundaries

" Toggle wrapping with <Leader>w
noremap <Leader>w :set wrap!<Return>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Searching

set ignorecase          " ignore case when searching
set smartcase           " don't ignore case if using any uppercase
set hlsearch            " highlight matches

" Clear highlighting for the current search with <Leader>/
" Adapted from https://stackoverflow.com/questions/657447/vim-clear-last-search-highlighting/657484#657484
nnoremap <Leader>/ :let @/ = ""<Return>

" Open :Ack with <Leader>a
nnoremap <Leader>a :Ack<Space>
vnoremap <Leader>a :Ack<Space>

" Ignore node_modules with command-t
let g:CommandTWildIgnore = &wildignore . ",*/node_modules"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax

let g:jsx_ext_required = 0          " allow JSX in .js files
let g:javascript_plugin_flow = 1    " allow Flow in .js files

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors

set termguicolors       " enable gui colors in the terminal

" Use current terminal color scheme for vim
if filereadable(expand("~/.vimrc_background"))
  "let base16colorspace = 256
  source ~/.vimrc_background
endif

" Sync vim-airline colors with current base16 color scheme
let g:airline_theme='base16'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Netrw

" Allow netrw to remove non-empty local directories
let g:netrw_localrmdir = "trash"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Goyo

" Automatically enable/disable Limelight with Goyo
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

let g:goyo_width = 82   " give Goyo 1 column on either side

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" .vimrc

nnoremap <leader>av :tabnew $MYVIMRC<CR>
noremap <leader>rv :source $MYVIMRC<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  Commentary

nmap <leader>c :Commentary<CR>
vmap <leader>c :Commentary<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle file drawer in/out

" nmap ,n :NERDTreeFind<CR>
" nmap ,m :NERDTreeToggle<CR>

" let g:NERDTreeWinPos = "right"



" clear registers
command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor
