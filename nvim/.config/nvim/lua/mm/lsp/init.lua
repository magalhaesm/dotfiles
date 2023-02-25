local status, mason = pcall(require, "mason")
if not status then
  return
end

local status2, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status2 then
  return
end

local status3, nvim_lsp = pcall(require, "lspconfig")
if not status3 then
  return
end

local status4, fidget = pcall(require, "fidget")
if not status4 then
  return
end
fidget.setup()

require "mm.lsp.null_ls"
local on_attach = require("mm.lsp.handlers").on_attach
local capabilities = require("mm.lsp.handlers").capabilities

-- LspInfo border
require("lspconfig.ui.windows").default_options.border = "rounded"

mason.setup {
  ui = {
    border = "rounded",
    height = 0.8,
  },
}
mason_lspconfig.setup {
  ensure_installed = { "clangd", "lua_ls", "bashls", "pyright", "tsserver" },
}

require("rust-tools").setup {
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
  },
}

nvim_lsp.clangd.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    cmd = {
      "clangd",
      "--background-index",
      "--suggest-missing-includes",
      "--clang-tidy",
      "--header-insertion=iwyu",
    },
  },
  filetypes = { "c", "cpp" },
}

nvim_lsp.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      workspace = { checkThirdParty = false, },
      completion = { callSnippet = "Replace" },
      telemetry = { enable = false },
      format = { enable = false },
      diagnostics = {
        globals = {
          "vim",
        },
      },
    },
  },
}

nvim_lsp.bashls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

nvim_lsp.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "off",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
}

nvim_lsp.tsserver.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
