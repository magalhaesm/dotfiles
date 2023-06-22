return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>bt", "<cmd>BufferLineGroupToggle tests<CR>", desc = "Group Tests" },
      { "<leader>bx", "<cmd>BufferLineGroupToggle docs<CR>",  desc = "Group Docs" },
      { "<S-h>",      "<cmd>BufferLineCyclePrev<CR>" },
      { "<S-l>",      "<cmd>BufferLineCycleNext<CR>" },
    },
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
        groups = {
          items = {
            {
              name = "tests",
              icon = "",
              matcher = function(buf)
                return buf.path:match("%test_") or buf.path:match("%_spec")
              end,
            },
            {
              name = "docs",
              matcher = function(buf)
                return buf.path:match("%.md") or buf.path:match("%.txt")
              end,
            },
          },
        },
      },
    },
  }
}
