local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

vim.opt.completeopt = { "menu", "menuone", "noselect" }

require("luasnip/loaders/from_vscode").lazy_load()

local ctrl_n = function(_)
  if luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  elseif cmp.visible() then
    cmp.select_next_item()
  end
end

local ctrl_p = function(_)
  if luasnip.jumpable(-1) then
    luasnip.jump(-1)
  elseif cmp.visible() then
    cmp.select_prev_item()
  end
end

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  completion = { keyword_length = 1 },
  mapping = {
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-e>"] = cmp.mapping.close(),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm { select = false },
    ["<C-n>"] = cmp.mapping(ctrl_n, { "i", "s" }),
    ["<C-p>"] = cmp.mapping(ctrl_p, { "i", "s" }),
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format("%s", mm.lsp.kind_icons[vim_item.kind])
      -- Source
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        nvim_lua = "[Lua]",
        luasnip = "[LuaSnip]",
        buffer = "[Buffer]",
        path = "[Path]",
      })[entry.source.name]
      return vim_item
    end,
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip", keyword_length = 1 },
    { name = "buffer", option = { keyword_pattern = [[\k\+]] } },
    { name = "path" },
    { name = "nvim_lua" },
    { name = "neorg" },
  },
  window = {
    documentation = cmp.config.window.bordered(),
    --[[ completion = cmp.config.window.bordered(), ]]
  },
}
