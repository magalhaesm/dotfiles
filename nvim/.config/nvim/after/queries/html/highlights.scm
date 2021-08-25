;;; Highlighting for HTML

; (":" @Operator)

"</" @tag.delimiter

; [":" ";"] @operator

; ((end_tag) @operator
;    (#match? @operator "^[A-Z][A-Z_]+")
; )
; (
;   (property_identifier) @constant
;   (#match? @constant "^[A-Z][A-Z_]+")
; )
