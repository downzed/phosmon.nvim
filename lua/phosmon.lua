local utils = require('utils')
local cmds = require('cmds')

local colors = {
  fg = "#c6c6c6",
  bg = "#262626",
  mostly_black_too = "#1c1c1c",
  mostly_black = "#303030",
  not_so_black = "#262626",
  dark_gray = "#3a3a3a",
  constant = "#af87d7",
  comment = "#626262",
  very_dark_gray = "#444444",
  gray = "#767676",
  dark_grayish_green = "#87af87",
  red = "#d75f5f",
  dark_pink = "#af5f87",
  gold = "#d7af5f",
  teal = "#5f8787"
}

local highlights = {
  Normal = { bg = colors.bg, fg = colors.fg },
  NonText = { bg = colors.bg, fg = colors.very_dark_gray },
  EndOfBuffer = { bg = "NONE", fg = colors.bg },
  FloatBorder = { bg = "NONE", fg = colors.bg },
  Comment = { fg = colors.comment, italic = true },
  Conceal = { bg = colors.bg, fg = colors.comment },
  Constant = { bg = "NONE", fg = colors.constant },
  Identifier = { bg = "NONE", fg = colors.fg },
  Statement = { bg = "NONE", fg = colors.gray },
  Operator = { bg = "NONE", fg = colors.fg },
  PreProc = { bg = colors.bg, fg = colors.gray },
  Type = { bg = "NONE", fg = colors.teal },
  Special = { bg = "NONE", fg = colors.gray },
  Error = { bg = "NONE", fg = colors.red, bold = true },
  Warning = { bg = "NONE", fg = colors.gold },
  ModeMsg = { bg = "NONE", fg = colors.gray },
  Todo = { bg = colors.bg, fg = colors.dark_pink, bold = true },
  Underlined = { bg = "NONE", fg = colors.fg, underline = true },
  StatusLine = { bg = colors.dark_gray, fg = colors.constant },
  StatusLineNC = { bg = colors.mostly_black, fg = colors.gray },
  WildMenu = { bg = colors.mostly_black, fg = colors.red },
  VertSplit = { bg = colors.mostly_black, fg = colors.mostly_black },
  Title = { bg = "NONE", fg = colors.fg, bold = true },
  LineNr = { bg = "NONE", fg = colors.very_dark_gray },
  CursorLineNr = { bg = colors.mostly_black, fg = colors.constant },
  Cursor = { bg = colors.constant, fg = colors.fg },
  CursorLine = { bg = colors.mostly_black, fg = "NONE" },
  ColorColumn = { bg = colors.mostly_black, fg = "NONE" },
  SignColumn = { bg = "NONE", fg = colors.gray },
  Visual = { bg = colors.gray, fg = "NONE" },
  VisualNOS = { bg = colors.dark_gray, fg = "NONE" },
  Pmenu = { bg = colors.dark_gray, fg = "NONE" },
  PmenuSbar = { bg = colors.mostly_black, fg = "NONE" },
  PmenuSel = { bg = colors.mostly_black, fg = colors.constant },
  PmenuThumb = { bg = colors.red, fg = "NONE" },
  FoldColumn = { bg = "NONE", fg = colors.comment },
  Folded = { bg = colors.mostly_black_too, fg = colors.gray },
  SpecialKey = { bg = "NONE", fg = colors.gray },
  IncSearch = { bg = colors.red, fg = colors.not_so_black },
  Search = { bg = colors.constant, fg = colors.not_so_black },
  Directory = { bg = "NONE", fg = colors.constant },
  MatchParen = { bg = "NONE", fg = colors.red, bold = true },
  SpellBad = { bg = "NONE", fg = colors.dark_pink, underline = true },
  SpellCap = { bg = "NONE", fg = colors.dark_grayish_green, underline = true },
  SpellLocal = { bg = "NONE", fg = colors.gold, underline = true },
  QuickFixLine = { bg = colors.mostly_black_too, fg = "NONE" },
  DiffAdd = { bg = colors.mostly_black, fg = colors.dark_grayish_green },
  DiffChange = { bg = colors.mostly_black, fg = "NONE" },
  DiffDelete = { bg = colors.mostly_black, fg = colors.dark_pink },
  DiffText = { bg = colors.mostly_black, fg = colors.gold },
  Function = { bg = "NONE", fg = colors.fg, bold = true },
  helpHyperTextJump = { fg = colors.red, bg = colors.bg },

  -- TS
  ["@none"] = { bg = "NONE", fg = "NONE" },
  ["@markup.strong"] = { bold = true },
  ["@markup.underline"] = { underline = true },
  ["@markup.strikethrough"] = { strikethrough = true },
  ["@text.strong"] = { bold = true },
  ["@text.emphasis"] = { italic = true },
  ["@text.underline"] = { underline = true },
  ["@text.strike"] = { strikethrough = true },
}

