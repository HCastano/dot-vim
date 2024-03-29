" Need this to get Syntastic to play nice
let shell="/bin/zsh -i"

" Remap the leader character
let mapleader = "\<Space>"

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

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'

Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-bufword'

Plug 'rust-lang/rust.vim'

Plug 'machakann/vim-highlightedyank'

Plug 'vimwiki/vimwiki'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

Plug 'merlinrebrovic/focus.vim'
Plug 'unblevable/quick-scope'

Plug 'luochen1990/rainbow'

Plug 'arcticicestudio/nord-vim'

call plug#end()

" Make backspace behave in a sane manner.
set backspace=indent,eol,start

" Switch syntax highlighting on
syntax enable

" Use 'true' 24-bit colours if available
if (has("termguicolors"))
  set termguicolors
endif

" Make use of italic font styles in comments
let g:nord_italic = 1
let g:nord_italic_comments = 1

" Make diff highlighting less overwhelming
let g:nord_uniform_diff_background = 1

" Use the Nord colour scheme
colorscheme nord

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
set listchars=tab:\ \ ┊,trail:·,eol:¬

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

" Source config file
nmap <leader>src :source ~/.vimrc<CR>

noremap <C-l> gt
noremap <C-h> gT

" Search results centered please
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz

" Ctrl+n to stop highlighting search results
vnoremap <C-n> :noh<cr>
nnoremap <C-n> :noh<cr>

" Copy to system clipboard
set clipboard+=unnamedplus

" Make moving between windows a bit easier
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" When opening new windows set the cursor on the more natural window
set splitbelow
set splitright

" Auto Completion Engine
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
"
" Tab to select
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Vim-Fugitive Bindings
nmap <Leader>gst :Git<CR>
nmap <Leader>gc :Git commit<CR>
nmap <Leader>gd :Gvdiffsplit<CR>

" Find out who I need to yell at
nmap <Leader>gb :Git blame<CR>



" Make use of italic font styles in comments
let g:nord_italic = 1
let g:nord_italic_comments = 1

" Make diff highlighting less overwhelming
let g:nord_uniform_diff_background = 1
" Searching

" Bindings for FZF-Preview Plugin
"
" Note: This is currently installed as a Coc Plugin.
" Install with: `:CocInstall coc-fzf-preview`

let g:fzf_preview_command = 'bat --color=always --theme=TwoDark {-1}'

nmap <Leader>f [fzf-p]
xmap <Leader>f [fzf-p]

" Have a sane default if I don't press anything after [fzf-p]
nnoremap <silent> [fzf-p]      :<C-u>CocCommand fzf-preview.FromResources project_mru git<CR>

" Now for the useful bindings
nnoremap <silent> [fzf-p]p     :<C-u>CocCommand fzf-preview.FromResources project_mru git<CR>

" Searching with '.' as argument so we can open the search box without any arguments
nnoremap          [fzf-p]s    :<C-u>CocCommand fzf-preview.ProjectGrep<Space>.<CR>
xnoremap          [fzf-p]s    "sy:CocCommand   fzf-preview.ProjectGrep<Space>-F<Space>"<C-r>=substitute(substitute(@s, '\n', '', 'g'), '/', '\\/', 'g')<CR>"

nnoremap <silent> [fzf-p]gs    :<C-u>CocCommand fzf-preview.GitStatus<CR>
nnoremap <silent> [fzf-p]ga    :<C-u>CocCommand fzf-preview.GitActions<CR>

nnoremap <silent> [fzf-p]b     :<C-u>CocCommand fzf-preview.Buffers<CR>
nnoremap <silent> [fzf-p]B     :<C-u>CocCommand fzf-preview.AllBuffers<CR>
nnoremap <silent> [fzf-p]o     :<C-u>CocCommand fzf-preview.FromResources buffer project_mru<CR>

nnoremap <silent> [fzf-p]<C-o> :<C-u>CocCommand fzf-preview.Jumps<CR>
nnoremap <silent> [fzf-p]g;    :<C-u>CocCommand fzf-preview.Changes<CR>

nnoremap <silent> [fzf-p]/     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'"<CR>
nnoremap <silent> [fzf-p]*     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'<C-r>=expand('<cword>')<CR>"<CR>

nnoremap <silent> [fzf-p]t     :<C-u>CocCommand fzf-preview.BufferTags<CR>
nnoremap <silent> [fzf-p]q     :<C-u>CocCommand fzf-preview.QuickFix<CR>
nnoremap <silent> [fzf-p]l     :<C-u>CocCommand fzf-preview.LocationList<CR>
nnoremap <silent> [fzf-p]h     :<C-u>CocCommand fzf-preview.CommandPalette<CR>

nnoremap <silent> [fzf-p]e     :<C-u>CocCommand fzf-preview.CocDiagnostics<CR>

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Fzf Layout
" let g:fzf_layout = { 'down': '~40%' }
let g:fzf_layout = { 'window': '12split enew' }

let $FZF_DEFAULT_COMMAND='fd --type f --hidden'

" Key thing to note here is the `cocstatus` usage, which allows us to see what's
" happening with Coc (which in turn shows us what's going on with `rust-analyzer`)
let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'component_function': {
  \   'cocstatus': 'coc#status',
  \   'filename': 'FilenameForLightline',
  \ },
  \ }

" Show full path of filename
" https://codeyarns.com/2017/10/25/how-to-show-full-file-path-in-lightline/
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


let g:rustfmt_autosave_if_config_present=1

let g:rainbow_active = 1
let g:rainbow_conf = {
\	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold', 'start=/</ end=/>/ fold'],
\}


" Rust Analyzer Keybindings

" Explain the error under the cursor
nnoremap <space>re :CocCommand rust-analyzer.explainError<cr>

" Open the Docs under the cursor in the browser
nnoremap <space>rk :CocCommand rust-analyzer.openDocs<cr>

" Turn inlay hints on and off
nnoremap <space>rh :CocCommand rust-analyzer.toggleInlayHints<cr>

" Use auocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" CoC Settings
"
" This is a pretty long section, but most of these settings/config options
" are defaults from from https://github.com/neoclide/coc.nvim

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

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Show actions available at this location
nnoremap <silent> <space>a  :CocAction<cr>

" NOTE: There's more stuff in the suggested starter file, but
" I think these settings are fine to start off with
