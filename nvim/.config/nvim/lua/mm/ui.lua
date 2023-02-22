local ok, todo = pcall(require, "todo-comments")
if not ok then
  return
end
todo.setup {
  gui_style = {
    fg = "BOLD", -- The gui style to use for the fg highlight group.
    bg = "NONE", -- The gui style to use for the bg highlight group.
  },
  highlight = {
      before = "", -- "fg" or "bg" or empty
      keyword = "fg", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
      after = "", -- "fg" or "bg" or empty
    },
}
