-- local colorscheme = "darkplus"
local colorscheme = "monokai"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("Colorscheme " .. colorscheme .. " not found!")
  return
end

local monokai = require('monokai')
local palette = monokai

monokai.setup {
  custom_hlgroups = {
    GitSignsChange = {
      bg = palette.base2
    },
  },
}

-- BUG: não aplica custom_hlgroups em todos os arquivos
vim.cmd [[ hi link GitSignsChange Normal ]]
