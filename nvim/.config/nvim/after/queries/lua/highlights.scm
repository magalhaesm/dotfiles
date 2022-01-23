;;; Highlighting for lua

;;
[ "." ":" ] @operator

(function_call
  arguments: (arguments
    (identifier) @TSArgument))
