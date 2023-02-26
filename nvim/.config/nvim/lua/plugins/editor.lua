return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
      icons = {
        breadcrumb = "»",
        separator = "",
        group = "+",
      },
      window = {
        border = "rounded",
        position = "bottom",
        margin = { 1, 0, 1, 0 },
        padding = { 2, 2, 2, 2 },
        winblend = 0,
      },
      layout = {
        height = { min = 4, max = 15 },
        width = { min = 20, max = 50 },
        spacing = 3,
        align = "center",
      },
      key_labels = {
        ["<space>"] = "SPC",
        -- ["<cr>"] = "RET",
        -- ["<tab>"] = "TAB",
      },
      triggers_blacklist = {
        i = { "j", "k" },
        v = { "j", "k" },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      local keymaps = {
        mode = { "n", "v" },
        ["<leader>b"] = { name = "+buffer" },
        ["<leader>c"] = { name = "+code" },
        ["<leader>x"] = { name = "+diagnostics/quickfix" },
        ["<leader>f"] = { name = "+file/find" },
        ["<leader>r"] = { name = "+rename" },
        ["<leader>g"] = { name = "+git" },
        ["<leader>s"] = { name = "+search/swap" },
      }
      wk.register(keymaps)
    end,
  },
  -- Todo Comments
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    opts = {
      gui_style = {
        fg = "BOLD",
        bg = "NONE",
      },
      highlight = {
        before = "",
        keyword = "fg",
        after = "",
      },
    },
    event = { "BufReadPost", "BufNewFile" },
    config = true,
    keys = {
      {
        "]t",
        function()
          require("todo-comments").jump_next()
        end,
        desc = "Next todo comment",
      },
      {
        "[t",
        function()
          require("todo-comments").jump_prev()
        end,
        desc = "Previous todo comment",
      },
      { "<leader>xt", "<cmd>TodoTrouble<cr>",                         desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>",                       desc = "Todo" },
    },
  },
  -- Better Diagnostics
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>",  desc = "Document Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
      { "<leader>xL", "<cmd>TroubleToggle loclist<cr>",               desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>",              desc = "Quickfix List (Trouble)" },
    },
  },

  -- Buffer Remove
  {
    "echasnovski/mini.bufremove",
    keys = {
      {
        "<leader>bd",
        function()
          require("mini.bufremove").delete(0, false)
        end,
        desc = "Delete Buffer",
      },
      {
        "<leader>bD",
        function()
          require("mini.bufremove").delete(0, true)
        end,
        desc = "Delete Buffer (Force)",
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    version = "*",
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>ft", "<cmd>Neotree toggle<CR>", desc = "Neo[T]ree" },
    },
    config = function()
      require("neo-tree").setup({
        window = {
          width = 35,
        },
        default_component_configs = {
          git_status = {
            symbols = {
              -- Change type
              added     = "✚", -- NOTE: you can set any of these to an empty string to not show them
              deleted   = "✖",
              modified  = "",
              renamed   = "",
              -- Status type
              untracked = "",
              ignored   = "",
              unstaged  = "",
              staged    = "",
              conflict  = "",
            },
            align = "right",
          }
        },
      })
    end,
  },
  -- GitSigns
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "契" },
        topdelete = { text = "契" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      numhl = false,
      linehl = false,
      current_line_blame = false,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        -- delay = 2000,
      },
      preview_config = {
        border = "rounded",
      },
      on_attach = function(buffer)
        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end
        map("n", "<leader>gl", "<cmd>Gitsigns blame_line<CR>", "Blame line")
        map("n", "<leader>gB", "<cmd>Gitsigns toggle_current_line_blame<CR>", "Toggle blame")
        map("n", "<leader>gd", "<cmd>Gitsigns diffthis HEAD<CR>", "Diff")
      end
      },
    },
  -- École 42
  { "magalhaesm/42header.nvim", ft = { "c", "cpp" } },
  { "andweeb/presence.nvim", opts = {}, event = "VeryLazy" },
}
