return {
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    events = { 'BufferEnter' },
    opts = {
      indent = {
        -- char = '┊',
        char = '│',
      },
      scope = {
        enabled = false,
        show_start = false,
        show_end = false,
      },
    },
  },
}
