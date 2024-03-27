return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000, -- Make sure to load this before all the other start plugins.

    init = function()
      -- Load the colorscheme here.
      vim.cmd.colorscheme 'catppuccin'
    end,

    config = function()
      require('catppuccin').setup {
        flavour = 'mocha', -- latte, frappe, macchiato, mocha
        background = {
          -- :h background
          light = 'latte',
          dark = 'mocha',
        },
        transparent_background = false,
        show_end_of_buffer = false, -- show the '~' characters after the end of buffers
        term_colors = true,
        dim_inactive = {
          enabled = false,
          shade = 'dark',
          percentage = 0.15,
        },
        no_italic = false, -- Force no italic
        no_bold = false, -- Force no bold
        -- no_underline = true, -- Force no underline
        styles = {
          comments = { 'italic' },
          conditionals = { 'italic' },
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
      }
    end,
  },
}
