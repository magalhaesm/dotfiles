local null_ls = require "null-ls"
local b = null_ls.builtins

local sources = {
  -- All
  b.code_actions.gitsigns,

  -- Python
  b.formatting.black,
  b.formatting.isort,
  b.diagnostics.flake8.with {
    condition = function(utils)
      return utils.root_has_file ".flake8"
    end,
  },
  b.diagnostics.pylint.with {
    condition = function(utils)
      return utils.root_has_file ".pylintrc"
    end,
  },

  -- Lua
  b.formatting.stylua.with {
    extra_args = { "--config-path", vim.fn.expand "$XDG_CONFIG_HOME/stylua.toml" },
  },

  -- Bash
  b.diagnostics.shellcheck,

  -- C/C++
  b.formatting.clang_format.with {
    filetypes = { "c", "cpp" },
  },

  -- Javascript/TypeScript
}

local M = {}
M.setup = function()
  null_ls.config {
    -- debug = true,
    sources = sources,
  }
  require("lspconfig")["null-ls"].setup {}
end

return M
