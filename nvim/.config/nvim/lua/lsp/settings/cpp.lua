local lsp_settings = {
  settings = {
    cmd = {
      mm.DATA_PATH .. "/lspinstall/cpp/clangd/bin/clangd",
      "--background-index",
      "--suggest-missing-includes",
      "--clang-tidy",
      "--header-insertion=iwyu",
    },
  },
  filetypes = { "c", "cpp" },
}

local default = {
  lsp = {
    format_on_save = false,
    document_highlight = false,
  },
}

mm["c"] = default
mm["cpp"] = default

return lsp_settings
