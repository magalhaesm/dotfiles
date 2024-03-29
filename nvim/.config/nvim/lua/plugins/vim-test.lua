return {
  'vim-test/vim-test',
  dependencies = {
    'preservim/vimux',
  },
  config = function()
    vim.cmd([[let test#strategy = "vimux"]])
  end,
  keys = {
    {
      '<leader>tn',
      '<cmd>TestNearest<CR>',
      desc = '[T]est [N]earest to the cursor',
    },
    {
      '<leader>tf',
      '<cmd>TestFile<CR>',
      desc = '[T]est the whole [F]ile',
    },
    {
      '<leader>ts',
      '<cmd>TestSuite<CR>',
      desc = 'Run the whole [T]est [S]uite',
    },
    {
      '<leader>tl',
      '<cmd>TestLast<CR>',
      desc = 'Run the [L]ast [T]est',
    },
  },
}
