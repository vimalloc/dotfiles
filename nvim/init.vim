" Unmap help key
map <F1> <Esc>
imap <F1> <Esc>

" Spacing
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Indenting
set smartindent
set autoindent

" Searching
set showmatch
set ignorecase
set smartcase
set hlsearch
set incsearch

" Vim command tab completion
set wildmode=longest,list

" Middle-click paste
set mouse=v

" Line numbers
set number
set cc=85

" Special keymaps for copying to system keyboard
noremap <C-y> "*y
noremap <C-p> "*p

" Syntax / compatibality stuff
set nocompatible
filetype on
filetype plugin on
filetype plugin indent on
syntax on

" highlight current cursorline
set cursorline

" Speed up scrolling in Vim
set ttyfast

" Highlight trailing whitespace extra
highlight ExtraWhitespace ctermbg=green guibg=green
au ColorScheme * highlight ExtraWhitespace guibg=green
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/

" Backup, swap, etc
set backup
set writebackup
set swapfile
set undofile
set backupdir=~/.cache/vim
set directory=~/.cache/vim/
set undodir=~/.cache/vim/undodir

" Leader <space>
let mapleader=" "

" Faster previous / next / delete buffers
nnoremap <leader>bp <cmd>bp<cr>
nnoremap <leader>bn <cmd>bn<cr>
nnoremap <leader>bd <cmd>bd<cr>

" sql_formatter
nnoremap <leader>ss :%!sql-formatter --config '{ "keywordCase": "upper" }' --language postgresql %<CR>

" Faster no highlight search
nnoremap <leader>no <cmd>nohls<cr>

" Spellcheck (now only applies to comments in code!)
set spell

" Fix the mistype that I keep hitting when trying to fix a misspelled word
nnoremap z- z=

" Misc keybindings to remember
" ctrl-i        -> Go to previous jump
" ctrl-o        -> Go to next jump
" z=            –> Bring up the suggested replacements
" zg            –> Good word: Add the word under the cursor to the dictionary
" zw            –> Woops! Undo and remove the word from the dictionary

" Load all our plugins
lua require('plugins')

" Color (must be after plugins)
colorscheme catppuccin-frappe
