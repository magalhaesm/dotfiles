return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000, -- Make sure to load this before all the other start plugins.

    init = function()
      -- Load the colorscheme.
      vim.cmd.colorscheme('catppuccin')
    end,

    config = function()
      require('catppuccin').setup({
        flavour = 'mocha', -- latte, frappe, macchiato, mocha
      })
    end,
  },
}
