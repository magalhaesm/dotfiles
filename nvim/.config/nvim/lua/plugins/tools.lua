--[[
  tools.lua - Integração com ferramentas externas

  Este arquivo contém plugins que integram o Neovim com ferramentas
  externas como Git, depuradores e ambientes de teste.

  Plugins incluídos:
  • lewis6991/gitsigns.nvim - Integração com Git
  • vim-test/vim-test - Execução de testes
  • preservim/vimux - Integração com Tmux
  • andweeb/presence.nvim - Integração com Discord
  • rcarriga/nvim-dap-ui e relacionados - Depuração de código
--]]

return {
  -- Git integration
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      signs = {
        -- add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      preview_config = {
        border = 'rounded',
      },
      on_attach = function(buffer)
        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end
        map('n', '<leader>gb', '<cmd>Gitsigns blame_line<CR>', '[G]it [B]lame')
        map('n', '<leader>gt', '<cmd>Gitsigns toggle_current_line_blame<CR>', '[G]it blame [T]oggle')
        map('n', '<leader>gr', '<cmd>Gitsigns reset_hunk<CR>', '[R]eset Hunk')
        map('n', '<leader>gp', '<cmd>Gitsigns preview_hunk<CR>', '[P]review Hunk')
      end,
    },
  },

  -- Testing
  {
    'vim-test/vim-test',
    dependencies = {
      'preservim/vimux',
    },
    config = function()
      vim.cmd([[let test#strategy = "vimux"]])
    end,
    keys = {
      {
        '<leader>tn',
        '<cmd>TestNearest<CR>',
        desc = '[T]est [N]earest to the cursor',
      },
      {
        '<leader>tf',
        '<cmd>TestFile<CR>',
        desc = '[T]est the whole [F]ile',
      },
      {
        '<leader>ts',
        '<cmd>TestSuite<CR>',
        desc = 'Run the whole [T]est [S]uite',
      },
      {
        '<leader>tl',
        '<cmd>TestLast<CR>',
        desc = 'Run the [L]ast [T]est',
      },
    },
  },

  -- Debugging
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

      vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Toggle [B]reakpoint' })
      vim.keymap.set('n', '<leader>?', function()
        require('dapui').eval(nil, { enter = true })
      end, { desc = 'Evaluate Expression' })

      vim.keymap.set('n', '<F1>', dap.continue, { desc = 'DAP: Continue' })
      vim.keymap.set('n', '<F2>', dap.step_into, { desc = 'DAP: Step Into' })
      vim.keymap.set('n', '<F3>', dap.step_over, { desc = 'DAP: Step Over' })
      vim.keymap.set('n', '<F4>', dap.step_out, { desc = 'DAP: Step Out' })
      vim.keymap.set('n', '<F5>', dap.step_back, { desc = 'DAP: Step Back' })
      vim.keymap.set('n', '<F6>', dap.restart, { desc = 'DAP: Restart' })
    end,
    keys = {
      {
        '<leader>du',
        function()
          require('dapui').toggle()
        end,
        desc = '[D]ebug [U]I Toggle',
      },
    },
  },

  -- Discord presence (optional)
  {
    'andweeb/presence.nvim',
    opts = {
      auto_update = true,
      neovim_image_text = 'The One True Text Editor',
      main_image = 'neovim',
      log_level = nil,
      debounce_timeout = 10,
      enable_line_number = false,
      blacklist = {},
      buttons = true,
      show_time = true,
    },
    event = 'VeryLazy',
    enabled = false, -- Set to true if you want to enable Discord presence
  },

  -- Lazygit integration (if you want it separate from just using the executable)
  {
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    keys = {
      { '<leader>gg', '<cmd>LazyGit<CR>', desc = 'Open Lazy[G]it' },
    },
    enabled = true, -- Set to false if you prefer using the command line directly
  },

  -- Project management
  {
    'ahpedkhalf/project.nvim',
    config = function()
      require('project_nvim').setup({
        patterns = { '.git', 'Makefile', 'package.json', 'Cargo.toml', 'go.mod' },
        detection_methods = { 'pattern', 'lsp' },
        show_hidden = false,
      })
      require('telescope').load_extension('projects')
    end,
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
    keys = {
      { '<leader>sp', '<cmd>Telescope projects<CR>', desc = '[S]earch [P]rojects' },
    },
    enabled = false, -- Set to false if you don't need project management
  },

  -- Todo comments
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
      { '<leader>tt', '<cmd>TodoTelescope<CR>', desc = '[T]odo [T]elescope' },
    },
  },
}
