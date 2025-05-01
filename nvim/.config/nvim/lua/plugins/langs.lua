--[[
  langs.lua - Suporte específico para linguagens

  Este arquivo contém plugins dedicados a linguagens específicas,
  proporcionando funcionalidades além do suporte LSP padrão.

  Plugins incluídos:
  • ray-x/go.nvim - Suporte avançado para Go
  • ~/Projetos/42header - Suporte para projetos da École 42
  • Outros plugins específicos para linguagens de programação
--]]

return {
  -- Go language support
  {
    'ray-x/go.nvim',
    dependencies = {
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('go').setup({
        luasnip = true,
      })
    end,
    event = { 'CmdlineEnter' },
    ft = { 'go', 'gomod' },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },

  -- 42 School header
  {
    dir = '~/Projetos/42header',
    ft = { 'c', 'cpp' },
    enabled = false,
  },

  -- Rust specific configuration
  {
    'simrat39/rust-tools.nvim',
    ft = { 'rust' },
    dependencies = {
      'neovim/nvim-lspconfig',
    },
    config = function()
      require('rust-tools').setup({
        server = {
          on_attach = function(_, bufnr)
            -- Enable hover actions
            vim.keymap.set(
              'n',
              '<C-space>',
              require('rust-tools').hover_actions.hover_actions,
              { buffer = bufnr, desc = 'Rust hover actions' }
            )
            -- Enable code action groups
            vim.keymap.set(
              'n',
              '<Leader>ca',
              require('rust-tools').code_action_group.code_action_group,
              { buffer = bufnr, desc = 'Rust code action group' }
            )
          end,
        },
        -- Add other settings if needed
      })
    end,
  },

  -- Lua language support
  {
    'folke/neodev.nvim',
    ft = { 'lua' },
    opts = {
      library = {
        plugins = { 'nvim-dap-ui' },
        types = true,
      },
    },
  },

  -- Markdown previewer
  -- {
  --   'iamcco/markdown-preview.nvim',
  --   cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  --   ft = { 'markdown' },
  --   build = function()
  --     vim.fn['mkdp#util#install']()
  --   end,
  -- },

  -- Python specific configuration
  {
    'mfussenegger/nvim-dap-python',
    ft = { 'python' },
    dependencies = {
      'mfussenegger/nvim-dap',
    },
    config = function()
      local path = vim.fn.exepath('python')
      require('dap-python').setup(path)
    end,
  },

  -- LSP enhancements for TypeScript/JavaScript
  {
    'pmizio/typescript-tools.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'neovim/nvim-lspconfig',
    },
    ft = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' },
    opts = {},
  },

  -- Terraform support
  {
    'hashivim/vim-terraform',
    ft = { 'terraform', 'tf' },
  },
}
