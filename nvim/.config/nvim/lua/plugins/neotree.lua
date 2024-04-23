return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- 'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    keys = {
      { '<leader>e', '<cmd>Neotree toggle<CR>', desc = '[E]xplorer' },
    },
    config = function()
      require('neo-tree').setup({
        window = {
          width = 35,
        },
        filesystem = {
          follow_current_file = { enabled = true },
        },
        default_component_configs = {
          icon = {
            folder_open = '',
            default = '',
          },
          git_status = {
            symbols = {
              -- Change type
              added = '✚',
              deleted = '✖',
              modified = '',
              renamed = '󰁕',
              -- Status type
              untracked = '',
              ignored = '',
              unstaged = '',
              staged = '',
              conflict = '',
            },
            -- align = 'right',
          },
        },
      })
    end,
  },
}
