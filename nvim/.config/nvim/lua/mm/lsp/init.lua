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

require "mm.lsp.null_ls"
local custom_on_attach = require "mm.lsp.config".on_attach
local capabilities = require "mm.lsp.config".capabilities

mason.setup()
mason_lspconfig.setup {
  ensure_installed = { "clangd", "sumneko_lua", "bashls" },
}

nvim_lsp.clangd.setup {
  on_attach = custom_on_attach,
  capabilities = capabilities,
  settings = {
    cmd = {
      "clangd",
      "--background-index",
      "--suggest-missing-includes",
      "--clang-tidy",
      --[[ "--header-insertion=iwyu", ]]
    },
  },
  filetypes = { "c", "cpp" },
}

nvim_lsp.sumneko_lua.setup {
  on_attach = custom_on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = {
          "vim",
        },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.stdpath "config" .. "/lua"] = true,
        },
      },
    },
  },
}

nvim_lsp.jdtls.setup {
  on_attach = custom_on_attach,
  capabilities = capabilities,
}

nvim_lsp.bashls.setup {
  on_attach = custom_on_attach,
  capabilities = capabilities,
}

nvim_lsp.pyright.setup {
  on_attach = custom_on_attach,
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
