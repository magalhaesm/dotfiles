vim.g.nvim_tree_icons = {
  git = {
    unstaged = "",
    staged = "",
    unmerged = "",
    renamed = "",
    untracked = "",
    deleted = "",
  },
}
vim.g.nvim_tree_root_folder_modifier = ":t"

local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
  return
end

nnoremap("<leader>e", "<cmd>NvimTreeToggle<CR>", "Explorer")

local action = nvim_tree_config.nvim_tree_callback

nvim_tree.setup {
  open_on_setup = true,
  ignore_ft_on_setup = {
    "startify",
    "dashboard",
    "alpha",
  },
  diagnostics = {
    enable = true,
  },
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  filters = {
    custom = { "__pycache__" },
  },
  view = {
    auto_resize = true,
    mappings = {
      custom_only = false,
      list = {
        { key = { "l", "<CR>", "o" }, cb = action "edit" },
        { key = "h", cb = action "close_node" },
        { key = "v", cb = action "vsplit" },
      },
    },
  },
}
