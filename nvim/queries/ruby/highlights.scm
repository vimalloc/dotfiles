; extends

; Spell check things like `it` blocks in specs. Can I can't spell to save my life
(call
  method: (identifier) @_method
  arguments: (argument_list
    .
    (string
      (string_content) @spell))
  (#any-of? @_method "it" "specify" "example" "describe" "context"))
