local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
  return
end

bufferline.setup {
  options = {
    numbers = "none",
    middle_mouse_command = nil,
    indicator_icon = "▎",
    modified_icon = "",
    show_close_icon = false,
    close_icon = "",
    tab_size = 21,
    diagnostics_update_in_insert = false,
    offsets = {
      { filetype = "NvimTree", text = " Explorer", highlight = "PanelHeading", padding = 1 },
    },
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_tab_indicators = true,
    persist_buffer_sort = true,
    separator_style = "thin",
    always_show_bufferline = true,
  },

  highlights = {
    fill = {
      guibg = { attribute = "bg", highlight = "TabLine" },
    },

    background = {
      guifg = { attribute = "fg", highlight = "Comment" },
      guibg = { attribute = "bg", highlight = "TabLine" },
    },

    pick = {
      guibg = { attribute = "bg", highlight = "Tabline" },
    },

    buffer_visible = {
      guibg = { attribute = "bg", highlight = "TabLine" },
    },

    close_button = {
      guifg = { attribute = "fg", highlight = "TabLine" },
      guibg = { attribute = "bg", highlight = "TabLine" },
    },
    close_button_visible = {
      guifg = { attribute = "fg", highlight = "TabLine" },
      guibg = { attribute = "bg", highlight = "TabLine" },
    },

    tab_close = {
      guifg = { attribute = "fg", highlight = "TabLineSel" },
      guibg = { attribute = "bg", highlight = "Normal" },
    },

    modified = {
      guifg = { attribute = "fg", highlight = "TabLine" },
      guibg = { attribute = "bg", highlight = "TabLine" },
    },

    separator = {
      guifg = { attribute = "fg", highlight = "EndOfBuffer" },
      guibg = { attribute = "bg", highlight = "TabLine" },
    },

    indicator_selected = {
      guifg = { attribute = "fg", highlight = "LspDiagnosticsDefaultHint" },
    },
  },
}
