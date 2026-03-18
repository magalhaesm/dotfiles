return {
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      indent = {
        char = '│',
      },
      scope = {
        enabled = false,
        show_start = false,
        show_end = false,
      },
    },
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- plugins = {
      --   marks = false,
      --   spelling = true,
      -- },
      icons = {
        breadcrumb = '»',
        separator = '',
        group = '+',
      },
      win = {
        width = 0.9,
        height = { min = 4, max = 25 },
        col = 0.5,
        row = -1,
        border = 'rounded',
        title = true,
        title_pos = 'center',
      },
    },
    config = function(_, opts)
      local wk = require('which-key')
      wk.setup(opts)
      local keymaps = {
        mode = { 'n', 'v' },
        { '<leader>c', group = '[C]ode' },
        { '<leader>p', group = '[P]eek' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>g', group = '[G]it' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]est' },
        { '<leader>S', group = '[S]wap' },
      }
      wk.add(keymaps, opts)
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
  {
    'mbbill/undotree',
    keys = {
      { '<leader>u', vim.cmd.UndotreeToggle, desc = '[U]ndoTree' },
    },
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
