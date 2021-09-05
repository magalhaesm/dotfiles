-------------------------------------------------------------------------------
--  MAPEAMENTOS:
-------------------------------------------------------------------------------

local nnoremap = mm.nnoremap
local vnoremap = mm.vnoremap
local inoremap = mm.inoremap
local cnoremap = mm.cnoremap

-- Sair do modo inserção
inoremap("kj", "<ESC>`^")

nnoremap("<leader>;", "A;<ESC>")

-- Y copia até o fim da linha
nnoremap("Y", "y$")

-- Seleciona a linha sob o cursor
nnoremap("vv", "V")

-- Navegação entre telas: espaço + direção
nnoremap("<leader>h", "<cmd>wincmd h<CR>")
nnoremap("<leader>l", "<cmd>wincmd l<CR>")
nnoremap("<leader>j", "<cmd>wincmd j<CR>")
nnoremap("<leader>k", "<cmd>wincmd k<CR>")

-- Dividir tela: horizontal e vertical
nnoremap("<leader>H", "<cmd>split<CR>")
nnoremap("<leader>v", "<cmd>vsplit<CR>")

-- Apagar o destaque dos termos de busca
nnoremap("<ESC><ESC>", "<cmd>nohl<CR>")

-- Navegação entre Buffers
nnoremap("<C-l>", "<cmd>bnext<CR>")
nnoremap("<C-h>", "<cmd>bprevious<CR>")

-- Navegar entre linhas em branco
nnoremap("<C-p>", "{")
nnoremap("<C-n>", "}")

-- Ratacionar janelas
nnoremap("<leader>rh", "<C-w>t<C-w>H")
nnoremap("<leader>rv", "<C-w>t<C-w>K")

-- Teclas direcionais para redimensionar janelas (modo normal)
nnoremap("<A-up>", "<cmd>resize -2<CR>")
nnoremap("<A-down>", "<cmd>resize +2<CR>")
nnoremap("<A-left>", "<cmd>vertical resize +2<CR>")
nnoremap("<A-right>", "<cmd>vertical resize -2<CR>")

-- Mover linhas
vnoremap("<A-k>", ":m '<-2<CR>gv=gv")
vnoremap("<A-j>", ":m '>+1<CR>gv=gv")
nnoremap("<A-k>", ":m .-2<CR>==")
nnoremap("<A-j>", ":m .+1<CR>==")

-- MODO COMANDO --
cnoremap("<C-h>", "<Left>")
cnoremap("<C-l>", "<Right>")
cnoremap("<C-a>", "<Home>")
cnoremap("<C-e>", "<End>")
cnoremap("<C-d>", "<Del>")
cnoremap("<C-b>", "<BS>")
cnoremap("<C-t>", [[<C-R>=expand("%:p:h") . "/" <CR>]])

-- FIXME: Mantêm o cursor centralizado
-- nnoremap("n", "nzzzv")
-- nnoremap("N", "Nzzzv")
-- nnoremap("J", "mzJ`z")
-- ["n|n"] = map_cmd("nzzzv"):noremap(),
-- ["n|N"] = map_cmd("Nzzzv"):noremap(),
-- ["n|J"] = map_cmd("mzJ`z"):noremap(),

-- Move o cursor para início/final da linha
nnoremap("<A-h>", "^")
nnoremap("<A-l>", "$")

-- Encontra o par
nnoremap("<A-n>", "%")
nnoremap("<A-p>", "%")

nnoremap("]q", "<cmd>cnext<CR>")
nnoremap("[q", "<cmd>cprev<CR>")
nnoremap("]l", "<cmd>lnext<CR>")
nnoremap("[l", "<cmd>lprev<CR>")
