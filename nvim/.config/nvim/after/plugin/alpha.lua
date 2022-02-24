local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local dashboard = require "alpha.themes.dashboard"
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
  dashboard.button("f", "  Find file", ":lua mm.search_files()<CR>"),
  dashboard.button("r", "  Recently used files", ":Telescope oldfiles<CR>"),
  dashboard.button("e", "  New file", ":ene <BAR> startinsert<CR>"),
  dashboard.button("t", "  Find text", ":Telescope live_grep<CR>"),
  dashboard.button("p", "  Find project", ":Telescope projects<CR>"),
  dashboard.button("c", "  Configuration", ":lua mm.edit_nvim()<CR>"),
  dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
}

local start_pack = DATA_HOME .. "/nvim/site/pack/packer/start"
local plugins_count = vim.fn.len(vim.fn.globpath(start_pack, "*", 0, 1))
dashboard.section.footer.val = {
  plugins_count .. " plugins loaded ",
}
-- dashboard.section.header.opts.hl = "Include"
-- dashboard.section.buttons.opts.hl = "Type"

dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)

nnoremap("<Leader>a", "<Cmd>Alpha<CR>", "Alpha")
