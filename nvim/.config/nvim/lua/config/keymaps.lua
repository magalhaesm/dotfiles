local map = vim.keymap.set

-- Save and Quit mappings
map('n', '<leader>w', '<cmd>w!<CR>', { desc = 'Save' })
map('n', '<leader>q', '<cmd>q!<CR>', { desc = 'Quit' })

-- Use CTRL+<hjkl> to switch between windows
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- Use tab to move between buffers
map('n', '<tab>', '<cmd>bprev<CR>')
map('n', '<s-tab>', '<cmd>bnext<CR>')

-- Jump to beginning and end of line mappings
map('n', '<A-h>', '^')
map('n', '<A-l>', '$')

-- Use <BS> to turn off the highlight
map('n', '<BS>', '<cmd>nohlsearch<CR>')

-- Use 'kj' to exit insert mode
map('i', 'kj', '<ESC>')

-- Move lines
map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")

-- Select all
map('v', 'ae', ':normal! ggVG<CR>', { desc = 'Select all lines in visual mode' })

-- Quickfix mappings
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous [D]iagnostic' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Next [D]iagnostic' })
map('n', 'gl', vim.diagnostic.open_float, { desc = '[L]ine Diagnostic' })
map('n', 'Q', vim.diagnostic.setqflist, { desc = '[Q]uickfix List' })
map('n', '[q', '<cmd>cprev<CR>', { desc = 'Previous [Q]uickfix List' })
map('n', ']q', '<cmd>cnext<CR>', { desc = 'Next [Q]uickfix List' })

-- Paste over currently selected text without yanking it
map('v', 'p', '"_dP')

-- Paste on command line mapping
map('c', '<C-v>', '<C-r>+')

-- Move cursor right and left in insert mode mappings
map('i', '<C-l>', '<Right>')
map('i', '<C-h>', '<Left>')
