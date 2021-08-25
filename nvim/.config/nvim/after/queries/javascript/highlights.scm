; Javascript Highlights

[":" "?" "."] @operator
; (":" @operator)

"new" @bold

; Import
(named_imports (import_specifier
  name: (identifier) @variable.import))

; Export
(export_specifier
  alias: (identifier) @variable.export)

; Constant Variables
(lexical_declaration "const"
  (variable_declarator
   name: (identifier) @variable.constant))

; Constant Properties
(
  (property_identifier) @constant
  (#match? @constant "^[A-Z][A-Z_]+")
)
