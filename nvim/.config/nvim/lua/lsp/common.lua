mm.lsp = {
  diagnostic_opts = {
    virtual_text = {
      prefix = "",
      spacing = 0,
    },
    signs = true,
    underline = true,
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
    " (Text)", -- Text
    " (Method)", -- Method
    " (Function)", -- Function
    " (Constructor)", -- Constructor
    " (Field)", -- Field
    " (Variable)", -- Variable
    " (Class)", -- Class
    "ﰮ (Interface)", -- Interface
    " (Module)", -- Module
    " (Property)", -- Property
    " (Unit)", -- Unit
    " (Value)", -- Value
    " (Enum)", -- Enum
    " (Keyword)", -- Keyword
    "﬌ (Snippet)", -- Snippet
    " (Color)", -- Color
    " (File)", -- File
    " (Reference)", -- Reference
    " (Folder)", -- Folder
    " (EnumMember)", -- EnumMember
    " (Constant)", -- Constant
    " (Struct)", -- Struct
    " (Event)", -- Event
    "ﬦ (Operator)", -- Operator
    " (TypeParameter)", -- TypeParameter
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
