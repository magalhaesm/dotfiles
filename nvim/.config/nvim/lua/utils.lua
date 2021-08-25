--[[
function utils.check_lsp_client_active(name)
  local clients = vim.lsp.get_active_clients()
  for _, client in pairs(clients) do
    if client.name == name then
      return true
    end
  end
  return false
end
--]]

--this is a **valid** comment
---this is *also* valid and on a newline
---
--- this is a new paragraph
--- [Click me](https://www.google.com/)
--- ```
--- for i, v in ipairs(tbl) do
---   -- do stuff
--- end
--- ```
--- - item 1
---   - level 2
---@param tbl table comment for `tbl`
function _G.teste(tbl)
  print(type(tbl))
end

local fn = vim.fn
local cmd = vim.cmd

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

-- return utils
