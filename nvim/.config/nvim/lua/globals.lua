-------------------------------------------------------------------------------
--  GLOBALS:
-------------------------------------------------------------------------------

_G.mm = {
  DATA_PATH = vim.fn.stdpath "data",
  CONFIG_PATH = vim.fn.stdpath "config",
  TERMINAL_THEME = os.getenv "TERMINAL_THEME",
}

local fn = vim.fn
local cmd = vim.cmd

---Limpa todos os registradores
function _G.WipeRegisters()
  local regs = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"'
  for reg in string.gmatch(regs, "[%w%p]") do
    vim.fn.setreg(reg, "")
  end
  print "Registradores limpos!"
end

vim.cmd "command -nargs=0 WipeRegisters lua WipeRegisters()"

function _G.inspect(...)
  local objects = vim.tbl_map(vim.inspect, { ... })
  print(unpack(objects))
end

function mm.replace_termcodes(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function mm.check_back_space()
  local col = fn.col "." - 1
  if col == 0 or fn.getline("."):sub(col, col):match "%s" then
    return true
  else
    return false
  end
end

local function validate_lhs(mode, lhs)
  assert(lhs ~= mode, string.format("The lhs should not be the same as mode for %s", lhs))
end

local function validate_rhs(rhs)
  assert(type(rhs) == "string" or type(rhs) == "function", '"rhs" should be a function or string')
end

local function merge_options(custom, default)
  return custom and vim.tbl_extend("keep", custom, default) or {}
end

local function extract_bufnr(options)
  local bufnr = options.buffer
  options.buffer = nil
  return bufnr
end

local function make_mapper(mode, default_opts)
  return function(lhs, rhs, opts)
    validate_lhs(mode, lhs)
    validate_rhs(rhs)

    opts = merge_options(opts, default_opts)

    local bufnr = extract_bufnr(opts)
    if bufnr then
      vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
    else
      vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
    end
  end
end

local map_opts = { noremap = false, silent = true }
local noremap_opts = { noremap = true, silent = true }

mm.nmap = make_mapper("n", map_opts)
mm.xmap = make_mapper("x", map_opts)
mm.imap = make_mapper("i", map_opts)
mm.vmap = make_mapper("v", map_opts)
mm.omap = make_mapper("o", map_opts)
mm.tmap = make_mapper("t", map_opts)
mm.smap = make_mapper("s", map_opts)
mm.cmap = make_mapper("c", { noremap = false, silent = false })

mm.nnoremap = make_mapper("n", noremap_opts)
mm.xnoremap = make_mapper("x", noremap_opts)
mm.vnoremap = make_mapper("v", noremap_opts)
mm.inoremap = make_mapper("i", noremap_opts)
mm.onoremap = make_mapper("o", noremap_opts)
mm.tnoremap = make_mapper("t", noremap_opts)
mm.snoremap = make_mapper("s", noremap_opts)
mm.cnoremap = make_mapper("c", { noremap = true, silent = false })

-- TODO: really need this?
-- https://github.com/ojroques/nvim-bufdel
function mm.delete_buffer()
  local buflisted = fn.getbufinfo { buflisted = 1 }
  local cur_winnr, cur_bufnr = fn.winnr(), fn.bufnr()
  if #buflisted < 2 then
    cmd "confirm qall"
    return
  end
  for _, winid in ipairs(fn.getbufinfo(cur_bufnr)[1].windows) do
    cmd(string.format("%d wincmd w", fn.win_id2win(winid)))
    cmd(cur_bufnr == buflisted[#buflisted].bufnr and "bp" or "bn")
  end
  cmd(string.format("%d wincmd w", cur_winnr))
  local is_terminal = fn.getbufvar(cur_bufnr, "&buftype") == "terminal"
  cmd(is_terminal and "bd! #" or "silent! confirm bd #")
end
