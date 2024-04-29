return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      local harpoon = require('harpoon')
      harpoon:setup({
        settings = {
          save_on_toggle = true,
        },
      })

      -- Harpoon user interface
      vim.keymap.set('n', '<leader>a', function()
        harpoon:list():add()
      end, { desc = 'Add to Harpoon' })

      vim.keymap.set('n', '<C-n>', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = 'Open Harpoon' })

      -- Harpoon files
      vim.keymap.set('n', '<leader>h', function()
        harpoon:list():select(1)
      end, { desc = 'Set harpoon 1' })
      vim.keymap.set('n', '<leader>j', function()
        harpoon:list():select(2)
      end, { desc = 'Set harpoon 2' })
      vim.keymap.set('n', '<leader>k', function()
        harpoon:list():select(3)
      end, { desc = 'Set harpoon 3' })
      vim.keymap.set('n', '<leader>l', function()
        harpoon:list():select(4)
      end, { desc = 'Set harpoon 4' })
    end,
  },
}
