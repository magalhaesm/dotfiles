local map = vim.keymap.set
local opts = { silent = true }

-- Save and Quit mappings
map('n', '<leader>w', '<cmd>w!<cr>', { desc = 'Save' })
map('n', '<leader>q', '<cmd>q!<cr>', { desc = 'Quit' })

-- Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
map('n', '<C-h>', '<C-w>h', { desc = 'Move to the left window' })
map('n', '<C-j>', '<C-w>j', { desc = 'Move to the lower window' })
map('n', '<C-k>', '<C-w>k', { desc = 'Move to the upper window' })
map('n', '<C-l>', '<C-w>l', { desc = 'Move to the right window' })

-- Use CTRL+arrows to resize windows
map('n', '<C-Up>', '<cmd>resize -2<cr>', { desc = 'Decrease height' })
map('n', '<C-Down>', '<cmd>resize +2<cr>', { desc = 'Increase height' })
map('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease width' })
map('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase width' })

-- Use SHIFT+<hl> to move between buffers
-- map('n', '<S-h>', '<cmd>bprev<cr>', { desc = 'Go to previous buffer' })
-- map('n', '<S-l>', '<cmd>bnext<cr>', { desc = 'Go to next buffer' })

-- Jump to beginning and end of line mappings
map('n', '<A-h>', '^', { desc = 'Move to the beginning of the line' })
map('n', '<A-l>', '$', { desc = 'Move to the end of the line' })

-- Use <BS> to turn off the highlight
map('n', '<BS>', '<cmd>nohlsearch<cr>', { desc = 'Turn off the highlight' })

-- Use 'kj' to exit insert mode
map('i', 'kj', '<ESC>', { desc = 'Exit insert mode' })

-- Press '>' and '<' to shift lines
map('x', '>', '>gv', { desc = 'Shift lines to the right' })
map('x', '<', '<gv', { desc = 'Shift lines to the left' })

-- Use ALT+<jk> to move lines
map('n', '<A-j>', '<cmd>m .+1<cr>==')
map('n', '<A-k>', '<cmd>m .-2<cr>==')
map('x', '<A-j>', ":move '>+1<cr>gv-gv", opts)
map('x', '<A-k>', ":move '<-2<cr>gv-gv", opts)

-- Select all
map('o', 'ae', ':normal! ggVG<cr>', opts)
map('v', 'ae', ':normal! ggVG<cr>', opts)

-- Quickfix mappings
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous [D]iagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next [D]iagnostic' })
vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = '[L]ine Diagnostic' })
vim.keymap.set('n', '<leader>Q', vim.diagnostic.setloclist, { desc = '[Q]uickfix List' })

-- Paste on command line mapping
map('c', '<C-v>', '<C-r>+', { desc = 'Paste on command line' })

-- Move cursor right and left in insert mode mappings
map('i', '<C-l>', '<Right>', { desc = 'Move cursor right' })
map('i', '<C-h>', '<Left>', { desc = 'Move cursor left' })
