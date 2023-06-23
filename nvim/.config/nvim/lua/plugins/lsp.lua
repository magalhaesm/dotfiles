return {
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- LSP Support
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "jose-elias-alvarez/null-ls.nvim",
      "stevearc/dressing.nvim",
    },
    config = function()
      local lsp = require("lsp-zero").preset({ "minimal" })
      local lspconfig = require('lspconfig')

      -- Keymaps
      lsp.on_attach(function(_, bufnr)
        lsp.default_keymaps({ buffer = bufnr })

        local nmap = function(keys, func, desc)
          if desc then
            desc = "LSP: " .. desc
          end
          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
        end

        nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
        nmap("<leader>cf", vim.lsp.buf.format, "[F]ormat")
        nmap("<leader>cl", "<cmd>LspInfo<CR>", "Lsp Info")
        nmap("[d", vim.diagnostic.goto_prev, "Prev Diagnostic")
        nmap("]d", vim.diagnostic.goto_prev, "Next Diagnostic")
        nmap("gl", vim.diagnostic.open_float, "[L]ine Diagnostic")
        nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
        nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

        -- See `:help K` for why this keymap
        nmap("K", function()
          require("pretty_hover").hover()
        end, "Hover Documentation")
        vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help)
      end)

      local icons = require("config").icons.diagnostics
      lsp.set_sign_icons({
        error = icons.Error,
        warn = icons.Warn,
        hint = icons.Hint,
        info = icons.Info,
      })

      lsp.ensure_installed({
        -- NOTE: Replace these with whatever servers you want to install
        "clangd",
        "bashls",
        "pyright",
        "tsserver",
        "lua_ls",
        "gopls"
      })

      lsp.format_on_save({
        servers = {
          ["lua_ls"] = { "lua" },
          ["gopls"] = { "go" },
        }
      })

      lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

      lsp.setup()

      local null_ls = require('null-ls')
      null_ls.setup({
        sources = {
          -- Replace these with the tools you have installed
          null_ls.builtins.formatting.black,
        }
      })

      require("lspconfig.ui.windows").default_options.border = "rounded"
      -- Overwrites lsp-zero config
      -- vim.diagnostic.config({ virtual_text = false, float = border_opts })
      vim.diagnostic.config({
        virtual_text = {
          -- prefix = "",
          prefix = "",
          severity_sort = true,
        },
        float = {
          header = "",
          border = "rounded",
          focusable = true,
          max_width = math.floor(vim.o.columns * 0.7),
          max_height = math.floor(vim.o.lines * 0.3),
          source = "always",
        }
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    cmd = "Mason",
    keys = {
      { "<leader>cm", "<cmd>Mason<CR>", desc = "Mason" }
    },
    opts = {
      ensure_installed = {
        "stylua",
        "black",
        "ruff",
        "shellcheck",
      },
      ui = {
        border = "rounded",
        height = 0.8,
      },
    },
  },
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    tag = 'legacy',
    config = function()
      require("fidget").setup {}
    end
  },
  {
    "Fildo7525/pretty_hover",
    event = "LspAttach",
    opts = {
      line = {
        "@brief",
      },
      word = {
        "@param",
        "@tparam",
        "@see",
      },
      header = {
        "@class",
      },
      stylers = {
        line = "**",
        word = "`",
        header = "###",
      },
      border = "rounded",
    },
  },
}