local links = {
  Character = "Constant",
  Number = "Constant",
  Float = "Number",
  Boolean = "Constant",
  String = "Constant",
  Function = "Identifier",
  Conditional = "Statement",
  Repeat = "Statement",
  Label = "Statement",
  Keyword = "Statement",
  Exception = "Statement",
  Include = "PreProc",
  Define = "PreProc",
  Macro = "PreProc",
  PreCondit = "PreProc",
  StorageClass = "Type",
  Structure = "Type",
  Typedef = "Type",
  SpecialChar = "Special",
  Tag = "Special",
  Delimiter = "Special",
  SpecialComment = "Special",
  Debug = "Special",
  ErrorMsg = "Error",
  WarningMsg = "Warning",
  MoreMsg = "ModeMsg",
  Question = "ModeMsg",
  Ignore = "NonText",
  StatusLineTerm = "StatusLine",
  StatusLineTermNC = "StatusLineNC",
  TabLine = "StatusLineNC",
  TabLineFill = "StatusLineNC",
  TabLineSel = "StatusLine",
  CursorColumn = "CursorLine",
  SpellRare = "SpellLocal",
  diffAdded = "DiffAdd",
  diffRemoved = "DiffDelete",
  htmlTag = "htmlTagName",
  htmlEndTag = "htmlTag",
  gitcommitSummary = "Title",
  -- TS
  ["@comment"] = "Comment",
  ["@preproc"] = "PreProc",
  ["@define"] = "Define",
  ["@operator"] = "Operator",
  ["@punctuation.delimiter"] = "Delimiter",
  ["@punctuation.bracket"] = "Delimiter",
  ["@punctuation.special"] = "Delimiter",
  ["@string"] = "String",
  ["@string.regex"] = "String",
  ["@string.regexp"] = "String",
  ["@string.escape"] = "SpecialChar",
  ["@string.special"] = "SpecialChar",
  ["@string.special.path"] = "Underlined",
  ["@string.special.symbol"] = "Identifier",
  ["@string.special.url"] = "Underlined",
  ["@character"] = "Character",
  ["@character.special"] = "SpecialChar",
  ["@boolean"] = "Boolean",
  ["@number"] = "Number",
  ["@number.float"] = "Float",
  ["@float"] = "Float",
  ["@function"] = "Function",
  ["@function.builtin"] = "Special",
  ["@function.call"] = "Function",
  ["@function.macro"] = "Macro",
  ["@function.method"] = "Function",
  ["@method"] = "Function",
  ["@method.call"] = "Function",
  ["@constructor"] = "Special",
  ["@parameter"] = "Identifier",
  ["@keyword"] = "Keyword",
  ["@keyword.conditional"] = "Conditional",
  ["@keyword.debug"] = "Debug",
  ["@keyword.directive"] = "PreProc",
  ["@keyword.directive.define"] = "Define",
  ["@keyword.exception"] = "Exception",
  ["@keyword.function"] = "Keyword",
  ["@keyword.import"] = "Include",
  ["@keyword.operator"] = "ErrorMsg",
  ["@keyword.repeat"] = "Repeat",
  ["@keyword.return"] = "Keyword",
  ["@keyword.storage"] = "StorageClass",
  ["@conditional"] = "Conditional",
  ["@repeat"] = "Repeat",
  ["@debug"] = "Debug",
  ["@label"] = "Label",
  ["@include"] = "Include",
  ["@exception"] = "Exception",
  ["@type"] = "Type",
  ["@type.builtin"] = "Type",
  ["@type.definition"] = "Typedef",
  ["@type.qualifier"] = "Type",
  ["@storageclass"] = "StorageClass",
  ["@attribute"] = "PreProc",
  ["@field"] = "Identifier",
  ["@property"] = "Identifier",
  ["@variable"] = "Constant",
  ["@variable.builtin"] = "Special",
  ["@variable.member"] = "Identifier",
  ["@variable.parameter"] = "Identifier",
  ["@constant"] = "Constant",
  ["@constant.builtin"] = "Special",
  ["@constant.macro"] = "Define",
  ["@markup"] = "Normal",
  ["@markup.italic"] = "@text.emphasis",
  ["@markup.heading"] = "Title",
  ["@markup.raw"] = "String",
  ["@markup.math"] = "Special",
  ["@markup.environment"] = "Macro",
  ["@markup.environment.name"] = "Type",
  ["@markup.link"] = "Underlined",
  ["@markup.link.label"] = "SpecialChar",
  ["@markup.list"] = "Delimiter",
  ["@markup.list.checked"] = "Todo",
  ["@markup.list.unchecked"] = "Statement",
  ["@comment.todo"] = "Todo",
  ["@comment.note"] = "SpecialComment",
  ["@comment.warning"] = "WarningMsg",
  ["@comment.error"] = "ErrorMsg",
  ["@diff.plus"] = "diffAdded",
  ["@diff.minus"] = "diffRemoved",
  ["@diff.delta"] = "diffChanged",
  ["@symbol"] = "Identifier",
  ["@module"] = "Normal",
  ["@namespace"] = "Normal",
  ["@text"] = "Normal",
  ["@text.title"] = "Title",
  ["@text.literal"] = "String",
  ["@text.uri"] = "Underlined",
  ["@text.math"] = "Special",
  ["@text.environment"] = "Macro",
  ["@text.environment.name"] = "Type",
  ["@text.reference"] = "Constant",
  ["@text.todo"] = "Todo",
  ["@text.todo.checked"] = "WildMenu",
  ["@text.todo.unchecked"] = "Statement",
  ["@text.note"] = "SpecialComment",
  ["@text.warning"] = "WarningMsg",
  ["@text.danger"] = "ErrorMsg",
  ["@text.diff.add"] = "diffAdded",
  ["@text.diff.delete"] = "diffRemoved",
  ["@tag"] = "Tag",
  ["@tag.attribute"] = "Identifier",
  ["@tag.delimiter"] = "Delimiter",
  ["@punctuation"] = "Delimiter",
  ["@macro"] = "Macro",
  ["@structure"] = "Structure",
  ["@lsp.type.class"] = "@type",
  ["@lsp.type.comment"] = "@comment",
  ["@lsp.type.decorator"] = "@macro",
  ["@lsp.type.enum"] = "@type",
  ["@lsp.type.enumMember"] = "@constant",
  ["@lsp.type.function"] = "@function",
  ["@lsp.type.interface"] = "@constructor",
  ["@lsp.type.macro"] = "@macro",
  ["@lsp.type.method"] = "@method",
  ["@lsp.type.namespace"] = "@namespace",
  ["@lsp.type.parameter"] = "@parameter",
  ["@lsp.type.property"] = "@property",
  ["@lsp.type.struct"] = "@type",
  ["@lsp.type.type"] = "@type",
  ["@lsp.type.typeParameter"] = "@type.definition",
  ["@lsp.type.variable"] = "@variable",
}

local mini_starter_hl = {
  MiniStarterCurrent = { nocombine = true },
  MiniStarterFooter = { link = "NonText" },
  MiniStarterHeader = { link = "Title" },
  MiniStarterInactive = { link = "Comment" },
  MiniStarterItem = { link = "Normal" },
  MiniStarterItemBullet = { link = "Delimiter" },
  MiniStarterItemPrefix = { link = "WarningMsg" },
  MiniStarterSection = { link = "Delimiter" },
  MiniStarterQuery = { link = "Constant" },
}

local phosmon = {}

phosmon.load = function()
  utils.set_theme()

  utils.apply_links(links)

  utils.apply_highlights(highlights)
  utils.apply_highlights(mini_starter_hl)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "none",
  })
end


phosmon.setup = function(_config)
  phosmon.load()
  cmds.set_commands()
end

phosmon.colors = colors

phosmon.toggle_opacity = utils.toggle_opacity

return phosmon
