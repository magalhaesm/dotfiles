return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    keys = {
      { '<leader>e', '<cmd>Neotree toggle<CR>', desc = '[E]xplorer' },
    },
    config = function()
      require('neo-tree').setup {
        window = {
          width = 35,
        },
        filesystem = {
          follow_current_file = { enabled = true },
        },
        default_component_configs = {
          git_status = {
            symbols = {
              -- Change type
              added = '✚', -- NOTE: you can set any of these to an empty string to not show them
              deleted = '✖',
              modified = '',
              renamed = '',
              -- Status type
              untracked = '',
              ignored = '',
              unstaged = '',
              staged = '',
              conflict = '',
            },
            align = 'right',
          },
        },
      }
    end,
  },
}
