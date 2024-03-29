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
        harpoon:list():append()
      end, { desc = 'Add to Harpoon' })

      vim.keymap.set('n', '<C-n>', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = 'Open Harpoon' })

      -- Harpoon files
      vim.keymap.set('n', '<A-1>', function()
        harpoon:list():select(1)
      end)
      vim.keymap.set('n', '<A-2>', function()
        harpoon:list():select(2)
      end)
      vim.keymap.set('n', '<A-3>', function()
        harpoon:list():select(3)
      end)
      vim.keymap.set('n', '<A-4>', function()
        harpoon:list():select(4)
      end)

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set('n', '<S-h>', function()
        harpoon:list():prev()
      end)
      vim.keymap.set('n', '<S-l>', function()
        harpoon:list():next()
      end)
    end,
  },
}
