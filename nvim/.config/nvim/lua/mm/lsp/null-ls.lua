local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local sources = {
  -- Python
  formatting.black,
  formatting.isort,
  diagnostics.flake8.with {
    condition = function(utils)
      return utils.root_has_file ".flake8"
    end,
  },
  diagnostics.pylint.with {
    condition = function(utils)
      return utils.root_has_file ".pylintrc"
    end,
  },

  -- Lua
  formatting.stylua.with {
    extra_args = { "--config-path", vim.fn.expand "$XDG_CONFIG_HOME/stylua.toml" },
  },

  -- Bash
  diagnostics.shellcheck,

  -- Javascript/TypeScript
  formatting.prettier.with {
    extra_args = {
      -- "--bracket-same-line",
      "--no-semi",
      "--single-quote",
      "--jsx-single-quote",
    },
  },
}

null_ls.setup {
  -- debug = true,
  sources = sources,
}
