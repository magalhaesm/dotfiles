return {
  -- LSP Configuration
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- LSP Management
      { 'mason-org/mason.nvim', version = '^1.0.0' },
      { 'mason-org/mason-lspconfig.nvim', version = '^1.0.0' },
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      -- LSP UI Enhancements
      { 'j-hui/fidget.nvim', opts = {} },
      { 'folke/neodev.nvim', opts = {} },
    },
    config = function()
      -- Setup mason first
      require('mason').setup({
        ui = {
          border = 'rounded',
          height = 0.8,
          icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗',
          },
        },
      })

      -- LSP handlers and keymaps configuration
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
          map('<leader>sd', require('telescope.builtin').lsp_document_symbols, '[D]ocument Symbols')
          map('<leader>sW', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace Symbols')
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

          map('K', function()
            require('pretty_hover').hover()
          end, 'Hover Documentation')

          vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help)
        end,
      })

      -- Define servers with their specific settings
      local servers = {
        clangd = {
          fallbackFlags = { '-std=c++17', '-I/usr/include' },
        },
        gopls = {},
        pyright = {},
        rust_analyzer = {},
        -- tsserver = {},

        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = 'LuaJIT' },
              completion = {
                callSnippet = 'Replace',
              },
              diagnostics = {
                globals = {
                  'vim',
                },
              },
            },
          },
        },
      }

      -- List of tools to ensure are installed
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        --'stylua',
      })

      -- Setup mason-tool-installer
      require('mason-tool-installer').setup({
        ensure_installed = ensure_installed,
      })

      -- Get LSP capabilities enhanced by nvim-cmp
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Setup mason-lspconfig
      require('mason-lspconfig').setup({
        ensure_installed = ensure_installed,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      })

      -- LSP UI configuration
      local icons = require('config').icons.diagnostics
      for type, icon in pairs(icons) do
        local hl = 'DiagnosticSign' .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      require('lspconfig.ui.windows').default_options.border = 'rounded'

      vim.diagnostic.config({
        virtual_text = {
          severity_sort = true,
        },
        float = {
          header = '',
          border = 'rounded',
          focusable = true,
          max_width = math.floor(vim.o.columns * 0.7),
          max_height = math.floor(vim.o.lines * 0.3),
          source = true,
        },
      })
    end,
  },

  -- Autoformatting
  {
    'stevearc/conform.nvim',
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style
        local disable_filetypes = { c = true, cpp = false }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        python = function(bufnr)
          if require('conform').get_formatter_info('ruff_format', bufnr).available then
            return { 'ruff_format' }
          else
            return { 'isort', 'black' }
          end
        end,
      },
    },
  },

  -- Enhanced hover UI
  {
    'Fildo7525/pretty_hover',
    event = 'LspAttach',
    opts = {
      max_width = math.floor(vim.o.columns * 0.7),
      max_height = math.floor(vim.o.lines * 0.3),
      border = 'rounded',
    },
  },

  -- Completion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp', -- nvim-cmp source for neovim's built-in LSP
      'hrsh7th/cmp-buffer', -- nvim-cmp source for buffer words
      'hrsh7th/cmp-path', -- nvim-cmp source for path words
      'saadparwaiz1/cmp_luasnip', -- nvim-cmp source for luasnip
    },
    opts = function()
      local cmp = require('cmp')
      return {
        completion = {
          completeopt = 'menu,menuone,noselect',
        },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-Space>'] = cmp.mapping.complete({}),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          {
            name = 'buffer',
            option = { keyword_pattern = [[\k\+]] },
          },
          { name = 'path' },
        }),
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        formatting = {
          format = function(entry, vim_item)
            -- Source
            vim_item.menu = ({
              buffer = '[Buffer]',
              nvim_lsp = '[LSP]',
              luasnip = '[LuaSnip]',
              nvim_lua = '[Lua]',
              path = '[Path]',
            })[entry.source.name]
            return vim_item
          end,
        },
      }
    end,
  },

  -- Signature help
  {
    'ray-x/lsp_signature.nvim',
    event = 'VeryLazy',
    opts = {},
    config = function(_, _)
      -- Get signatures (and _only_ signatures) when in argument lists.
      require('lsp_signature').setup({
        doc_lines = 0,
        hint_enable = true,
        handler_opts = {
          border = 'rounded',
        },
      })
    end,
  },

  -- Surrounding pairs
  {
    'kylechui/nvim-surround',
    event = 'InsertEnter',
    opts = {},
  },

  -- Auto-pairs
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
  },

  -- Comment plugin
  {
    'numToStr/Comment.nvim',
    opts = {},
    event = { 'BufReadPost', 'BufNewFile' },
  },

  -- Snippet engine
  {
    'L3MON4D3/LuaSnip',
    version = 'v2.*',
    build = 'make install_jsregexp',
    dependencies = {
      'rafamadriz/friendly-snippets',
      config = function()
        require('luasnip.loaders.from_lua').lazy_load()
        require('luasnip.loaders.from_vscode').lazy_load()
      end,
    },
    opts = {
      history = true,
      delete_check_events = 'TextChanged,TextChangedI',
      enable_autosnippets = true,
    },
    keys = {
      {
        '<C-j>',
        function()
          return require('luasnip').jumpable(1) and '<Plug>luasnip-jump-next' or '<tab>'
        end,
        expr = true,
        silent = true,
        mode = 'i',
      },
      {
        '<C-j>',
        function()
          require('luasnip').jump(1)
        end,
        mode = 's',
      },
      {
        '<C-k>',
        function()
          require('luasnip').jump(-1)
        end,
        mode = { 'i', 's' },
      },
    },
  },

  -- Treesitter
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
