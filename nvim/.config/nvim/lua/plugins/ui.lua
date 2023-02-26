return {
  {
    "stevearc/dressing.nvim",
    event = { "BufReadPost", "BufNewFile" },
  },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        modified_icon = "",
        show_close_icon = false,
        show_buffer_close_icons = false,
        close_icon = "",
        separator_style = "slant",
        offsets = {
          {
            filetype = "neo-tree",
            text = " Explorer",
            highlight = "PanelHeading",
            padding = 1,
          },
        },
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      local icons = require("config").icons
      local hide_in_width = function()
        return vim.fn.winwidth(0) > 70
      end
      local function lsp_active()
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
          return ""
        end
        return ""
      end
      local function position()
        return "☰ %3l/%-3L ln :%3v "
      end
      local filename = {
        "filename",
        symbols = { modified = "  ", readonly = "  " },
      }
      local diff = {
        "diff",
        colored = true,
        symbols = { added = " ", modified = " ", removed = " " },
        cond = hide_in_width,
      }
      local diagnostics = {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = {
          hint = icons.diagnostics.Hint,
          info = icons.diagnostics.Info,
          warn = icons.diagnostics.Warn,
          error = icons.diagnostics.Error,
        },
      }
      return {
        options = {
          globalstatus = true,
          icons_enabled = true,
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = { "alpha", "Outline" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = { filename, diff },
          lualine_x = { diagnostics, lsp_active, "filetype" },
          lualine_y = { "progress" },
          lualine_z = { position },
        },
      }
    end,
  },
  -- Indent Guides
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      char = "│",
      filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
      show_trailing_blankline_indent = false,
      show_current_context = false,
    },
  },
  -- Icons
  { "nvim-tree/nvim-web-devicons", lazy = true },
  -- Dashboard
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      dashboard.section.header.val = {
        [[]],
        [[]],
        [[]],
        [[███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
        [[████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
        [[██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
        [[██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
        [[██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
        [[╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
        [[]],
        [[       Trabalhar menos, trabalharmos todos. ☭ ]],
        [[    Produzir só o essencial e redistribuir tudo.]],
      }
      dashboard.section.buttons.val = {
        dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
        dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
        dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
        dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
        dashboard.button("l", "鈴" .. " Lazy", ":Lazy<CR>"),
        dashboard.button("q", " " .. " Quit", ":qa<CR>"),
      }
      return dashboard
    end,
    config = function(_, dashboard)
      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end
      require("alpha").setup(dashboard.opts)
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },
}
