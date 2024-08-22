local L = {}

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

local ministarter_hl = {
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

L.links = links
L.ministarter_hl = ministarter_hl

return L
