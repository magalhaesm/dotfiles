return {
  -- Todo Comments
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    lazy = true,
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
    },
  },
}
