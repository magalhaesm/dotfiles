local current_syntax = vim.b.current_syntax

if current_syntax == 'requirements' then
  return
end

vim.cmd [[
  syn case match

  syn region requirementsComment start="[ \t]*#" end="$"
  syn match requirementsCommandOption "\v^\[?--?[a-zA-Z\-]*\]?"
  syn match requirementsVersionSpecifiers "\v(\=\=\=?|\<\=?|\>\=?|\~\=|\!\=)"
  syn match requirementsPackageName "\v^([a-zA-Z0-9][a-zA-Z0-9\-_\.]*[a-zA-Z0-9])"
  syn match requirementsExtras "\v\[\S+\]"
  syn match requirementsVersionControls "\v(git\+?|hg\+|svn\+|bzr\+).*://.\S+"
  syn match requirementsURLs "\v(\@\s)?(https?|ftp|gopher)://?[^\s/$.?#].\S*"
  syn match requirementsEnvironmentMarkers "\v;\s[^#]+"

  hi link requirementsComment Comment
  hi link requirementsCommandOption Special
  hi link requirementsVersionSpecifiers Boolean
  hi link requirementsPackageName Identifier
  hi link requirementsExtras Type
  hi link requirementsVersionControls Underlined
  hi link requirementsURLs Underlined
  hi link requirementsEnvironmentMarkers Macro
]]

vim.b.current_syntax = 'requirements'
