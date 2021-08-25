; Highlighting for Typescript

[":" "?" "."] @operator

"new" @bold

; Import
(named_imports (import_specifier
  name: (identifier) @Identifier))

; Export
; (export_specifier
;   alias: (identifier) @TSVariable)

; Constant Variables
; (lexical_declaration "const"
;   (variable_declarator
;     name: (identifier) @variable.constant))

; Constant Properties
; (
;   (property_identifier) @constant
;   (#match? @constant "^[A-Z][A-Z_]+")
; )

; Interfaces
; (implements_clause
; (type_identifier) @TSAnnotation)

; Type annotations
; (type_annotation (_) @TSAnnotation)

(object_pattern* (shorthand_property_identifier_pattern) @Identifier)
