return {
  -- Todo Comments
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      gui_style = {
        fg = 'BOLD',
        bg = 'NONE',
      },
      highlight = {
        before = '',
        keyword = 'fg',
        after = '',
      },
      signs = false,
    },
    event = { 'BufReadPost', 'BufNewFile' },
    keys = {
      { '<leader>tq', '<cmd>TodoQuickFix<CR>', desc = '[T]odo [Q]uickFix' },
      -- { '<leader>tt', '<cmd>TodoTelescope<CR>' },
    },
  },
}
