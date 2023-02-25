local M = {}

M.setup = function()
  local lsp = vim.lsp

  local max_width = math.floor(vim.o.columns * 0.7)
  local max_height = math.floor(vim.o.lines * 0.3)
  local border_opts = {
    header = "",
    border = "rounded",
    focusable = false,
    max_width = max_width,
    max_height = max_height,
  }

  vim.diagnostic.config({ virtual_text = false, float = border_opts })
  for name, icon in pairs(require("config").icons.diagnostics) do
    name = "DiagnosticSign" .. name
    vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
  end

  lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, border_opts)
  lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, border_opts)
end

return M
