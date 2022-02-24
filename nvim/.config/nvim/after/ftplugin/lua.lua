vim.opt_local.formatoptions:remove "o"

------------------------------------------------------------------------------
-- Nvim Dev
------------------------------------------------------------------------------
local ok, _ = pcall(require, "mapx")
if not ok then
  return
end

local opts = { buffer = 0, silent = true }
nnoremap ("<localleader>t", "<Plug>PlenaryTestFile", "Run Test", opts)
