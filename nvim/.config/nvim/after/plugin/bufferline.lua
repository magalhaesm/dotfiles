local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
  return
end

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
      fg = "#222426",
      bg = "#222426",
    },
    separator_selected = {
      fg = "#222426",
    },
    separator_visible = {
      fg = "#222426",
      bg = "#272a30",
    },
    buffer_visible = {
      bg = "#272a30",
    },
    background = {
      fg = "#a1b5b1",
      bg = "#222426",
    },
    fill = {
      bg = "#222426",
    },
  },
}
