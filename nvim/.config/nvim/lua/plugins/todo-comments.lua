require("todo-comments").setup {
  signs = true, -- show icons in the signs column
  keywords = {
    FIX = {
      icon = " ", -- icon used for the sign, and in search results
      color = "error", -- can be a hex color, or a named color (see below)
      alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
      -- signs = false, -- configure signs for some keywords individually
    },
    TODO = { icon = " ", color = "default" },
    HACK = { icon = " ", color = "warning" },
    WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
    PERF = { icon = " ", color = "default", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
    NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
  },
  highlight = {
    before = "", -- "fg" or "bg" or empty
    keyword = "fg", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
    after = "", -- "fg" or "bg" or empty
    exclude = { "org", "orgagenda", "vimwiki", "markdown" },
  },

  colors = {
    default = { "Todo" },
    hint = { "LspDiagnosticsDefaultHint" },
    info = { "LspDiagnosticsDefaultInformation" },
    error = { "LspDiagnosticsDefaultError", "ErrorMsg" },
    warning = { "LspDiagnosticsDefaultWarning", "WarningMsg" },
  },
}
