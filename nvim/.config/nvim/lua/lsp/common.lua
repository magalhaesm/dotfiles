mm.lsp = {
  diagnostic_opts = {
    virtual_text = {
      prefix = "",
      spacing = 3,
    },
    signs = true,
    underline = true,
    update_in_insert = false,
  },

  signs = {
    Error = "",
    Hint = "",
    Information = "",
    Warning = "",
  },

  popup_opts = {
    show_header = false,
    border = "single",
    focusable = false, -- on diagnostic popups
  },

  item_kind = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "",
    Interface = "ﰮ",
    Module = "",
    Property = "",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "﬌",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "ﬦ",
    TypeParameter = "",
  },
  --[[
  signs = {
  Error = "",
  Hint = "",
  Information = "",
  Warning = "",
  },
  --]]
}
