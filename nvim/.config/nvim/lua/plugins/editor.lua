return {
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      plugins = { spelling = true },
      icons = {
        breadcrumb = '»',
        separator = '',
        group = '+',
      },
      window = {
        border = 'none',
        position = 'bottom',
        margin = { 1, 0, 1, 0 },
        padding = { 2, 2, 2, 2 },
        winblend = 0,
      },
      layout = {
        height = { min = 4, max = 15 },
        width = { min = 20, max = 50 },
        spacing = 3,
        align = 'center',
      },
      key_labels = {
        ['<space>'] = 'SPC',
        ['<cr>'] = 'RET',
        ['<tab>'] = 'TAB',
      },
      triggers_blacklist = {
        i = { 'j', 'k' },
        v = { 'j', 'k' },
      },
    },
    config = function(_, opts)
      local wk = require('which-key')
      wk.setup(opts)
      local keymaps = {
        mode = { 'n', 'v' },
        ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
        ['<leader>p'] = { name = '[P]eek', _ = 'which_key_ignore' },
        ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
        ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
        ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
        ['<leader>t'] = { name = '[T]est', _ = 'which_key_ignore' },
        ['<leader>S'] = { name = '[S]wap', _ = 'which_key_ignore' },
      }
      wk.register(keymaps)
    end,
  },
  -- Buffer Remove
  {
    'echasnovski/mini.bufremove',
    keys = {
      {
        '<leader>x',
        function()
          require('mini.bufremove').delete(0, false)
        end,
        desc = 'Delete Buffer',
      },
      {
        '<leader>X',
        function()
          require('mini.bufremove').delete(0, true)
        end,
        desc = 'Delete Buffer (Force)',
      },
    },
  },
  {
    'stevearc/dressing.nvim',
    opts = {},
  },
  -- color highlighter
  {
    'NvChad/nvim-colorizer.lua',
    event = 'BufReadPre',
    enabled = false,
    config = function()
      require('colorizer').setup({
        filetypes = { '*' },
        user_default_options = {
          names = false,
          tailwind = 'both',
          mode = 'background',
        },
      })
    end,
  },
  -- École 42
  {
    dir = '~/Projetos/42header',
    ft = { 'c', 'cpp' },
    enabled = false,
  },
  {
    'andweeb/presence.nvim',
    opts = {},
    event = 'VeryLazy',
    enabled = false,
  },
}
