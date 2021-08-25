local config = {
  options = {
    offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
    buffer_close_icon = "",
    modified_icon = "",
    close_icon = "",
    left_trunc_marker = "",
    right_trunc_marker = "",
    max_name_length = 14,
    max_prefix_length = 13,
    tab_size = 20,
    show_tab_indicators = true,
    enforce_regular_tabs = false,
    view = "multiwindow",
    show_buffer_close_icons = true,
    separator_style = "thin",
    -- mappings = true,  -- deprecated
    always_show_bufferline = true,
  },
}

local palette = vim.g[vim.g.colors_name]
if palette then
  config["highlights"] = {
    fill = {
      guibg = palette.black,
    },
    indicator_selected = {
      guifg = palette.green,
    },
    separator = {
      guifg = palette.selection,
    },
    buffer_selected = {
      gui = "bold",
    },
  }
end

require("bufferline").setup(config)
