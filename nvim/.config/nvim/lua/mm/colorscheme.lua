local ok, monokai = pcall(require, "monokai")
if ok then
  local colors = monokai.classic
  monokai.setup {
    custom_hlgroups = {
      DiagnosticError = {
        colors.red,
      },
      DiagnosticSignWarn = {
        fg = colors.orange,
      },

      -- Lsp
      LspReferenceText = {
        bg = colors.base4,
      },
      LspReferenceRead = {
        bg = colors.base4,
      },
      LspReferenceWrite = {
        bg = colors.base4,
      },

      -- GitSigns
      GitSignsChange = {
        fg = colors.yellow,
        bg = colors.base2,
      },
      TelescopeNormal = {
        bg = colors.base2,
      },

      -- Treesitter
      TSNote = {
        fg = colors.aqua,
        style = "bold",
      },
      TSWarning = {
        fg = colors.orange,
        style = "bold",
      },
      TSDanger = {
        fg = colors.pink,
        style = "bold",
      },
      TSParameter = {
        fg = colors.orange,
        style = "italic",
      },
      TSVariableBuiltin = {
        fg = colors.purple,
      },

      -- NvimTree
      PanelHeading = {
        fg = colors.orange,
        style = "bold",
      },

      -- IndentBlankline
      IndentBlanklineContextChar = {
        fg = colors.base6,
      },

      -- Toml
      tomlTable = {
        fg = colors.green,
      },
      tomlKey = {
        fg = colors.pink,
      },

      -- Makefile
      TSSymbol = {
        fg = colors.pink,
      }
    },
  }
end
