local autocmd = vim.api.nvim_create_autocmd
local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

-- Highlight on yank
autocmd('TextYankPost', {
  group = augroup('highlight_yank'),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Resize splits if window got resized
autocmd({ 'VimResized' }, {
  group = augroup('resize_splits'),
  callback = function()
    vim.cmd('tabdo wincmd =')
  end,
})

-- Close some filetypes with <q>
autocmd('FileType', {
  group = augroup('close_with_q'),
  pattern = {
    'qf',
    'help',
    'man',
    'notify',
    'lspinfo',
    'spectre_panel',
    'startuptime',
    'tsplayground',
    'PlenaryTestPopup',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
})

-- Go to last loc when opening a buffer
autocmd('BufReadPost', {
  group = augroup('last_loc'),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

autocmd({ 'BufWritePre' }, {
  group = augroup('I_hate_trailing_whitespace'),
  pattern = '*',
  command = [[%s/\s\+$//e]],
})

autocmd('BufEnter', {
  group = augroup('set_c_filetype'),
  pattern = {
    '*.c',
    '*.h',
  },
  callback = function(event)
    vim.bo[event.buf].filetype = 'c'
  end,
})

-- autocmd({ 'BufEnter' }, {
--   group = augroup('semicolon'),
--   pattern = {
--     '*.c',
--     '*.h',
--     '*.hpp',
--     '*.cpp',
--     '*.rs',
--   },
--   callback = function(event)
--     vim.keymap.set('n', '<leader>;', 'A;<ESC>', {
--       buffer = event.buf,
--       desc = 'Insert semicolon at the end of line',
--     })
--   end,
-- })
