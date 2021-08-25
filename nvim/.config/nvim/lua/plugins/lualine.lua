---------------------------------------------------------------------------------
--  Lualine:
---------------------------------------------------------------------------------

local M = {}

local function lsp_active()
  local clients = vim.lsp.get_active_clients()
  if next(clients) == nil then
    return ""
  end
  return ""
end

-- Cleanup Virtual Env
local function env_cleanup(venv)
  if string.find(venv, "/") then
    local final_venv = venv
    for w in venv:gmatch "([^/]+)" do
      final_venv = w
    end
    venv = final_venv
  end
  return venv
end

-- Return python virtual env
local function python_env()
  if vim.bo.filetype == "python" then
    local venv = os.getenv "CONDA_DEFAULT_ENV"
    if venv ~= nil then
      return "🅒 (" .. env_cleanup(venv) .. ")"
    end
    venv = os.getenv "VIRTUAL_ENV"
    if venv ~= nil then
      return "  (" .. env_cleanup(venv) .. ")"
    end
    return ""
  end
  return ""
end

local function position()
  return "  %3l/%-3L %3v "
end

-- local function clock()
--   return " " .. os.date("%H:%M")
-- end
--
M.settings = {
  options = {
    theme = "dracula",
    section_separators = { "", "" },
    component_separators = { "", "" },
    icons_enabled = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = {
      {
        "filename",
        symbols = { modified = "  ", readonly = "  " },
      },
      {
        "diff",
        symbols = { added = " ", modified = " ", removed = " " },
      },
      { python_env },
    },
    lualine_x = {
      {
        "diagnostics",
        sources = { "nvim_lsp" },
        symbols = { error = " ", warn = " ", info = " ", hint = " " },
      },
      {
        lsp_active,
      },
      "filetype",
    },
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
  extensions = { "nvim-tree" },
}

function M.config()
  local name = vim.g.colors_name or ""
  local ok, _ = pcall(require, "lualine.themes." .. name)
  if ok then
    M.settings.options.theme = name
  end
  require("lualine").setup(M.settings)
end

return M
