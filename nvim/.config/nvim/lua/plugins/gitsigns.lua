return {
  -- GitSigns
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "-" },
        -- add = { text = "▎" },
        -- change = { text = "▎" },
        -- delete = { text = "契" },
        -- topdelete = { text = "契" },
        -- changedelete = { text = "▎" },
        -- untracked = { text = "▎" },
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
      end,
    },
  },
}
