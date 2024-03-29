return {
  {
    'akinsho/bufferline.nvim',
    enabled = false,
    event = 'VeryLazy',
    keys = {
      { '<S-h>', '<cmd>BufferLineCyclePrev<CR>' },
      { '<S-l>', '<cmd>BufferLineCycleNext<CR>' },
    },
    opts = {
      options = {
        modified_icon = '',
        show_close_icon = false,
        show_buffer_close_icons = false,
        close_icon = '',
        separator_style = 'slant',
        offsets = {
          {
            filetype = 'neo-tree',
            text = ' Explorer',
            highlight = 'PanelHeading',
            padding = 1,
          },
        },
      },
    },
  },
}
