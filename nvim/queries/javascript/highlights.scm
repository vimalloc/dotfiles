; extends

; Spellcheck the description string of test-framework blocks, e.g.
; it('does the thing', () => {}) / describe.only(`...`, fn)
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
