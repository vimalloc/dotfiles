" Spellcheck it/describe/context descriptions in spec files
" (the actual scoping to just those description strings happens in
" queries/ruby/highlights.scm via the @spell capture)
if expand('%:p') =~# '/spec/'
  setlocal spell
endif
