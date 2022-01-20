local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

local lsp = vim.lsp

local border_opts = { header = "", border = "rounded", focusable = false }

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
-- LSP Commands {{{
-----------------------------------------------------------------------------//

cmd("LspFormat", function()
  vim.lsp.buf.formatting()
end)

cmd("LspNextDiagnostic", function()
  vim.diagnostic.goto_prev(border_opts)
end)

cmd("LspPrevDiagnostic", function()
  vim.diagnostic.goto_next(border_opts)
end)

cmd("LspLineDiagnostic", function()
  vim.diagnostic.open_float(nil, border_opts)
end)

cmd("LspImplementation", function()
  vim.lsp.buf.implementation()
end)

cmd("LspHover", function()
  vim.lsp.buf.hover()
end)

cmd("LspDeclaration", function()
  vim.lsp.buf.declaration()
end)

cmd("LspDefinition", function()
  vim.lsp.buf.definition()
end)

cmd("LspReferences", function()
  vim.lsp.buf.references()
end)

cmd("LspSignature", function()
  vim.lsp.buf.signature_help()
end)

cmd("LspRename", function()
  vim.lsp.buf.rename()
end)
-- }}}

-----------------------------------------------------------------------------
-- LSP Config
-----------------------------------------------------------------------------

--[=[
local function lsp_autocmd(client)
  if client.resolved_capabilities.document_highlight then
    vim.cmd [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]
  end

  if client.resolved_capabilities.code_lens then
    vim.cmd [[
      augroup lsp_code_lens
        autocmd! <buffer>
        autocmd BufEnter,CursorHold,InsertLeave lua vim.lsp.buf.clear_references()
      augroup END
    ]]
  end
end
--]=]

local function lsp_keymaps(_, bufnr)
  local buf = { buffer = bufnr }

  nnoremap("K", "<cmd>LspHover<CR>", buf)
  nnoremap("gi", "<cmd>LspImplementation<CR>", "LSP: go to implementation", buf)
  nnoremap("gD", "<cmd>LspDeclaration<CR>", "LSP: go to declaration", buf)
  nnoremap("gd", "<cmd>LspDefinition<CR>", "LSP: go to definition", buf)
  nnoremap("gr", "<cmd>Telescope lsp_references<CR>", "LSP: references", buf)
  nnoremap("gl", "<cmd>LspLineDiagnostic<CR>", "LSP: line diagnostic", buf)

  nnoremap("[d", "<cmd>LspPrevDiagnostic<CR>", "LSP: prev diagnostic", buf)
  nnoremap("]d", "<cmd>LspNextDiagnostic<CR>", "LSP: next diagnostic", buf)

  inoremap("<C-x><C-x>", "<cmd>LspSignature<CR>")

  map.nname("<leader>l", "LSP")
  nnoremap("<leader>lR", "<cmd>LspRestart<CR>", "Restart", buf)
  nnoremap("<leader>lf", "<cmd>LspFormat<CR>", "Format", buf)
  nnoremap("<leader>lr", "<cmd>LspRename<CR>", "Rename", buf)

  nnoremap("<leader>la", "<cmd>Telescope lsp_code_actions<CR>", "Code Action", buf)
  nnoremap("<leader>ld", "<cmd>Telescope diagnostics bufnr=0<CR>", "Document Diagnostics", buf)
  nnoremap("<leader>ll", "<cmd>lua vim.lsp.codelens.run()<CR>", "CodeLens Action", buf)
  nnoremap("<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", "Quickfix", buf)

  map.nname("<leader>li", "Info")
  nnoremap("<leader>lia", "<cmd>LspInfo<CR>", "Attached", buf)
  nnoremap("<leader>lii", "<cmd>LspInstallInfo<CR>", "Installed", buf)

  nnoremap("<leader>ls", "<cmd>Telescope lsp_document_symbols<CR>", "Document Symbols", buf)
  nnoremap("<leader>lw", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", "Workspace Symbols", buf)
end

local custom_on_attach = function(client, bufnr)
  -- lsp_autocmd(client)
  lsp_keymaps(client, bufnr)
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
