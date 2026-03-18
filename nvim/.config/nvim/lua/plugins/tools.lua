return {
  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-neotest/nvim-nio',
      'leoluz/nvim-dap-go',
      'theHamsta/nvim-dap-virtual-text',
    },
    config = function()
      local dap, dapui = require('dap'), require('dapui')

      require('dapui').setup()
      require('dap-go').setup()
      require('nvim-dap-virtual-text').setup({})

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, {})
      vim.keymap.set('n', '<leader>?', function()
        require('dapui').eval(nil, { enter = true })
      end)

      vim.keymap.set('n', '<F1>', dap.continue, {})
      vim.keymap.set('n', '<F2>', dap.step_into, {})
      vim.keymap.set('n', '<F3>', dap.step_over, {})
      vim.keymap.set('n', '<F4>', dap.step_out, {})
      vim.keymap.set('n', '<F5>', dap.step_back, {})
      vim.keymap.set('n', '<F6>', dap.restart, {})
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      signs = {
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      preview_config = {
        border = 'rounded',
      },
      on_attach = function(buffer)
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = buffer, desc = desc })
        end

        map('n', '<leader>gb', '<cmd>Gitsigns blame_line<CR>', '[G]it [B]lame')
        map('n', '<leader>gt', '<cmd>Gitsigns toggle_current_line_blame<CR>', '[G]it blame [T]oggle')
        map('n', '<leader>gr', '<cmd>Gitsigns reset_hunk<CR>', '[R]eset Hunk')
        map('n', '<leader>gp', '<cmd>Gitsigns preview_hunk<CR>', '[P]review Hunk')
      end,
    },
  },
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
  {
    'vim-test/vim-test',
    dependencies = {
      'preservim/vimux',
    },
    config = function()
      vim.cmd([[let test#strategy = "vimux"]])
    end,
    keys = {
      { '<leader>tn', '<cmd>TestNearest<CR>', desc = '[T]est [N]earest to the cursor' },
      { '<leader>tf', '<cmd>TestFile<CR>', desc = '[T]est the whole [F]ile' },
      { '<leader>ts', '<cmd>TestSuite<CR>', desc = 'Run the whole [T]est [S]uite' },
      { '<leader>tl', '<cmd>TestLast<CR>', desc = 'Run the [L]ast [T]est' },
    },
  },
}
