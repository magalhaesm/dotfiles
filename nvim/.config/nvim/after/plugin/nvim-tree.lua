local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
  return
end

nnoremap("<leader>e", "<cmd>NvimTreeToggle<CR>", "Explorer")
nnoremap("<leader>E", "<cmd>NvimTreeRefresh<CR>", "Refresh Explorer")

local action = nvim_tree_config.nvim_tree_callback

nvim_tree.setup {
  renderer = {
    root_folder_modifier = ":t",
    icons = {
      glyphs = {
        git = {
          unstaged = "",
          staged = "",
          unmerged = "",
          renamed = "",
          untracked = "",
          deleted = "",
        },
      },
    },
  },
  auto_reload_on_write = true,
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
