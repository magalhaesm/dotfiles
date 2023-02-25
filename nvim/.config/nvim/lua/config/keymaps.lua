local map = vim.keymap.set
local opts = { silent = true }

map("n", "<leader>w", "<cmd>w!<CR>", { desc = "Save" })
map("n", "<leader>q", "<cmd>q!<CR>", { desc = "Quit" })

map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Resize windows
map("n", "<C-Up>", "<cmd>resize -2<CR>")
map("n", "<C-Down>", "<cmd>resize +2<CR>")
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>")
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>")

-- Buffer navigation
map("n", "<S-l>", "<cmd>bnext<CR>")
map("n", "<S-h>", "<cmd>bprevious<CR>")

-- Move cursor to the first/last character of the line
map("n", "<A-h>", "0")
map("n", "<A-l>", "$")

-- Turn off highlight
map("n", "<BS>", "<cmd>nohlsearch<CR>")

-- Exit insert mode
map("i", "kj", "<ESC>")

-- Shift highlighted lines
map("x", ">", ">gv")
map("x", "<", "<gv")

-- Move lines up and down
map("n", "<A-j>", "<cmd>m .+1<CR>==")
map("n", "<A-k>", "<cmd>m .-2<CR>==")
map("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
map("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Select all
map("o", "ae", ":normal! ggVG<CR>", opts)
map("v", "ae", ":normal! ggVG<CR>", opts)

-- Quickfix
map("n", "]q", "<cmd>cnext<CR>zz", { desc = "Quickfix: next" })
map("n", "[q", "<cmd>cprev<CR>zz", { desc = "Quickfix: prev" })
map("n", "]l", "<cmd>lnext<cr>zz", { desc = "Loclist: next" })
map("n", "[l", "<cmd>lprev<cr>zz", { desc = "Loclist: prev" })

-- Paste on command line
map("c", "<C-v>", "<C-r>+")

-- Split window
map("n", "<leader>ss", "<cmd>split<CR>")
map("n", "<leader>sv", "<cmd>vsplit<CR>")

map("x", "<leader>p", '"_dP')
map("i", "<C-l>", "<Right>")
map("i", "<C-h>", "<Left>")
