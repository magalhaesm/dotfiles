local present, icons = pcall(require, "nvim-web-devicons")
if not present then
  return
end

icons.setup {
  override = {
    norg = {
      icon = "",
      color = "#5cbc7e",
      name = "norg",
    },
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
      icon = "",
      color = "#519aba",
      name = "ts",
    },
    db = {
      icon = "",
      color = "#ffca28",
      name = "Db",
    },
    ["sh"] = {
      icon = "",
      color = "#89e051",
      name = "Sh",
    },
    [".gitignore"] = {
      icon = "",
      color = "#e64a19",
      name = "GitIgnore",
    },
    [".flake8"] = {
      icon = "",
      color = "#42a5f5",
      name = "Flake8",
    },
    [".pylintrc"] = {
      icon = "",
      color = "#42a5f5",
      name = "Pylint",
    },
    [".pre-commit-config.yaml"] = {
      icon = "",
      color = "#ff5252",
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
