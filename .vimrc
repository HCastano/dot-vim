" Need this to get Syntastic to play nice
let shell="/bin/zsh -i"

" Remap the leader character
let mapleader = ","

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Configure Vim-Plug
call plug#begin('~/.vim/plugged')

Plug 'itchyny/lightline.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-fugitive'

Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'

Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-bufword'

Plug 'rust-lang/rust.vim'

Plug 'machakann/vim-highlightedyank'

Plug 'vimwiki/vimwiki'

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
set textwidth=89

" Minimal number of screen lines to keep above and below the cursor
set scrolloff=8

" Permanent undo
set undodir=~/.vimdid
set undofile

set mouse=a " Enable mouse usage (all modes) in terminals

" au Filetype rust set colorcolumn=80

" Set Markdown syntax highlighting for *.md files
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

" Remap the escape key to jk
inoremap jk <esc>

" Stay away from bad habits
inoremap <esc> <nop>

noremap <C-l> gt
noremap <C-h> gT

" Search results centered please
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz

" Ctrl+h to stop searching
vnoremap <C-h> :noh<cr>
nnoremap <C-h> :noh<cr>

" Key shortcut for opening NERDTree
map <C-n> :NERDTreeToggle<CR>

" Show hidden files in NERDTree
let NERDTreeShowHidden=1

" Auto Completion Engine
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
"
" Tab to select
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" CoC Settings
" Most of these are defaults from https://github.com/neoclide/coc.nvim

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

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
  else
    call CocAction('doHover')
  endif
endfunction

" NOTE: There's more stuff in the suggested starter file, but
" I think these settings are fine to start off with

" Searching

" " Vim Gutter Settings
" " Quicker update time (default is 4s)
" set updatetime=250
"

" " Better search binding
noremap <leader>s :Rg<CR>
noremap <leader>sf :Files<CR>
noremap <leader>b :Buffers<CR>
"
" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Fzf Layout
" let g:fzf_layout = { 'down': '~40%' }
let g:fzf_layout = { 'window': '12split enew' }

" https://codeyarns.com/2017/10/25/how-to-show-full-file-path-in-lightline/
" Replace filename component of Lightline statusline
let g:lightline = {
      \ 'component_function': {
      \   'filename': 'FilenameForLightline',
      \ }
      \ }

" Show full path of filename
function! FilenameForLightline()
    return expand('%')
endfunction

" <leader><leader> toggles between buffers
nnoremap <leader><leader> <c-^>

let g:vimwiki_list = [{'path': '~/.vimwiki', 'template_path': '~/.vimwiki/templates/',
          \ 'template_default': 'default', 'syntax': 'markdown', 'ext': '.wiki',
          \ 'path_html': '~/.vimwiki/site_html/', 'custom_wiki2html': 'vimwiki_markdown',
          \ 'html_filename_parameterization': 1,
          \ 'template_ext': '.tpl'}]
