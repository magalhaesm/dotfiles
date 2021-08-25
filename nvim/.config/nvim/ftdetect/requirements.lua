vim.cmd [[
  au BufRead,BufNewFile requirements.txt set filetype=requirements
  au BufRead,BufNewFile constraints.txt set filetype=requirements
  au BufRead,BufNewFile dev-requirements.txt set filetype=requirements
  au BufRead,BufNewFile requirements/dev.txt set filetype=requirements
  au BufRead,BufNewFile requires/tests.txt set filetype=requirements
  au BufRead,BufNewFile requirements.in set filetype=requirements
]]
