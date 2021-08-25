local present1, gl = pcall(require, "galaxyline")
local present2, condition = pcall(require, "galaxyline.condition")
if not (present1 or present2) then
  return
end

local gls = gl.section

gl.short_line_list = { " " }

-- local global_theme = "themes/" .. vim.g.nvchad_theme
-- local colors = require(global_theme)
local colors = vim.g.dracula

gls.left[1] = {
  FirstElement = {
    provider = function()
      return "▋"
    end,
    highlight = { colors.bright_black, colors.black },
  },
}

gls.left[2] = {
  statusIcon = {
    provider = function()
      return "  "
    end,
    highlight = { colors.black, colors.black },
    separator = "  ",
    separator_highlight = { colors.black, colors.selection },
  },
}

gls.left[3] = {
  FileIcon = {
    provider = "FileIcon",
    condition = condition.buffer_not_empty,
    highlight = { colors.foreground, colors.selection },
  },
}

gls.left[4] = {
  FileName = {
    provider = { "FileName" },
    condition = condition.buffer_not_empty,
    highlight = { colors.white, colors.selection },
    separator = " ",
    separator_highlight = { colors.selection, colors.black },
  },
}

gls.left[5] = {
  current_dir = {
    provider = function()
      local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
      return "  " .. dir_name .. " "
    end,
    highlight = { colors.selection, colors.yellow },
    separator = " ",
    separator_highlight = { colors.bright_gray, colors.bright_black },
  },
}

local checkwidth = function()
  local squeeze_width = vim.fn.winwidth(0) / 2
  if squeeze_width > 30 then
    return true
  end
  return false
end

gls.left[6] = {
  DiffAdd = {
    provider = "DiffAdd",
    condition = checkwidth,
    icon = "  ",
    highlight = { colors.foreground, colors.bright_black },
  },
}

gls.left[7] = {
  DiffModified = {
    provider = "DiffModified",
    condition = checkwidth,
    icon = "   ",
    highlight = { colors.bright_gray, colors.bright_black },
  },
}

gls.left[8] = {
  DiffRemove = {
    provider = "DiffRemove",
    condition = checkwidth,
    icon = "  ",
    highlight = { colors.bright_gray, colors.bright_black },
  },
}

gls.left[9] = {
  DiagnosticError = {
    provider = "DiagnosticError",
    icon = "  ",
    highlight = { colors.red, colors.bright_black },
  },
}

gls.left[10] = {
  DiagnosticWarn = {
    provider = "DiagnosticWarn",
    icon = "  ",
    highlight = { colors.yellow, colors.bright_black },
  },
}

gls.right[1] = {
  lsp_status = {
    provider = function()
      local clients = vim.lsp.get_active_clients()
      if next(clients) ~= nil then
        return " " .. "  " .. " LSP "
      else
        return ""
      end
    end,
    highlight = { colors.selection, colors.bright_black },
  },
}

gls.right[2] = {
  GitIcon = {
    provider = function()
      return " "
    end,
    condition = require("galaxyline.condition").check_git_workspace,
    highlight = { colors.selection, colors.bright_black },
    separator = " ",
    separator_highlight = { colors.bright_black, colors.bright_black },
  },
}

gls.right[3] = {
  GitBranch = {
    provider = "GitBranch",
    condition = require("galaxyline.condition").check_git_workspace,
    highlight = { colors.selection, colors.bright_black },
  },
}

gls.right[4] = {
  viMode_icon = {
    provider = function()
      return " "
    end,
    highlight = { colors.bright_black, colors.red },
    separator = " ",
    separator_highlight = { colors.red, colors.bright_black },
  },
}

gls.right[5] = {
  ViMode = {
    provider = function()
      local alias = {
        n = "Normal",
        i = "Insert",
        c = "Command",
        V = "Visual",
        [""] = "Visual",
        v = "Visual",
        R = "Replace",
      }
      local current_Mode = alias[vim.fn.mode()]

      if current_Mode == nil then
        return "  Terminal "
      else
        return "  " .. current_Mode .. " "
      end
    end,
    highlight = { colors.red, colors.selection },
  },
}

gls.right[6] = {
  some_icon = {
    provider = function()
      return " "
    end,
    separator = "",
    separator_highlight = { colors.green, colors.selection },
    highlight = { colors.selection, colors.green },
  },
}

gls.right[7] = {
  line_percentage = {
    provider = function()
      local current_line = vim.fn.line "."
      local total_line = vim.fn.line "$"

      if current_line == 1 then
        return "  Top "
      elseif current_line == vim.fn.line "$" then
        return "  Bot "
      end
      local result, _ = math.modf((current_line / total_line) * 100)
      return "  " .. result .. "% "
    end,
    highlight = { colors.green, colors.selection },
  },
}
