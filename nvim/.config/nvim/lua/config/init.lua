local M = {}

M.icons = {
  diagnostics = {
    Error = ' ',
    Warn = ' ',
    Hint = ' ',
    Info = ' ',
  },
  git = {
    added = ' ',
    modified = ' ',
    removed = ' ',
  },
}

function M.setup()
  require 'config.options'
  require 'config.autocmds'
  require 'config.keymaps'
end

return M
