local present, icons = pcall(require, "nvim-web-devicons")
if not present then
  return
end

local colors = vim.g.dracula
if not colors then
  return
end

icons.setup {
  override = {
    html = {
      icon = "",
      color = "#e34c26",
      name = "html",
    },
    css = {
      icon = "",
      color = "#563d7c",
      name = "css",
    },
    js = {
      icon = "",
      color = "#cbcb41",
      name = "js",
    },
    ts = {
      icon = "ﯤ",
      color = "#519aba",
      name = "ts",
    },
    db = {
      color = "#ffca28",
      icon = "",
      name = "Db",
    },
    ["sh"] = {
      icon = "",
      color = "#89e051",
      name = "Sh",
    },
    [".gitignore"] = {
      color = colors.red,
      icon = "",
      name = "GitIgnore",
    },
    [".flake8"] = {
      color = "#42a5f5",
      icon = "",
      name = "Flake8",
    },
    [".pylintrc"] = {
      color = "#42a5f5",
      icon = "",
      name = "Pylint",
    },
    [".pre-commit-config.yaml"] = {
      -- color = "#ef4235",
      color = colors.bright_red,
      icon = "",
      name = "PreCommit",
    },
    ["zshrc"] = {
      icon = "",
      color = "#89e051",
      name = "Zshrc",
    },
    ["requirements.txt"] = {
      icon = "",
      color = "#89e051",
      name = "Requirements",
    },
  },
}
