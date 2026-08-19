; extends

; Spell check things like `it` blocks in specs. Can I can't spell to save my life
(call_expression
  function: (identifier) @_method
  arguments: (arguments
    .
    [
      (string (string_fragment) @spell)
      (template_string (string_fragment) @spell)
    ])
  (#any-of? @_method "it" "test" "describe" "context" "specify" "fit" "xit" "fdescribe" "xdescribe"))

(call_expression
  function: (member_expression
    object: (identifier) @_method)
  arguments: (arguments
    .
    [
      (string (string_fragment) @spell)
      (template_string (string_fragment) @spell)
    ])
  (#any-of? @_method "it" "test" "describe" "context" "specify"))
