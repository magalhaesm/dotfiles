local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

-----------------------------------------------------------------------------//
-- LSP Commands
-----------------------------------------------------------------------------//
local border_opts = { border = "rounded" }

cmd("LspFormat", function()
  vim.lsp.buf.formatting()
end, { nargs = 0 })

cmd("LspNextDiagnostic", function()
  vim.diagnostic.goto_prev(border_opts)
end, { nargs = 0 })

cmd("LspPrevDiagnostic", function()
  vim.diagnostic.goto_next(border_opts)
end, { nargs = 0 })

cmd("LspLineDiagnostic", function()
  vim.diagnostic.open_float(nil, border_opts)
end, { nargs = 0 })

cmd("LspImplementation", function()
  vim.lsp.buf.implementation()
end, { nargs = 0 })

cmd("LspHover", function()
  vim.lsp.buf.hover()
end, { nargs = 0 })

cmd("LspDeclaration", function()
  vim.lsp.buf.declaration()
end, { nargs = 0 })

cmd("LspDefinition", function()
  vim.lsp.buf.definition()
end, { nargs = 0 })

cmd("LspReferences", function()
  vim.lsp.buf.references()
end, { nargs = 0 })

cmd("LspSignature", function()
  vim.lsp.buf.signature_help()
end, { nargs = 0 })

cmd("LspRename", function()
  vim.lsp.buf.rename()
end, { nargs = 0 })

require "mm.lsp.lsp-installer"
require("mm.lsp.handlers").setup()
require "mm.lsp.null-ls"
