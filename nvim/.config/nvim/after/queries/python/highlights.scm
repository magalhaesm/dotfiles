;;; Highlighting for Python

[":" "."] @operator

; Import
; (import_statement
;   name: [
;     (dotted_name (identifier)* @variable)
;     (aliased_import
;       name: (dotted_name (identifier)* @variable)
;       alias: (identifier) @variable)
;   ])

; Import from
; (import_from_statement
;   module_name: [
;     (dotted_name (identifier)* @variable)
;     (aliased_import
;       name: (dotted_name (identifier)* @variable)
;       alias: (identifier) @variable)
;   ])

; Herança
(class_definition
  name: (identifier)
  superclasses: (argument_list (_) @Type))

; (import_from_statement
;   module_name: (dotted_name
;     (identifier))
;   name: (dotted_name) @function)

; (import_from_statement
;   module_name: [
;     (dotted_name (identifier)* @TSVariable)
;     (aliased_import
;       name: (dotted_name (identifier)* @TSVariable)
;       alias: (identifier) @TSVariable)
;   ])
