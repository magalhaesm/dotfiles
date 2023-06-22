return {
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
  }
}
