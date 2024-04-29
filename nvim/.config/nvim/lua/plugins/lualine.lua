return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'meuter/lualine-so-fancy.nvim',
  },
  enabled = true,
  lazy = false,
  event = { 'BufReadPost', 'BufNewFile', 'VeryLazy' },
  config = function()
    local icons = require('config').icons

    require('lualine').setup({
      options = {
        theme = 'auto',
        -- theme = "catppuccin",
        globalstatus = true,
        icons_enabled = true,
        component_separators = { left = '|', right = '|' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = {
            'alfa-nvim',
            'help',
            'neo-tree',
            'Trouble',
            'toggleterm',
          },
          winbar = {},
        },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = {
          'fancy_branch',
        },
        lualine_c = {
          -- 'fancy_diff',
          {
            'filename',
            path = 1, -- 2 for full path
          },
          {
            'fancy_diagnostics',
            sources = { 'nvim_lsp' },
            symbols = {
              hint = icons.diagnostics.Hint,
              info = icons.diagnostics.Info,
              warn = icons.diagnostics.Warn,
              error = icons.diagnostics.Error,
            },
          },
        },
        lualine_x = {
          'fancy_location',
          'progress',
          'fancy_lsp_servers',
        },
        lualine_y = {},
        lualine_z = {},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = { 'neo-tree', 'lazy' },
    })
  end,
}
