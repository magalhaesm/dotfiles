local ok, mapx = pcall(require, "mapx")
if not ok then
  return
end

-- NOTE: keymaps with labels are added to which-key
mapx.setup { whichkey = true }

_G.nnoremap = mapx.nnoremap
_G.inoremap = mapx.inoremap
_G.xnoremap = mapx.xnoremap
_G.cnoremap = mapx.cnoremap
_G.onoremap = mapx.onoremap
_G.vnoremap = mapx.vnoremap

_G.map = mapx
_G.cmd = mapx.cmd

local opts = { silent = true }

-- Save, quit and close
nnoremap("<leader>w", "<cmd>w!<CR>", "Save")
nnoremap("<leader>q", "<cmd>q!<CR>", "Quit")
nnoremap("<leader>c", "<cmd>Bdelete!<CR>", "Close buffer")

-- Window navigation
nnoremap("<C-h>", "<C-w>h")
nnoremap("<C-j>", "<C-w>j")
nnoremap("<C-k>", "<C-w>k")
nnoremap("<C-l>", "<C-w>l")

-- Resize windows
nnoremap("<C-Up>", "<cmd>resize -2<CR>")
nnoremap("<C-Down>", "<cmd>resize +2<CR>")
nnoremap("<C-Left>", "<cmd>vertical resize -2<CR>")
nnoremap("<C-Right>", "<cmd>vertical resize +2<CR>")

-- Buffer navigation
nnoremap("L", "<cmd>bnext<CR>")
nnoremap("H", "<cmd>bprevious<CR>")

-- Move cursor to the first/last character of the line
nnoremap("<A-h>", "0")
nnoremap("<A-l>", "$")

-- Turn off highlight
nnoremap("<BS>", "<cmd>nohlsearch<CR>")

-- Exit insert mode
inoremap("kj", "<ESC>")

-- Shift highlighted lines
xnoremap(">", ">gv")
xnoremap("<", "<gv")

-- Move lines up and down
nnoremap("<A-j>", "<cmd>m .+1<CR>==")
nnoremap("<A-k>", "<cmd>m .-2<CR>==")
xnoremap("<A-j>", ":move '>+1<CR>gv-gv", opts)
xnoremap("<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Select all
onoremap("ae", ":normal! ggVG<CR>", opts)
vnoremap("ae", ":normal! ggVG<CR>", opts)

-- Quickfix
nnoremap("]q", "<cmd>cnext<CR>zz", "Quickfix: next")
nnoremap("[q", "<cmd>cprev<CR>zz", "Quickfix: prev")
nnoremap("]l", "<cmd>lnext<cr>zz", "Loclist: next")
nnoremap("[l", "<cmd>lprev<cr>zz", "Loclist: prev")

-- Paste on command line
cnoremap("<C-v>", "<C-r>+")

-- Split window
nnoremap("<leader>ss", "<cmd>split<CR>")
nnoremap("<leader>sv", "<cmd>vsplit<CR>")

xnoremap("<leader>p", "\"_dP");
inoremap("<C-l>", "<Right>")
inoremap("<C-h>", "<Left>")
