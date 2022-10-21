local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
  return
end

local background = "#222426"

bufferline.setup {
  options = {
    modified_icon = "",
    show_close_icon = false,
    show_buffer_close_icons = false,
    close_icon = "",
    separator_style = "slant",
    offsets = {
      {
        filetype = "NvimTree",
        text = " Explorer",
        highlight = "PanelHeading",
        padding = 1,
      },
    },
  },
  highlights = {
    separator = {
      fg = background,
      bg = background,
    },
    separator_selected = {
      fg = background,
    },
    separator_visible = {
      fg = background,
      bg = "#272a30",
    },
    buffer_visible = {
      bg = "#272a30",
    },
    background = {
      fg = "#a1b5b1",
      bg = background,
    },
    modified = {
      bg = background,
    },
    fill = {
      bg = background,
    },
  },
}
