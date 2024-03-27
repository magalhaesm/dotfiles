return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
    opts = {
      highlight = { enable = true },
      indent = { enable = true, disable = { 'python' } },
      context_commentstring = { enable = true, enable_autocmd = false },

      auto_install = true,
      ensure_installed = { 'bash', 'c', 'html', 'lua', 'markdown', 'vim', 'vimdoc' },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-space>',
          node_incremental = '<C-space>',
          scope_incremental = '<nop>',
          node_decremental = '<BS>',
        },
      },
      textobjects = {
        lsp_interop = {
          enable = true,
          floating_preview_opts = {
            border = 'rounded',
          },
          peek_definition_code = {
            ['<leader>pd'] = '@function.outer',
            ['<leader>pD'] = '@class.outer',
          },
        },
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            [']m'] = '@function.outer',
            [']]'] = '@class.outer',
          },
          goto_next_end = {
            [']M'] = '@function.outer',
            [']['] = '@class.outer',
          },
          goto_previous_start = {
            ['[m'] = '@function.outer',
            ['[['] = '@class.outer',
          },
          goto_previous_end = {
            ['[M'] = '@function.outer',
            ['[]'] = '@class.outer',
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ['<leader>Sn'] = { query = '@parameter.inner', desc = 'Swap current parameter with the next' },
          },
          swap_previous = {
            ['<leader>Sp'] = { query = '@parameter.inner', desc = 'Swap current parameter with the previous' },
          },
        },
      },
    },
  },
}
