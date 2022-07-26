local status_ok, npairs = pcall(require, "nvim-autopairs")
if not status_ok then
  return
end

npairs.setup {
  check_ts = false,
  fast_wrap = {
    map = "<M-e>",
    check_comma = true,
    -- highlight = "PmenuSel",
    -- highlight_grey = "LineNr",
  },
  close_triple_quotes = true,
}

local cmp_autopairs = require "nvim-autopairs.completion.cmp"
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })
