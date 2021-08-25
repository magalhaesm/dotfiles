-------------------------------------------------------------------------------
--  Lua:
-------------------------------------------------------------------------------

mm["lua"] = {
  lsp = {
    format_on_save = true,
    document_highlight = false,
  },
}

-- Configure lua language server for neovim development
local lsp_settings = {
  settings = {
    Lua = {
      runtime = {
        -- LuaJIT in the case of Neovim
        version = "LuaJIT",
        path = vim.split(package.path, ";"),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim", "mm" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
        },
      },
    },
  },
  filetypes = { "lua" },
}

return lsp_settings
