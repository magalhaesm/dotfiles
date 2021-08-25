local null_ls = require "null-ls"
local b = null_ls.builtins

local sources = {
  -- All
  b.code_actions.gitsigns,

  -- Python
  b.formatting.black,
  b.formatting.isort,
  b.diagnostics.flake8,

  -- Lua
  b.formatting.stylua,
  b.diagnostics.luacheck.with {
    condition = function(utils)
      return utils.root_has_file ".luacheckrc"
    end,
  },

  -- Bash
  b.diagnostics.shellcheck,

  -- Javascript/TypeScript
}

-- PERF: adicionar lint_on_save
local M = {}
M.setup = function()
  null_ls.config {
    -- debug = true,
    sources = sources,
  }
  require("lspconfig")["null-ls"].setup {}
end

return M
