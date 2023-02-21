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
}
