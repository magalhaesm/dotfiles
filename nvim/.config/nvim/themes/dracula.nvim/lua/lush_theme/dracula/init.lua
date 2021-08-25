--
-- Built with,
--
--        ,gggg,
--       d8" "8I                         ,dPYb,
--       88  ,dP                         IP'`Yb
--    8888888P"                          I8  8I
--       88                              I8  8'
--       88        gg      gg    ,g,     I8 dPgg,
--  ,aa,_88        I8      8I   ,8'8,    I8dP" "8I
-- dP" "88P        I8,    ,8I  ,8'  Yb   I8P    I8
-- Yb,_,d88b,,_   ,d8b,  ,d8b,,8'_   8) ,d8     I8,
--  "Y8P"  "Y888888P'"Y88P"`Y8P' "YY8P8P88P     `Y8
--

-- This is a starter colorscheme for use with Lush,
-- for usage guides, see :h lush or :LushRunTutorial

--
-- Note: Because this is lua file, vim will append your file to the runtime,
--       which means you can require(...) it in other lua code (this is useful),
--       but you should also take care not to conflict with other libraries.
--
--       (This is a lua quirk, as it has somewhat poor support for namespacing.)
--
--       Basically, name your file,
--
--       "super_theme/lua/lush_theme/super_theme_dark.lua",
--
--       not,
--
--       "super_theme/lua/dark.lua".
--
--       With that caveat out of the way...
--

-- Enable lush.ify on this file, run:
--
--  `:Lushify`
--
--  or
--
--  `:lua require('lush').ify()`

local lush = require "lush"
local hsl = lush.hsl

local foreground = hsl "#f8f8f2"
local background = hsl "#282a36"
-- local selection = hsl("#44475a").darken(15)
local selection = hsl("#44475a")
local comment = hsl "#6272a4"
local cyan = hsl "#8be9fd"
local green = hsl "#50fa7b"
local orange = hsl "#ffb86c"
local pink = hsl "#ff79c6"
local purple = hsl "#bd93f9"
local red = hsl "#ff5555"
local gray = hsl "#abb2bf"
local yellow = hsl "#f1fa8c"
local black = hsl "#21222c"
local bright_black = hsl "#6272a4"
local bright_red = hsl "#ff6e6e"
local bright_green = hsl "#69ff94"
local bright_yellow = hsl "#ffffa5"
local bright_blue = hsl "#d6acff"
local bright_magenta = hsl "#ff92df"
local bright_cyan = hsl "#a4ffff"
local bright_white = hsl "#ffffff"
local bright_gray = hsl "#c6c6c6"

vim.g.dracula = {
  foreground = foreground.hex,
  background = background.hex,
  selection = selection.hex,
  comment = comment.hex,
  cyan = cyan.hex,
  green = green.hex,
  orange = orange.hex,
  pink = pink.hex,
  purple = purple.hex,
  red = red.hex,
  gray = gray.hex,
  yellow = yellow.hex,
  black = black.hex,
  bright_black = bright_black.hex,
  bright_red = bright_red.hex,
  bright_green = bright_green.hex,
  bright_yellow = bright_yellow.hex,
  bright_blue = bright_blue.hex,
  bright_magenta = bright_magenta.hex,
  bright_cyan = bright_cyan.hex,
  bright_white = bright_white.hex,
  bright_gray = bright_gray.hex,
}

local theme = lush(function()
  return {
    -- The following are all the Neovim default highlight groups from the docs
    -- as of 0.5.0-nightly-446, to aid your theme creation. Your themes should
    -- probably style all of these at a bare minimum.
    --
    -- Referenced/linked groups must come before being referenced/lined,
    -- so the order shown ((mostly) alphabetical) is likely
    -- not the order you will end up with.
    --
    -- You can uncomment these and leave them empty to disable any
    -- styling for that group (meaning they mostly get styled as Normal)
    -- or leave them commented to apply vims default colouring or linking.

    Comment { fg = comment, gui = "italic" }, -- any comment
    ColorColumn { bg = selection }, -- used for the columns set with 'colorcolumn'
    -- Conceal      { }, -- placeholder characters substituted for concealed text (see 'conceallevel')
    -- Cursor       { }, -- character under the cursor
    -- lCursor      { }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
    -- CursorIM     { }, -- like Cursor, but used when in IME mode |CursorIM|
    CursorColumn { bg = selection }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
    CursorLine { bg = selection }, -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
    Directory { fg = cyan }, -- directory names (and other special names in listings),
    DiffAdd { fg = green }, -- diff mode: Added line |diff.txt|
    DiffChange { fg = orange }, -- diff mode: Changed line |diff.txt|
    DiffDelete { fg = red }, -- diff mode: Deleted line |diff.txt|
    DiffText { fg = comment }, -- diff mode: Changed text within a changed line |diff.txt|
    -- EndOfBuffer  { }, -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
    -- TermCursor   { }, -- cursor in a focused terminal
    -- TermCursorNC { }, -- cursor in an unfocused terminal
    ErrorMsg { fg = red, gui = "bold" }, -- error messages on the command line
    VertSplit { fg = black, bg = background }, -- the column separating vertically split windows
    Folded { bg = selection.darken(20) }, -- line used for closed folds
    -- FoldColumn   { }, -- 'foldcolumn'
    SignColumn { bg = background }, -- column where |signs| are displayed
    -- IncSearch    { }, -- 'incsearch' highlighting, also used for the text replaced with ":s///c"
    -- Substitute   { }, -- |:substitute| replacement text highlighting
    LineNr { fg = bright_black }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    CursorLineNr { fg = bright_gray, gui = "bold" }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
    MatchParen { fg = foreground, gui = "underline" }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
    -- ModeMsg      { }, -- 'showmode' message (e.g., "-- INSERT -- ")
    -- MsgArea      { }, -- Area for messages and cmdline
    -- MsgSeparator { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
    -- MoreMsg      { }, -- |more-prompt|
    NonText { fg = selection }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
    -- Normal       { }, -- normal text
    -- NormalNC     { }, -- normal text in non-current windows
    NormalFloat { bg = background }, -- Normal text in floating windows.
    FloatBorder { fg = bright_black },

    Pmenu { bg = black }, -- Popup menu: normal item.
    PmenuSel { bg = bright_black }, -- Popup menu: selected item.
    PmenuSbar { bg = black.lighten(3) }, -- Popup menu: scrollbar.
    PmenuThumb { bg = bright_white }, -- Popup menu: Thumb of the scrollbar.
    Question { fg = cyan }, -- |hit-enter| prompt and yes/no questions
    -- QuickFixLine { }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
    Search { bg = selection }, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
    SpecialKey { fg = selection }, -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace|
    -- SpellBad     { }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
    -- SpellCap     { }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
    -- SpellLocal   { }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
    -- SpellRare    { }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
    StatusLine { bg = black }, -- status line of current window
    StatusLineNC { fg = black }, -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
    -- TabLine      { }, -- tab pages line, not active tab page label
    -- TabLineFill  { }, -- tab pages line, where there are no labels
    -- TabLineSel   { }, -- tab pages line, active tab page label
    Title { fg = foreground }, -- titles for output from ":set all", ":autocmd" etc.
    Visual { bg = selection }, -- Visual mode selection
    -- VisualNOS    { }, -- Visual mode selection when vim is "Not Owning the Selection".
    WarningMsg { fg = orange }, -- warning messages
    Whitespace { fg = selection }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
    WildMenu { bg = bright_black }, -- current match in 'wildmenu' completion

    -- These groups are not listed as default vim groups,
    -- but they are defacto standard group names for syntax highlighting.
    -- commented out groups should chain up to their "preferred" group by
    -- default,
    -- Uncomment and edit if you want more specific syntax highlighting.

    Constant { fg = purple }, -- (preferred) any constant
    String { fg = yellow }, --   a string constant: "this is a string"
    Character { fg = yellow }, --  a character constant: 'c', '\n'
    Number { fg = purple }, --   a number constant: 234, 0xff
    Boolean { fg = purple }, --  a boolean constant: TRUE, false
    Float { fg = purple }, --    a floating point constant: 2.3e10

    Identifier { fg = foreground }, -- (preferred) any variable name
    Function { fg = green }, -- function name (also: methods for classes)

    Statement { fg = pink }, -- (preferred) any statement
    Conditional { fg = pink }, --  if, then, else, endif, switch, etc.
    Repeat { fg = pink }, --   for, do, while, etc.
    Label { fg = pink }, --    case, default, etc.
    Operator { fg = pink }, -- "sizeof", "+", "*", etc.
    Keyword { fg = pink }, --  any other keyword
    Exception { fg = pink }, --  try, catch, throw

    PreProc { fg = pink }, -- (preferred) generic Preprocessor
    Include { fg = pink }, --  preprocessor #include
    Define { fg = pink }, --   preprocessor #define
    Macro { fg = pink }, --    same as Define
    PreCondit { fg = pink }, --  preprocessor #if, #else, #endif, etc.

    Type { fg = cyan, gui = "italic" }, -- (preferred) int, long, char, etc.
    StorageClass { fg = pink }, -- static, register, volatile, etc.
    Structure { fg = cyan }, --  struct, union, enum, etc.
    Typedef { fg = pink }, --  A typedef

    Special { fg = foreground }, -- (preferred) any special symbol
    -- SpecialChar    { fg = red }, --  special character in a constant
    -- Tag            { }, --    you can use CTRL-] on this
    Delimiter { fg = foreground }, --  character that needs attention
    SpecialComment { fg = purple }, -- special things inside a comment
    -- Debug          { }, --    debugging statements

    -- Underlined { gui = "underline" }, -- (preferred) text that stands out, HTML links
    Bold { gui = "bold" },
    -- Italic     { gui = "italic" },

    -- ("Ignore", below, may be invisible...)
    -- Ignore         { }, -- (preferred) left blank, hidden  |hl-Ignore|

    Error { bg = background }, -- (preferred) any erroneous construct

    Todo { fg = purple, gui = "bold" }, -- (preferred) anything that needs extra attention, mostly the keywords TODO FIXME and XXX

    -- These groups are for the native LSP client. Some other LSP clients may
    -- use these groups, or use their own. Consult your LSP client's
    -- documentation.

    LspReferenceText { bg = selection }, -- used for highlighting "text" references
    LspReferenceRead { bg = selection }, -- used for highlighting "read" references
    LspReferenceWrite { bg = selection }, -- used for highlighting "write" references

    LspDiagnosticsDefaultError { fg = bright_red }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
    LspDiagnosticsDefaultWarning { fg = orange }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
    LspDiagnosticsDefaultInformation { fg = bright_yellow }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
    LspDiagnosticsDefaultHint { fg = bright_cyan }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)

    -- LspDiagnosticsVirtualTextError       { }, -- Used for "Error" diagnostic virtual text
    -- LspDiagnosticsVirtualTextWarning     { }, -- Used for "Warning" diagnostic virtual text
    -- LspDiagnosticsVirtualTextInformation { }, -- Used for "Information" diagnostic virtual text
    -- LspDiagnosticsVirtualTextHint        { }, -- Used for "Hint" diagnostic virtual text

    LspDiagnosticsUnderlineError { fg = bright_red, gui = "underline" }, -- Used to underline "Error" diagnostics
    LspDiagnosticsUnderlineWarning { fg = orange, gui = "underline" }, -- Used to underline "Warning" diagnostics
    LspDiagnosticsUnderlineInformation { fg = bright_yellow, gui = "underline" }, -- Used to underline "Information" diagnostics
    LspDiagnosticsUnderlineHint { fg = bright_cyan, gui = "underline" }, -- Used to underline "Hint" diagnostics

    -- LspDiagnosticsFloatingError          { }, -- Used to color "Error" diagnostic messages in diagnostics float
    -- LspDiagnosticsFloatingWarning        { }, -- Used to color "Warning" diagnostic messages in diagnostics float
    -- LspDiagnosticsFloatingInformation    { }, -- Used to color "Information" diagnostic messages in diagnostics float
    -- LspDiagnosticsFloatingHint           { }, -- Used to color "Hint" diagnostic messages in diagnostics float

    -- LspDiagnosticsSignError              { }, -- Used for "Error" signs in sign column
    -- LspDiagnosticsSignWarning            { }, -- Used for "Warning" signs in sign column
    -- LspDiagnosticsSignInformation        { }, -- Used for "Information" signs in sign column
    -- LspDiagnosticsSignHint               { }, -- Used for "Hint" signs in sign column

    -- These groups are for the neovim tree-sitter highlights.
    -- As of writing, tree-sitter support is a WIP, group names may change.
    -- By default, most of these groups link to an appropriate Vim group,
    -- TSError -> Error for example, so you do not have to define these unless
    -- you explicitly want to support Treesitter's improved syntax awareness.

    TSAnnotation { Type }, -- For C++/Dart attributes, annotations that can be attached to the code to denote some kind of meta information.
    -- TSAttribute          { },    -- (unstable) TODO: docs
    -- TSBoolean            { },    -- For booleans.
    -- TSCharacter          { },    -- For characters.
    -- TSComment            { },    -- For comment blocks.
    TSConstructor { fg = cyan }, -- For constructor calls and definitions: ` { }` in Lua, and Java constructors.
    -- TSConditional        { },    -- For keywords related to conditionnals.
    -- TSConstant           { },    -- For constants
    TSConstBuiltin { fg = purple }, -- For constant that are built in the language: `nil` in Lua.
    -- TSConstMacro         { },    -- For constants that are defined by macros: `NULL` in C.
    -- TSError              { },    -- For syntax/parser errors.
    -- TSException          { },    -- For exception related keywords.
    -- TSField              { },    -- For fields.
    -- TSFloat              { },    -- For floats.
    -- TSFunction           { },    -- For function (calls and definitions).
    TSFuncBuiltin { fg = cyan }, -- For builtin functions: `table.insert` in Lua.
    -- TSFuncMacro          { },    -- For macro defined fuctions (calls and definitions): each `macro_rules` in Rust.
    TSInclude { Include }, -- For includes: `#include` in C, `use` or `extern crate` in Rust, or `require` in Lua.
    -- TSKeyword            { },    -- For keywords that don't fall in previous categories.
    -- TSKeywordFunction    { },    -- For keywords used to define a fuction.
    TSKeywordOperator { fg = pink }, -- For keywords used to define a fuction.
    -- TSLabel              { },    -- For labels: `label:` in C and `:label:` in Lua.
    -- TSMethod             { },    -- For method calls and definitions.
    TSNamespace { Identifier }, -- For identifiers referring to modules and namespaces.
    -- TSNone               { },    -- docs
    -- TSNumber             { },    -- For all numbers
    -- TSOperator           { },    -- For any operator: `+`, but also `->` and `*` in C.
    TSParameter { fg = orange, gui = "italic" }, -- For parameters of a function.
    -- TSParameterReference { },    -- For references to parameters of a function.
    -- TSProperty           { },    -- Same as `TSField`.
    -- TSPunctDelimiter     { },    -- For delimiters ie: `.`
    -- TSPunctBracket       { },    -- For brackets and parens.
    -- TSPunctSpecial       { },    -- For special punctutation that does not fall in the catagories before.
    -- TSRepeat             { },    -- For keywords related to loops.
    -- TSString             { },    -- For strings.
    TSStringRegex { fg = red }, -- For regexes.
    TSStringEscape { fg = pink }, -- For escape characters within a string.
    -- TSSymbol             { },    -- For identifiers referring to symbols or atoms.
    TSType { fg = cyan }, -- For types.
    -- TSTypeBuiltin        { },    -- For builtin types.
    -- TSVariable           { },    -- Any variable name that does not have another highlight.
    TSVariableBuiltin { fg = purple, gui = "italic" }, -- Variable names that are defined by the languages, like `this` or `self`.

    -- TSTag                { },    -- Tags like html tag names.
    TSTagAttribute { fg = green }, -- Tags like html tag names.
    -- TSTagDelimiter       { },    -- Tag delimiter like `<` `>` `/`
    -- TSText               { },    -- For strings considered text in a markup language.
    -- TSEmphasis           { },    -- For text to be represented with emphasis.
    -- TSUnderline          { },    -- For text to be represented with an underline.
    -- TSStrike             { },    -- For strikethrough text.
    TSTitle { fg = foreground }, -- Text that is part of a title.
    -- TSLiteral            { },    -- Literal text.
    TSURI { fg = yellow, gui = "underline" }, -- Any URI like a link or email.

    -- GIT
    SignAdd { DiffAdd },
    SignChange { DiffChange },
    SignDelete { DiffDelete },
    GitSignsAdd { DiffAdd },
    GitSignsChange { DiffChange },
    GitSignsDelete { DiffDelete },

    NvimTreeFolderIcon { fg = cyan },
    NvimTreeIndentMarker { Whitespace },
    NvimTreeNormal { bg = black },
    NvimTreeVertSplit { fg = black, bg = black },
    NvimTreeFolderName { fg = cyan },
    NvimTreeOpenedFolderName { fg = cyan, style = "italic" },
    NvimTreeImageFile { fg = purple },
    NvimTreeSpecialFile { fg = yellow, gui = "bold,underline" },
    NvimTreeGitStaged { GitSignsAdd },
    NvimTreeGitNew { GitSignsAdd },
    NvimTreeGitDirty { GitSignsAdd },
    NvimTreeGitDeleted { GitSignsDelete },
    NvimTreeGitMerge { GitSignsChange },
    NvimTreeGitRenamed { GitSignsChange },
    NvimTreeSymlink { fg = cyan },
    NvimTreeRootFolder { fg = foreground, gui = "bold" },
    NvimTreeExecFile { fg = green, gui = "bold" },

    -- MARKDOWN
    markdownH1 { fg = purple, gui = "bold" },
    markdownH1Delimiter { fg = purple, gui = "bold" },
    markdownRule { fg = comment },
    markdownItalic { fg = yellow, gui = "italic" },
    markdownBold { fg = orange, gui = "bold" },
    markdownCode { fg = green },
    markdownLinkText { fg = pink, gui = "bold" },
    markdownLinkTextDelimiter { fg = pink, gui = "bold" },
    markdownUrl { fg = cyan, gui = "underline" },
    markdownListMarker { fg = pink },
    markdownEscape { fg = foreground },

    mkdCode { markdownCode },
    mkdCodeDelimiter { mkdCode },
    mkdRule { markdownRule },
    mkdHeading { fg = purple, gui = "bold" },
    mkdCodeStart { Identifier },
    mkdCodeEnd { mkdCodeStart },
    mkdLink { markdownLinkText },
    mkdUrl { markdownUrl },
    mkdListItem { markdownListMarker },
    mkdNbsp { fg = red, bg = green }, -- not apply

    -- HTML
    htmlH1 { mkdHeading },
    htmlItalic { markdownItalic },
    htmlBold { markdownBold },
    htmlBoldItalic { fg = orange, gui = "bold,italic" },
    htmlTSTitle { fg = foreground },
    htmlArg { fg = green },
    htmlTag { fg = foreground },
    htmlString { fg = yellow },

    -- Css
    cssBraces { fg = foreground },
    cssFunctionComma { fg = foreground },
    cssValueLength { fg = purple },
    cssUnitDecorators { fg = pink },
    cssBoxProp { fg = cyan },
    cssBackgroundProp { fg = cyan },
    cssTextProp { fg = cyan },
    cssUIProp { fg = cyan },
    cssBorderProp { fg = cyan },
    cssPositioningProp { fg = cyan },
    cssFontProp { fg = cyan },
    cssMediaProp { fg = cyan },
    cssAttrRegion { fg = purple },

    -- SH
    shStatement { TSFuncBuiltin },
    shQuote { String },
    shDoublQuote { String },

    -- Lua
    luaFunction { TSFuncBuiltin },
    luaFunc { Function },
    luaTSKeywordFunction { TSFuncBuiltin },
    luaTSVariable { Identifier },

    -- Javascript
    javascriptTSVariable { Identifier },
    javascriptTSPunctSpecial { TSStringEscape },
    javascriptMember { fg = purple, gui = "italic" },
    javascriptBraces { Identifier },
    javascriptIdentifier { Keyword },
    -- javascriptTSKeywordOperator    { gui = 'bold' },

    -- Help
    helpHeadline { fg = pink },
    helpSectionDelim { fg = cyan },
    helpHeader { fg = cyan },

    -- Requirements
    requirementsPackageName { fg = cyan },
    requirementsVersionSpecifiers { fg = pink },

    -- Yaml
    yamlBlockMappingKey { fg = cyan },
    yamlKeyValueDelimiter { fg = pink },
    yamlBlockCollectionItemStart { fg = pink },
    yamlPlainScalar { fg = yellow },
    yamlBool { Boolean },
    yamlTSField { yamlBlockMappingKey },
    yamlTSPunctDelimiter { yamlKeyValueDelimiter },

    -- Typescript
    -- typescriptKeyWordNew           { fg = pink, gui = 'bold' },
    -- typescriptTSKeywordOperator    { gui = 'bold'  },

    -- Telescope
    -- TelescopeBorder { fg = bright_black },
    TelescopeMatching { fg = green, gui = "bold" },
    TelescopePromptPrefix { fg = green, gui = "bold" },

    -- WhichKey({ fg = purple }),
    -- WhichKeySeperator({ fg = green }),
    -- WhichKeyGroup({ fg = cyan }),
    -- WhichKeyDesc({ fg = bright_blue }),
    -- WhichKeyFloat({ bg = fg }),

    -- Todo Comments
    TodoError { fg = red, gui = "bold" },
    TodoHint { fg = cyan, gui = "bold" },
    TodoInfo { fg = yellow, gui = "bold" },
    TodoWarning { fg = orange, gui = "bold" },
    TodoDefault { fg = purple, gui = "bold" },
  }
end)

-- return our parsed theme for extension or use else where.
return theme

-- vi: nowrap
