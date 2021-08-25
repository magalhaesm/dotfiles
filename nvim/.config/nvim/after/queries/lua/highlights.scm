;;; Highlighting for lua

;;
[ "." ":" ] @operator

;;
(function
  (function_name
    (function_name_field
      object: (identifier)
      (property_identifier) @function)))
