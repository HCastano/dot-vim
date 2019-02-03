" Referenced here: http://vimuniversity.com/samples/your-first-vimrc-should-be-nearly-empty
"
" Original Author:	     Bram Moolenaar <Bram@vim.org>
" Made more minimal by:  Ben Orenstein
" Modified by :          Hernando Castano, Ben McCormick
" Last change:	         2016 July 29
"
" To use it, copy it to
"  for Unix based systems (including OSX and Linux):  ~/.vimrc
"  for Windows :  $VIM\_vimrc
"
" If you don't understand a setting in here, just type ':h setting'.

" Configure Pathogen
execute pathogen#infect()

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" List of plugins to disable
" let g:pathogen_disabled = ['syntastic']
" let g:pathogen_blacklist = ['syntastic']

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

" Need this to get Syntastic to play nice
let shell="/bin/zsh -i"

" Recommended Syntastic defaults
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:rust_recommended_style = 0

" Fix for leading ^G characters in NERDTree
" See: https://old.reddit.com/r/vim/comments/a4yzyt/g_characters_prefixing_directory_and_file_names/
let g:NERDTreeNodeDelimiter = "\u00a0"

" Key shortcut for opening NERDTree
map <C-n> :NERDTreeToggle<CR>

" Show hidden files in NERDTree
let NERDTreeShowHidden=1

" Remove trailing whitespaces on save while keeping current cursor position
" https://stackoverflow.com/questions/356126/how-can-you-automatically-remove-trailing-whitespace-in-vim
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" Remap the GoTo command for YouCompleteMe
nnoremap ,jd :YcmCompleter GoTo<CR>
