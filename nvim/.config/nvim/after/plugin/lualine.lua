local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local hide_in_width = function()
  return vim.fn.winwidth(0) > 70
end

local function lsp_active()
  local clients = vim.lsp.get_active_clients()
  if next(clients) == nil then
    return ""
  end
  return ""
end

---Return python virtual env
---@return string
local function python_env()
  if vim.bo.filetype == "python" then
    local venv = os.getenv("VIRTUAL_ENV")
    if venv ~= nil then
      return string.format("  (%s)", mm.basename(venv))
    end
    return ""
  end
  return ""
end

local function position()
  return "☰ %3l/%-3L ln :%3v "
end

local filename = {
  "filename",
  symbols = { modified = "  ", readonly = "  " },
}

local diff = {
  "diff",
  colored = true,
  symbols = { added = " ", modified = " ", removed = " " },
  -- symbols = { added = " ", modified = " ", removed = " " },
  cond = hide_in_width,
}

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  symbols = { error = " ", warn = " ", info = " ", hint = " " },
}

lualine.setup({
  options = {
    icons_enabled = true,
    -- theme = "codedark",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = { filename, diff, python_env },
    lualine_x = { diagnostics, lsp_active, "filetype" },
    lualine_y = { "progress" },
    lualine_z = { position },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  extensions = {},
})
