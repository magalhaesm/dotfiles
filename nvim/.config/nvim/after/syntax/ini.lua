local current_syntax = vim.b.current_syntax

if current_syntax == 'ini' then
  return
end

vim.cmd [[
  syn case match

  syn region iniComment start="[ \t]*#" end="$"
  syn match iniCommandOption "\v^\[?--?[a-zA-Z\-]*\]?"
  syn match iniVersionSpecifiers "\v(\=\=\=?|\<\=?|\>\=?|\~\=|\!\=)"
  syn match iniProperty "\v^([a-zA-Z0-9][a-zA-Z0-9\-_\.]*[a-zA-Z0-9])"
  syn match iniSection "\v\[\S+\]"
  syn match iniVersionControls "\v(git\+?|hg\+|svn\+|bzr\+).*://.\S+"
  syn match iniURLs "\v(\@\s)?(https?|ftp|gopher)://?[^\s/$.?#].\S*"
  syn match iniEnvironmentMarkers "\v;\s[^#]+"

  hi link iniComment Comment
  hi link iniCommandOption Special
  hi link iniVersionSpecifiers Boolean
  hi link iniProperty Statement
  hi link iniSection Identifier
  hi link iniVersionControls Underlined
  hi link iniURLs Underlined
  hi link iniEnvironmentMarkers Macro
]]

vim.b.current_syntax = 'ini'
