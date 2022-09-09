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

local lsp = vim.lsp

-----------------------------------------------------------------------------
-- Handlers
-----------------------------------------------------------------------------
local max_width = math.floor(vim.o.columns * 0.7)
local max_height = math.floor(vim.o.lines * 0.3)
local border_opts = {
  header = "",
  border = "rounded",
  focusable = false,
  max_width = max_width,
  max_height = max_height,
}

vim.diagnostic.config { virtual_text = false, float = border_opts }

local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, border_opts)
lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, border_opts)

-----------------------------------------------------------------------------//
-- LSP Commands
-----------------------------------------------------------------------------//

cmd("LspNextDiagnostic", function()
  vim.diagnostic.goto_next(border_opts)
end)

cmd("LspPrevDiagnostic", function()
  vim.diagnostic.goto_prev(border_opts)
end)

cmd("LspLineDiagnostic", function()
  vim.diagnostic.open_float(nil, border_opts)
end)

-----------------------------------------------------------------------------
-- LSP Config
-----------------------------------------------------------------------------

local function document_formatting(client)
  client.resolved_capabilities.document_formatting = false
end

local function document_highlight(client)
  if client.resolved_capabilities.document_highlight then
    vim.cmd [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]
  end
end

local function lsp_keymaps()
  nnoremap("K", "<cmd>lua vim.lsp.buf.hover()<CR>")
  nnoremap("gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", "LSP: go to implementation")
  nnoremap("gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", "LSP: go to declaration")
  nnoremap("gd", "<cmd>lua vim.lsp.buf.definition()<CR>", "LSP: go to definition")
  nnoremap("gr", "<cmd>Telescope lsp_references<CR>", "LSP: references")
  nnoremap("gT", "<cmd>lua vim.lsp.buf.type_definition()<CR>", "LSP: go to type definition")

  nnoremap("gl", "<cmd>LspLineDiagnostic<CR>", "LSP: line diagnostic")
  nnoremap("[d", "<cmd>LspPrevDiagnostic<CR>", "LSP: prev diagnostic")
  nnoremap("]d", "<cmd>LspNextDiagnostic<CR>", "LSP: next diagnostic")

  map.nname("<leader>l", "LSP")
  nnoremap("<leader>lR", "<cmd>LspRestart<CR>", "Restart")
  nnoremap("<leader>lf", "<cmd>vim.lsp.buf.formatting()<CR>", "Format")
  nnoremap("<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename")

  nnoremap("<leader>ld", "<cmd>Telescope diagnostics bufnr=0<CR>", "Document Diagnostics")
  nnoremap("<leader>ll", "<cmd>lua vim.lsp.codelens.run()<CR>", "CodeLens Action")
  nnoremap("<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", "Quickfix")

  nnoremap("<leader>li", "<cmd>LspInfo<CR>", "Info")

  nnoremap("<leader>ls", "<cmd>Telescope lsp_document_symbols<CR>", "Document Symbols")
  nnoremap("<leader>lw", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", "Workspace Symbols")
end

local custom_on_attach = function(client)
  document_formatting(client)
  document_highlight(client)
  lsp_keymaps()
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

require "mm.lsp.null-ls"

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
