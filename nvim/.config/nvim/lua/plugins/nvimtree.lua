-------------------------------------------------------------------------------
--  NvimTree:
-------------------------------------------------------------------------------

local M = {}
local status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not status_ok then
  return
end

M.config = function()
  local g = vim.g

  g.nvim_tree_side = "left"
  g.nvim_tree_width = 30
  g.nvim_tree_ignore = { ".git", "node_modules", ".cache", "__pycache__", ".pytest_cache" }
  g.nvim_tree_auto_open = 1
  g.nvim_tree_auto_close = 1
  g.nvim_tree_quit_on_open = 1
  g.nvim_tree_follow = 1
  g.nvim_tree_indent_markers = 0
  g.nvim_tree_hide_dotfiles = 0
  g.nvim_tree_git_hl = 1
  g.nvim_tree_root_folder_modifier = ":t"
  g.nvim_tree_tab_open = 0
  g.nvim_tree_allow_resize = 1
  g.nvim_tree_lsp_diagnostics = 1
  g.nvim_tree_auto_ignore_ft = { "startify", "dashboard" }

  g.nvim_tree_show_icons = {
    git = 1,
    folders = 1,
    files = 1,
    folder_arrows = 1,
  }

  g.nvim_tree_icons = {
    default = "",
    symlink = "",
    git = {
      unstaged = "",
      staged = "S",
      unmerged = "",
      renamed = "➜",
      deleted = "",
      untracked = "U",
      ignored = "◌",
    },
    folder = {
      default = "",
      open = "",
      empty = "",
      empty_open = "",
      symlink = "",
    },
  }
  local tree_cb = nvim_tree_config.nvim_tree_callback

  g.nvim_tree_bindings = {
    { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
    { key = "h", cb = tree_cb "close_node" },
    { key = "v", cb = tree_cb "vsplit" },
  }
end

M.toggle_tree = function()
  local view_status_ok, view = pcall(require, "nvim-tree.view")
  if not view_status_ok then
    return
  end
  if view.win_open() then
    require("nvim-tree").close()
    if package.loaded["bufferline.state"] then
      require("bufferline.state").set_offset(0)
    end
  else
    if package.loaded["bufferline.state"] then
      require("bufferline.state").set_offset(31, "")
    end
    require("nvim-tree").toggle()
  end
end

return M
