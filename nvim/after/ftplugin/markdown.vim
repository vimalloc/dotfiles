" Enable spellcheck
setlocal spell

" 2 space tabs
setlocal tabstop=2
setlocal shiftwidth=2
setlocal expandtab

" Disable line numbers. Funky to use them when using wrapped lines instead of
" physical newlines
setlocal nonumber

" Wrap lines on word boundaries
set linebreak

" Indent wrapped lines to the same level as the line they are wrapped from
setlocal breakindent
setlocal breakindentopt=list:-1

" Treat wrapped lines as physical newlines when navigating
noremap <silent> k gk
noremap <silent> j gj
noremap <silent> 0 g0
noremap <silent> $ g$

" TODO: can I set this to 2 only for when obsidian is loaded?
" needed for obsidian stuff
setlocal conceallevel=2
