local ok, monokai = pcall(require, "monokai")
if ok then
  local palette = monokai.classic
  monokai.setup {
    custom_hlgroups = {
      DiagnosticError = {
        palette.red,
      },
      DiagnosticSignWarn = {
        fg = palette.orange,
      },
      NormalFloat = {
        bg = palette.base2,
      },
      FloatBorder = {
        fg = palette.border,
      },

      -- Lsp
      LspReferenceText = {
        bg = palette.base4,
      },
      LspReferenceRead = {
        bg = palette.base4,
      },
      LspReferenceWrite = {
        bg = palette.base4,
      },
      LspInfoBorder = {
        fg = palette.border,
      },

      -- GitSigns
      GitSignsChange = {
        fg = palette.yellow,
        bg = palette.base2,
      },

      -- Telescope
      TelescopeNormal = {
        bg = palette.base2,
      },

      -- Treesitter
      TSNote = {
        fg = palette.aqua,
        style = "bold",
      },
      TSWarning = {
        fg = palette.orange,
        style = "bold",
      },
      TSDanger = {
        fg = palette.pink,
        style = "bold",
      },
      TSParameter = {
        fg = palette.orange,
        style = "italic",
      },
      TSVariableBuiltin = {
        fg = palette.purple,
      },

      -- NvimTree
      PanelHeading = {
        fg = palette.orange,
        bg = palette.base0,
        style = "bold",
      },
      NvimTreeNormal = {
        bg = palette.base0,
      },
      NvimTreeVertSplit = {
        fg = palette.base0,
        bg = palette.base0,
      },

      -- IndentBlankline
      IndentBlanklineContextChar = {
        fg = palette.base6,
      },

      -- Toml
      tomlTable = {
        fg = palette.green,
      },
      tomlKey = {
        fg = palette.pink,
      },

      -- Makefile
      TSSymbol = {
        fg = palette.pink,
      },
    },
  }
end
