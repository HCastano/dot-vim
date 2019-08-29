" Need this to get Syntastic to play nice
let shell="/bin/zsh -i"

" Remap the leader character
let mapleader = ","

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Configure Vim-Plug
call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

Plug 'dense-analysis/ale'

Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'

Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-bufword'

Plug 'rust-lang/rust.vim'

call plug#end()

" Make backspace behave in a sane manner.
set backspace=indent,eol,start

" Switch syntax highlighting on
syntax enable

" Use the dracula colour scheme
" colorscheme dracula

" Enable file type detection and do language-dependent indenting.
filetype plugin indent on

" Make tab characters appear eight spaces wide
" Want to keep this at 4 for width concerns
set tabstop=4

" Make an indent ('>>' or '<<') correspond to a single tab
set shiftwidth=4

" Control the number of columns vim uses when tab is hit
set softtabstop=4

" Make tab key insert tabs instead of spaces
set noexpandtab

" Make tab key insert spaces instead of tab characters
set expandtab

" Show line hybrid numbers
set number
set relativenumber

" Change colour of non-current line numbers to gray
highlight LineNr ctermfg=grey

" Show cursor position
set ruler

" Allow hidden buffers, don't limit to 1 file per window/split
set hidden

" Display unprintable characters.
set list

" Make tabs, trailing whitespace, and EOL charaters easy to spot
set listchars=tab:▸\ ,trail:·,eol:¬

" Don't wrap lines
set nowrap

"Wrap lines when convenient. Doesn't affect text, only display
set linebreak

"Make all lines 79 characters or less
set textwidth=79

" Minimal number of screen lines to keep above and below the cursor
set scrolloff=8

" Set Markdown syntax highlighting for *.md files
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

" Remap the escape key to jk
inoremap jk <esc>

" Stay away from bad habits
inoremap <esc> <nop>

noremap <C-l> gt
noremap <C-h> gT

" Key shortcut for opening NERDTree
map <C-n> :NERDTreeToggle<CR>

" Show hidden files in NERDTree
let NERDTreeShowHidden=1

" " Remove trailing whitespaces on save while keeping current cursor position
" " https://stackoverflow.com/questions/356126/how-can-you-automatically-remove-trailing-whitespace-in-vim
" fun! <SID>StripTrailingWhitespaces()
"     let l = line(".")
"     let c = col(".")
"     %s/\s\+$//e
"     call cursor(l, c)
" endfun
"
" autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
"
" Auto Completion Engine
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
"
" Tab to select
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
"
" " Language Server Integration
" let g:LanguageClient_serverCommands = {
"     \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
"     \ }
"
" let g:LanguageClient_autoStart = 1
"
" nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
" nnoremap <silent> ,jd :call LanguageClient_textDocument_definition()<CR>
" nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

" Linter Settings

" Only Lint on Save
let g:ale_lint_on_text_changed = 'never'

" Use Rust Language Server
let g:ale_linters = {'rust': ['rls']}

" Use `cargo check` instead of `cargo build`
let g:ale_rust_cargo_use_check = 1

" Config options can be found here: https://github.com/rust-lang/rls
let g:ale_rust_rls_config = {
	\ 'rust': {
		\ 'build_on_save': 1,
	\ }
	\ }

let g:ale_sign_error = "✖"
let g:ale_sign_warning = "⚠"
let g:ale_sign_info = "i"
let g:ale_sign_hint = "➤"

nnoremap <silent> K :ALEHover<CR>
nnoremap <silent> gd :ALEGoToDefinition<CR>
"
" " Vim Gutter Settings
" " Quicker update time (default is 4s)
" set updatetime=250
"

" " Better search binding
noremap <leader>s :Rg<CR>
noremap <leader>sf :Files<CR>
"
" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Fzf Layout
" let g:fzf_layout = { 'down': '~40%' }
let g:fzf_layout = { 'window': '12split enew' }
