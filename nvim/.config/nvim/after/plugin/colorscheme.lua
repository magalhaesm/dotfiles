-- local colorscheme = "darkplus"
local colorscheme = "monokai"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("Colorscheme " .. colorscheme .. " not found!")
  return
end

local monokai = require "monokai"
local palette = monokai.classic

monokai.setup {
  custom_hlgroups = {
    GitSignsChange = {
      bg = palette.base2,
    },
    TelescopeNormal = {
      bg = palette.base2
    },
    Todo = {
      fg = palette.orange,
      style = "bold",
    },
  },
}
