mm["python"] = {
	lsp = {
		format_on_save = false,
	},
}

local lsp_settings = {
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "off",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
  filetypes = { "python" },
}

return lsp_settings
