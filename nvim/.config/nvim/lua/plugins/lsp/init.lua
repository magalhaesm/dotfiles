return {
  {
    -- LSP Support
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "j-hui/fidget.nvim",
      "folke/neodev.nvim",
    },
    opts = {
      servers = {
        clangd = {
          settings = {
            cmd = {
              "clangd",
              "--background-index",
              "--suggest-missing-includes",
              "--clang-tidy",
              "--header-insertion=iwyu",
            },
          },
        },
        bashls = {},
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "off",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
              },
            },
          },
        },
        tsserver = {},
        lua_ls = {
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              completion = { callSnippet = "Replace" },
              telemetry = { enable = false },
            },
          },
        },
      },
    },
    config = function(_, opts)
      require("fidget").setup()

      -- Setup neovim lua configuration
      require("neodev").setup({
        library = {
          enabled = true, -- when not enabled, neodev will not change any settings to the LSP server
          -- these settings will be used for your Neovim config directory
          runtime = true, -- runtime path
          types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
          plugins = false, -- installed opt or start plugins in packpath
          -- you can also specify the list of plugins to make available as a workspace library
          -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
        },
      })

      -- LspInfo border
      require("lspconfig.ui.windows").default_options.border = "rounded"

      -- Diagnostics
      require("plugins.lsp.diagnostics").setup()

      local on_attach = require("plugins.lsp.keymaps").on_attach
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      -- Ensure the servers above are installed
      local mason_lspconfig = require("mason-lspconfig")
      local servers = opts.servers
      mason_lspconfig.setup({
        ensure_installed = vim.tbl_keys(servers),
      })
      mason_lspconfig.setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
          })
        end,
      })
      -- require("rust-tools").setup {
      --   server = {
      --     -- on_attach = on_attach,
      --     capabilities = capabilities,
      --   },
      -- }
    end,
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<CR>", desc = "Mason" } },
    opts = {
      ensure_installed = {
        "stylua",
        "black",
        "isort",
        "flake8",
        "pylint",
        "shellcheck",
      },
      ui = {
        border = "rounded",
        height = 0.8,
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      for _, tool in ipairs(opts.ensure_installed) do
        local pkg = mr.get_package(tool)
        if not pkg:is_installed() then
          pkg:install()
        end
      end
    end,
  },
  -- formatters
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    opts = function()
      local function has_file(file)
        return function(utils)
          return utils.root_has_file(file)
        end
      end
      local nls = require("null-ls").builtins
      return {
        sources = {
          -- Python
          nls.formatting.black,
          nls.formatting.isort,
          nls.diagnostics.flake8.with({ condition = has_file(".flake8") }),
          nls.diagnostics.pylint.with({ condition = has_file(".pylintrc") }),
          -- Lua
          nls.formatting.stylua.with({
            extra_args = { "--config-path", vim.fn.expand("$XDG_CONFIG_HOME/stylua.toml") },
          }),
          -- Bash
          nls.diagnostics.shellcheck,
        },
      }
    end,
  },
}
