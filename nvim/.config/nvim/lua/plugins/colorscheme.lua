return {
  "tanvirtin/monokai.nvim",
  opts = function()
    local palette = require("monokai").pro
    local custom_hlgroups = {
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
      ["@include"] = {
        fg = palette.pink,
      },
      ["@text.note"] = {
        fg = palette.aqua,
        style = "bold",
      },
      ["@text.warning"] = {
        fg = palette.orange,
        style = "bold",
      },
      ["@text.todo"] = {
        fg = palette.orange,
        style = "bold",
      },
      ["@text.danger"] = {
        fg = palette.pink,
        style = "bold",
      },
      ["@parameter"] = {
        fg = palette.orange,
        style = "italic",
      },
      ["@function.builtin"] = {
        fg = palette.aqua,
      },
      ["@function.call"] = {
        fg = palette.green,
        style = "italic",
      },
      ["@method.call"] = {
        fg = palette.green,
        style = "italic",
      },
      ["@constructor"] = {
        fg = palette.aqua,
      },
      ["@constant.builtin"] = {
        fg = palette.purple,
      },
      ["@constant"] = {
        fg = palette.aqua,
      },
      ["@string.escape"] = {
        fg = palette.purple,
      },
      ["@storageclass"] = {
        fg = palette.pink,
        style = "italic",
      },
      ["@preproc"] = {
        fg = palette.pink,
      },
      ["@define"] = {
        fg = palette.pink,
      },
      ["@type.qualifier"] = {
        fg = palette.pink,
      },

      -- NvimTree
      PanelHeading = {
        fg = palette.orange,
        --[[ bg = palette.base0, ]]
        style = "bold",
      },
      --[[ NvimTreeNormal = { ]]
      --[[   bg = palette.base0, ]]
      --[[ }, ]]
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
    }
    return {
      lazy = true,
      palette = palette,
      custom_hlgroups = custom_hlgroups
    }
  end,
}
