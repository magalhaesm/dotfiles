local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup {
  debug = false,
  sources = {
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

    -- C/C++
    formatting.clang_format.with {
      filetypes = { "c", "cpp" },
    },

    -- Javascript/TypeScript
    formatting.prettier.with {
      extra_args = {
        -- "--bracket-same-line",
        "--no-semi",
        "--single-quote",
        "--jsx-single-quote",
      },
    },
  },
}
