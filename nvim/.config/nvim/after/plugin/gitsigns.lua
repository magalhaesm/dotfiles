local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
  return
end

gitsigns.setup {
  signs = {
    add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr" },
    change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr" },
    delete = { hl = "GitSignsDelete", text = "", numhl = "GitSignsDeleteNr" },
    topdelete = { hl = "GitSignsDelete", text = "", numhl = "GitSignsDeleteNr" },
    changedelete = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr" },
  },

  -- signcolumn = true,
  numhl = true,
  linehl = false,

  current_line_blame = false,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
    delay = 2000,
  },

  -- Options passed to nvim_open_win
  preview_config = {
    border = "rounded",
  },
}

map.nname("<leader>g", "Git")
nnoremap("<leader>gl", "<cmd>Gitsigns blame_line<CR>", "Blame line")
nnoremap("<leader>gB", "<cmd>Gitsigns toggle_current_line_blame<CR>", "Toggle blame")
nnoremap("<leader>gd", "<cmd>Gitsigns diffthis HEAD<CR>", "Diff")

local opts = { expr = true }
nnoremap("]c", "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", "Git: next hunk", opts)
nnoremap("[c", "&diff ? '[c' : '<cmd>Gitsig[s prev_hunk<CR>'", "Git: prev hunk", opts)

-- ToggleTerm
nnoremap("<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit")

-- Telescope
nnoremap("<leader>gs", "<cmd>Telescope git_status<CR>", "Status")
nnoremap("<leader>gb", "<cmd>Telescope git_branches<CR>", "Branchs")
nnoremap("<leader>gc", "<cmd>Telescope git_commits<CR>", "Commits")
