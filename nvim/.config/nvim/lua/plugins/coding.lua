--[[
  coding.lua - Language support, LSP, completions and syntax highlighting

  This file contains plugins related to programming language support,
  including:
  - LSP (Language Server Protocol) configuration
  - Completion and snippet system
  - Syntax highlighting via Treesitter
  - Automatic code formatting
  - Function signatures and hover documentation
]]

--------------------------------------------------
-- Helper function definitions
--------------------------------------------------

-- Sets up LSP handlers and keymaps
local function setup_lsp_handlers()
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
    callback = function(event)
      local map = function(keys, func, desc)
        vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
      end

      -- Navigation and references
      map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
      map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
      map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
      map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

      -- Symbols and documentation
      map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
      map('<leader>sd', require('telescope.builtin').lsp_document_symbols, '[D]ocument Symbols')
      map('<leader>sW', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace Symbols')
      map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
      map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

      -- Hover documentation
      map('K', function()
        require('pretty_hover').hover()
      end, 'Hover Documentation')

      vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help)
    end,
  })
end

-- Sets up LSP diagnostics UI
local function setup_diagnostic_ui()
  local icons = require('config').icons.diagnostics
  for type, icon in pairs(icons) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  require('lspconfig.ui.windows').default_options.border = 'rounded'

  vim.diagnostic.config({
    virtual_text = {
      -- prefix = "",
      -- prefix = '',
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
end

-- Defines LSP servers and their settings
local function get_lsp_servers()
  return {
    clangd = {
      fallbackFlags = { '-std=c++17', '-I/usr/include' },
    },
    gopls = {},
    pyright = {},
    rust_analyzer = {},
    ts_ls = {},

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
end

return {
  --------------------------------------------------
  -- LSP Configuration (Language Server Protocol)
  --------------------------------------------------
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
      -- Mason setup (installer manager)
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

      -- Setup handlers and keymaps
      setup_lsp_handlers()

      -- Define servers and their specific configurations
      local servers = get_lsp_servers()

      -- List of tools to ensure installation
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        -- 'stylua',
      })

      -- mason-tool-installer configuration
      require('mason-tool-installer').setup({
        ensure_installed = ensure_installed,
      })

      -- Advanced capabilities configuration with nvim-cmp support
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- mason-lspconfig configuration for automatic server setup
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

      -- LSP diagnostics UI setup
      setup_diagnostic_ui()
    end,
  },

  --------------------------------------------------
  -- Code Formatting
  --------------------------------------------------
  {
    'stevearc/conform.nvim',
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Desativa "format_on_save lsp_fallback" para linguagens sem estilo padronizado
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

  --------------------------------------------------
  -- Enhanced Hover Documentation UI
  --------------------------------------------------
  {
    'Fildo7525/pretty_hover',
    event = 'LspAttach',
    opts = {
      max_width = math.floor(vim.o.columns * 0.7),
      max_height = math.floor(vim.o.lines * 0.3),
      border = 'rounded',
    },
  },

  --------------------------------------------------
  -- Completion System
  --------------------------------------------------
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
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
            -- Rótulos das fontes
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

  --------------------------------------------------
  -- Function Signature Help
  --------------------------------------------------
  {
    'ray-x/lsp_signature.nvim',
    event = 'VeryLazy',
    opts = {},
    config = function(_, _)
      -- Obter assinaturas (e *somente* assinaturas) ao navegar por listas de argumentos
      require('lsp_signature').setup({
        doc_lines = 0,
        hint_enable = true,
        handler_opts = {
          border = 'rounded',
        },
      })
    end,
  },

  --------------------------------------------------
  -- Surrounding Pairs
  --------------------------------------------------
  -- Manipulação de pares delimitadores (parênteses, chaves, aspas)
  {
    'kylechui/nvim-surround',
    event = 'InsertEnter',
    opts = {},
  },

  -- Auto-parênteses e auto-fechamento de delimitadores
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
  },

  --------------------------------------------------
  -- Suporte a comentários
  --------------------------------------------------
  {
    'numToStr/Comment.nvim',
    opts = {},
    event = { 'BufReadPost', 'BufNewFile' },
  },

  --------------------------------------------------
  -- Engine de snippets
  --------------------------------------------------
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

  --------------------------------------------------
  -- Treesitter (Syntax highlighting avançado)
  --------------------------------------------------
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
      -- Syntax highlighting
      highlight = { enable = true },
      indent = { enable = true, disable = { 'python' } },
      context_commentstring = { enable = true, enable_autocmd = false },

      -- Instalação automática de parsers
      auto_install = true,
      ensure_installed = { 'bash', 'c', 'html', 'lua', 'markdown', 'vim', 'vimdoc' },

      -- Seleção incremental de nós sintáticos
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-space>',
          node_incremental = '<C-space>',
          scope_incremental = '<nop>',
          node_decremental = '<BS>',
        },
      },

      -- Objetos textuais baseados em análise sintática
      textobjects = {
        -- Interoperabilidade com LSP
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

        -- Seleção de objetos textuais
        select = {
          enable = true,
          lookahead = true, -- Avança automaticamente para o próximo objeto, semelhante ao targets.vim
          keymaps = {
            -- Você pode usar os grupos de captura definidos em textobjects.scm
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
          },
        },

        -- Navegação entre objetos textuais
        move = {
          enable = true,
          set_jumps = true, -- Define saltos na jumplist
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

        -- Troca de elementos sintáticos
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
