return {
  { -- LSP Configuration & Plugins
    -- 'neovim/nvim-lspconfig',
    -- dependencies = {
    --   { 'williamboman/mason.nvim',                  version = '^1.0.0' },
    --   { 'williamboman/mason-lspconfig.nvim',        version = '^1.0.0' },
    --   { 'j-hui/fidget.nvim',                        opts = {} },
    --   { 'folke/neodev.nvim',                        opts = {} },
    --   { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    -- },

    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim",                     opts = {} },
      { 'j-hui/fidget.nvim',                        opts = {} },
      { 'folke/neodev.nvim',                        opts = {} },
      { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
      "neovim/nvim-lspconfig",
    },


    config = function()
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

      require('mason-tool-installer').setup({
        -- ensure_installed = {
        --   'pyright',
        --   'ts_ls',
        -- }
      })

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

      local lspconfig = require('lspconfig')
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      require('mason-lspconfig').setup({
        automatic_installation = true,
        ensure_installed = {
          'clangd',
          'lua_ls',
          'gopls',
          'jdtls'
        },
        handlers = {
          function(server_name) -- default handler (optional)
            require('lspconfig')[server_name].setup({
              capabilities = capabilities,
            })
          end,
          ['lua_ls'] = function()
            -- local lspconfig = require('lspconfig')
            lspconfig.lua_ls.setup({
              capabilities = capabilities,
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
            })
          end,
          ['clangd'] = function()
            lspconfig.clangd.setup({
              capabilities = capabilities,
              cmd = {
                'clangd',
                '--header-insertion=never',
                '--clang-tidy',
                '--completion-style=detailed',
              },
              -- filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
              -- root_markers = { '.clangd', 'compile_commands.json' },
              filetypes = { 'c', 'cpp' },
            })
          end,
          ['jdtls'] = function()
            lspconfig.jdtls.setup {}
          end
        },
      })

      -- LSP UI.
      local icons = require('config').icons.diagnostics

      require('lspconfig.ui.windows').default_options.border = 'rounded'

      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = icons.Error,
            [vim.diagnostic.severity.WARN]  = icons.Warn,
            [vim.diagnostic.severity.INFO]  = icons.Info,
            [vim.diagnostic.severity.HINT]  = icons.Hint,
          },
        },
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
    end,
  },
  -- {
  --   "mfussenegger/nvim-jdtls",
  --   ft = { "java" },
  -- },
  -- {
  --   'nvim-java/nvim-java',
  --   config = function()
  --     require('java').setup()
  --     vim.lsp.enable('jdtls')
  --   end,
  -- },
  { -- Autoformat
    'stevearc/conform.nvim',
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
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
  {
    'Fildo7525/pretty_hover',
    event = 'LspAttach',
    opts = {
      max_width = math.floor(vim.o.columns * 0.7),
      max_height = math.floor(vim.o.lines * 0.3),
      border = 'rounded',
    },
  },
}
