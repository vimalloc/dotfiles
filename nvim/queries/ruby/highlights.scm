; extends

; Spellcheck the description string of RSpec example/group blocks,
; e.g. it "does the thing" do ... end
(call
  method: (identifier) @_method
  arguments: (argument_list
    .
    (string
      (string_content) @spell))
  (#any-of? @_method "it" "specify" "example" "describe" "context"))
