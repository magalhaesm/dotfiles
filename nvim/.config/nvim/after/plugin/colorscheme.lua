-- local colorscheme = "darkplus"
local colorscheme = "monokai"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("Colorscheme " .. colorscheme .. " not found!")
  return
end

local ok, monokai = pcall(require, "monokai")
if ok then
  local palette = monokai.classic

  monokai.setup {
    custom_hlgroups = {
      GitSignsChange = {
        fg = palette.yellow,
        bg = palette.base2,
      },
      TelescopeNormal = {
        bg = palette.base2,
      },
      TSNote = {
        fg = palette.aqua,
        style = "bold",
      },
      TSWarning = {
        fg = palette.orange,
        style = "bold",
      },
      TSDanger = {
        fg = palette.pink,
        style = "bold",
      },
    },
  }
end
