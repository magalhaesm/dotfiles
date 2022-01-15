local M = {}

local lsp = vim.lsp

local border_opts = { header = "", border = "rounded", focusable = false }

vim.diagnostic.config { virtual_text = false, float = border_opts }

M.setup = function()
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
end

local function lsp_highlight_document(client)
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

---@see: https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts
local function disable_formatting(client)
  client.resolved_capabilities.document_formatting = false
  client.resolved_capabilities.document_range_formatting = false
end

-- TODO: definir autocommands a depender das capacidades do servidor
local function lsp_keymaps(client, bufnr)
  local buf = { buffer = bufnr }
  local opts = { silent = true }

  local set = require("mm.utils").Set
  local langs = set { "c", "cpp", "vim", "sh" }
  if not langs[vim.bo.filetype] then
    nnoremap("K", "<cmd>LspHover<CR>", opts, buf)
  end

  if client.resolved_capabilities.implementation then
    nnoremap("gi", "<cmd>LspImplementation<CR>", "LSP: go to implementation", opts, buf)
  end

  if client.resolved_capabilities.declaration then
    nnoremap("gD", "<cmd>LspDeclaration<CR>", "LSP: go to declaration", opts, buf)
  end
  nnoremap("gd", "<cmd>LspDefinition<CR>", "LSP: go to definition", opts, buf)
  nnoremap("gr", "<cmd>LspReferences<CR>", "LSP: references", opts, buf)
  nnoremap("gl", "<cmd>LspLineDiagnostic<CR>", "LSP: line diagnostic", opts, buf)

  nnoremap("[d", "<cmd>LspPrevDiagnostic<CR>", "LSP: prev diagnostic", opts, buf)
  nnoremap("]d", "<cmd>LspNextDiagnostic<CR>", "LSP: next diagnostic", opts, buf)

  inoremap("<C-x><C-x>", "<cmd>LspSignature<CR>", opts)

  map.nname("<leader>l", "LSP")
  nnoremap("<leader>lR", "<cmd>LspRestart<CR>", "Restart", opts, buf)
  nnoremap("<leader>lr", "<cmd>LspRename<CR>", "Rename", opts, buf)
  nnoremap("<leader>lf", "<cmd>LspFormat<CR>", "Format", opts, buf)

  map.nname("<leader>li", "Info")
  nnoremap("<leader>lia", "<cmd>LspInfo<CR>", "Attached", opts, buf)
  nnoremap("<leader>lii", "<cmd>LspInstallInfo<CR>", "Installed", opts, buf)

  nnoremap("<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action", opts, buf)
  nnoremap("<leader>ld", "<cmd>Telescope diagnostics bufnr=0<CR>", "Document Diagnostics", opts, buf)
  nnoremap("<leader>ll", "<cmd>lua vim.lsp.codelens.run()<CR>", "CodeLens Action", opts, buf)
  nnoremap("<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", "Quickfix", opts, buf)

  map.nname("<leader>ls", "Symbols")
  nnoremap("<leader>lsd", "<cmd>Telescope lsp_document_symbols<CR>", "Document Symbols", opts, buf)
  nnoremap("<leader>lsw", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", "Workspace Symbols", opts, buf)
end

M.on_attach = function(client, bufnr)
  disable_formatting(client)
  lsp_highlight_document(client)
  lsp_keymaps(client, bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  return
end

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M
