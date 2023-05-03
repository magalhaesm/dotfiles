return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        background = {
          -- :h background
          light = "latte",
          dark = "mocha",
        },
        transparent_background = false,
        show_end_of_buffer = false, -- show the '~' characters after the end of buffers
        term_colors = true,
        dim_inactive = {
          enabled = false,
          shade = "dark",
          percentage = 0.15,
        },
        no_italic = false, -- Force no italic
        no_bold = false,   -- Force no bold
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
        },
        color_overrides = {},
        custom_highlights = {},
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          telescope = true,
          notify = false,
          mini = false,
          lsp_trouble = false,
          -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },
      })
    end
  },
  {
    "tanvirtin/monokai.nvim",
    enabled = false,
    config = function()
      local palette = require("monokai").pro
      local custom_hlgroups = {
        DiagnosticError            = {
          palette.red,
        },
        DiagnosticSignWarn         = {
          fg = palette.orange,
        },
        NormalFloat                = {
          bg = palette.base2,
        },
        FloatBorder                = {
          fg = palette.border,
        },
        -- Lsp
        LspReferenceText           = {
          bg = palette.base4,
        },
        LspReferenceRead           = {
          bg = palette.base4,
        },
        LspReferenceWrite          = {
          bg = palette.base4,
        },
        LspInfoBorder              = {
          fg = palette.border,
        },
        -- GitSigns
        GitSignsChange             = {
          fg = palette.yellow,
          bg = palette.base2,
        },
        -- Telescope
        TelescopeNormal            = {
          bg = palette.base2,
        },
        -- Treesitter
        ["@include"]               = {
          fg = palette.pink,
        },
        ["@text.note"]             = {
          fg = palette.aqua,
          style = "bold",
        },
        ["@text.warning"]          = {
          fg = palette.orange,
          style = "bold",
        },
        ["@text.todo"]             = {
          fg = palette.orange,
          style = "bold",
        },
        ["@text.danger"]           = {
          fg = palette.pink,
          style = "bold",
        },
        ["@parameter"]             = {
          fg = palette.orange,
          style = "italic",
        },
        ["@function.builtin"]      = {
          fg = palette.aqua,
        },
        ["@function.call"]         = {
          fg = palette.green,
          style = "italic",
        },
        ["@method.call"]           = {
          fg = palette.green,
          style = "italic",
        },
        ["@constructor"]           = {
          fg = palette.aqua,
        },
        ["@constant.builtin"]      = {
          fg = palette.purple,
        },
        ["@constant"]              = {
          fg = palette.aqua,
        },
        ["@string.escape"]         = {
          fg = palette.purple,
        },
        ["@storageclass"]          = {
          fg = palette.pink,
          style = "italic",
        },
        ["@preproc"]               = {
          fg = palette.pink,
        },
        ["@define"]                = {
          fg = palette.pink,
        },
        ["@type.qualifier"]        = {
          fg = palette.pink,
        },
        -- NvimTree
        PanelHeading               = {
          fg = palette.orange,
          style = "bold",
        },
        NvimTreeVertSplit          = {
          fg = palette.base0,
          bg = palette.base0,
        },
        -- IndentBlankline
        IndentBlanklineContextChar = {
          fg = palette.base6,
        },
        -- Toml
        tomlTable                  = {
          fg = palette.green,
        },
        tomlKey                    = {
          fg = palette.pink,
        },
        -- Makefile
        TSSymbol                   = {
          fg = palette.pink,
        },
        -- Markdown
        markdownCode               = {
          fg = palette.aqua,
        },
        Constant                   = {
          fg = palette.purple,
        },
        Macro                      = {
          fg = palette.aqua,
        },
      }
      require("monokai").setup({
        palette = palette,
        custom_hlgroups = custom_hlgroups,
      })
      vim.cmd("hi link @lsp.type.parameter @parameter")
      -- vim.cmd("hi link @lsp.type.parameter Parameter")
      -- vim.cmd("hi link @lsp.type.macro.c @constant.builtin")
    end,
  },
}
