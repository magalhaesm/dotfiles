local default = {
  lsp = {
    format_on_save = false,
    document_highlight = false,
  },
}

mm["javascript"] = default
mm["javascriptreact"] = default
mm["javascript.jsx"] = default
mm["typescript"] = default
mm["typescriptreact"] = default
mm["typescript.tsx"] = default

local lsp_settings = {
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  root_dir = require("lspconfig/util").root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
  settings = { documentFormatting = false },
}

return lsp_settings
