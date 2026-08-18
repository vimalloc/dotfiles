" Spellcheck it/describe/context/test descriptions in spec files
" (the actual scoping to just those description strings happens in
" queries/javascript/highlights.scm via the @spell capture)
if expand('%') =~# '\.\(spec\|test\)\.[jt]sx\?$'
  setlocal spell
endif
