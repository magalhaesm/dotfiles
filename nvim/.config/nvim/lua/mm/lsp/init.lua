local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
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

cmd("LspFormat", function()
  vim.lsp.buf.formatting()
end)

cmd("LspNextDiagnostic", function()
  vim.diagnostic.goto_next(border_opts)
end)

cmd("LspPrevDiagnostic", function()
  vim.diagnostic.goto_prev(border_opts)
end)

cmd("LspLineDiagnostic", function()
  vim.diagnostic.open_float(nil, border_opts)
end)

cmd("LspReferences", function()
  vim.lsp.buf.references()
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
  nnoremap("gl", "<cmd>LspLineDiagnostic<CR>", "LSP: line diagnostic")
  nnoremap("gT", "<cmd>lua vim.lsp.buf.type_definition()<CR>", "LSP: go to type definition")

  nnoremap("[d", "<cmd>LspPrevDiagnostic<CR>", "LSP: prev diagnostic")
  nnoremap("]d", "<cmd>LspNextDiagnostic<CR>", "LSP: next diagnostic")

  -- inoremap("<C-x><C-x>", "<cmd>vim.lsp.buf.signature_help()<CR>")

  map.nname("<leader>l", "LSP")
  nnoremap("<leader>lR", "<cmd>LspRestart<CR>", "Restart")
  nnoremap("<leader>lf", "<cmd>LspFormat<CR>", "Format")
  nnoremap("<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename")

  -- nnoremap("<leader>la", "<cmd>Telescope lsp_code_actions<CR>", "Code Action")
  nnoremap("<leader>ld", "<cmd>Telescope diagnostics bufnr=0<CR>", "Document Diagnostics")
  nnoremap("<leader>ll", "<cmd>lua vim.lsp.codelens.run()<CR>", "CodeLens Action")
  nnoremap("<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", "Quickfix")

  map.nname("<leader>li", "Info")
  nnoremap("<leader>lia", "<cmd>LspInfo<CR>", "Attached")
  nnoremap("<leader>lii", "<cmd>LspInstallInfo<CR>", "Installed")

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

local function get_lsp_settings(server, opts)
  local lsp_settings = "mm.lsp.settings." .. server.name
  local ok, server_opts = pcall(require, lsp_settings)
  if ok then
    opts = vim.tbl_deep_extend("force", server_opts, opts)
  end
  return opts
end

-- Not handled by nvim-lsp-installer
require "mm.lsp.null-ls"

-- Register a handler that will be called for all installed servers.
require("nvim-lsp-installer").on_server_ready(function(server)
  local opts = {
    on_attach = custom_on_attach,
    capabilities = capabilities,
  }
  server:setup(get_lsp_settings(server, opts))
end)

-- vim:foldmethod=marker
