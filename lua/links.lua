local L = {}

local links = {
  Character = { link = "Constant" },
  Number = { link = "Constant" },
  Float = { link = "Number" },
  Boolean = { link = "Constant" },
  String = { link = "Constant" },
  Function = { link = "Identifier" },
  Conditional = { link = "Statement" },
  Repeat = { link = "Statement" },
  Label = { link = "Statement" },
  Keyword = { link = "Statement" },
  Exception = { link = "Statement" },
  Include = { link = "PreProc" },
  Define = { link = "PreProc" },
  Macro = { link = "PreProc" },
  PreCondit = { link = "PreProc" },
  StorageClass = { link = "Type" },
  Structure = { link = "Type" },
  Typedef = { link = "Type" },
  SpecialChar = { link = "Special" },
  Tag = { link = "Special" },
  Delimiter = { link = "Special" },
  SpecialComment = { link = "Special" },
  Debug = { link = "Special" },
  ErrorMsg = { link = "Error" },
  WarningMsg = { link = "Warning" },
  MoreMsg = { link = "ModeMsg" },
  Question = { link = "ModeMsg" },
  Ignore = { link = "NonText" },
  StatusLineTerm = { link = "StatusLine" },
  StatusLineTermNC = { link = "StatusLineNC" },
  TabLine = { link = "StatusLineNC" },
  TabLineFill = { link = "StatusLineNC" },
  TabLineSel = { link = "StatusLine" },
  CursorColumn = { link = "CursorLine" },
  SpellRare = { link = "SpellLocal" },
  diffAdded = { link = "DiffAdd" },
  diffRemoved = { link = "DiffDelete" },
  htmlTag = { link = "htmlTagName" },
  htmlEndTag = { link = "htmlTag" },
  gitcommitSummary = { link = "Title" },
  -- TS
  ["@comment"] = { link = "Comment" },
  ["@preproc"] = { link = "PreProc" },
  ["@define"] = { link = "Define" },
  ["@operator"] = { link = "Operator" },
  ["@punctuation.delimiter"] = { link = "Delimiter" },
  ["@punctuation.bracket"] = { link = "Delimiter" },
  ["@punctuation.special"] = { link = "Delimiter" },
  ["@string"] = { link = "String" },
  ["@string.regex"] = { link = "String" },
  ["@string.regexp"] = { link = "String" },
  ["@string.escape"] = { link = "SpecialChar" },
  ["@string.special"] = { link = "SpecialChar" },
  ["@string.special.path"] = { link = "Underlined" },
  ["@string.special.symbol"] = { link = "Identifier" },
  ["@string.special.url"] = { link = "Underlined" },
  ["@character"] = { link = "Character" },
  ["@character.special"] = { link = "SpecialChar" },
  ["@boolean"] = { link = "Boolean" },
  ["@number"] = { link = "Number" },
  ["@number.float"] = { link = "Float" },
  ["@float"] = { link = "Float" },
  ["@function"] = { link = "Function" },
  ["@function.builtin"] = { link = "Special" },
  ["@function.call"] = { link = "Function" },
  ["@function.macro"] = { link = "Macro" },
  ["@function.method"] = { link = "Function" },
  ["@method"] = { link = "Function" },
  ["@method.call"] = { link = "Function" },
  ["@constructor"] = { link = "Special" },
  ["@parameter"] = { link = "Identifier" },
  ["@keyword"] = { link = "Keyword" },
  ["@keyword.conditional"] = { link = "Conditional" },
  ["@keyword.debug"] = { link = "Debug" },
  ["@keyword.directive"] = { link = "PreProc" },
  ["@keyword.directive.define"] = { link = "Define" },
  ["@keyword.exception"] = { link = "Exception" },
  ["@keyword.function"] = { link = "Keyword" },
  ["@keyword.import"] = { link = "Include" },
  ["@keyword.operator"] = { link = "ErrorMsg" },
  ["@keyword.repeat"] = { link = "Repeat" },
  ["@keyword.return"] = { link = "Keyword" },
  ["@keyword.storage"] = { link = "StorageClass" },
  ["@conditional"] = { link = "Conditional" },
  ["@repeat"] = { link = "Repeat" },
  ["@debug"] = { link = "Debug" },
  ["@label"] = { link = "Label" },
  ["@include"] = { link = "Include" },
  ["@exception"] = { link = "Exception" },
  ["@type"] = { link = "Type" },
  ["@type.builtin"] = { link = "Type" },
  ["@type.definition"] = { link = "Typedef" },
  ["@type.qualifier"] = { link = "Type" },
  ["@storageclass"] = { link = "StorageClass" },
  ["@attribute"] = { link = "PreProc" },
  ["@field"] = { link = "Identifier" },
  ["@property"] = { link = "Identifier" },
  ["@variable"] = { link = "Constant" },
  ["@variable.builtin"] = { link = "Special" },
  ["@variable.member"] = { link = "Identifier" },
  ["@variable.parameter"] = { link = "Identifier" },
  ["@constant"] = { link = "Constant" },
  ["@constant.builtin"] = { link = "Special" },
  ["@constant.macro"] = { link = "Define" },
  ["@markup"] = { link = "Normal" },
  ["@markup.italic"] = { link = "@text.emphasis" },
  ["@markup.heading"] = { link = "Title" },
  ["@markup.raw"] = { link = "String" },
  ["@markup.math"] = { link = "Special" },
  ["@markup.environment"] = { link = "Macro" },
  ["@markup.environment.name"] = { link = "Type" },
  ["@markup.link"] = { link = "Underlined" },
  ["@markup.link.label"] = { link = "SpecialChar" },
  ["@markup.list"] = { link = "Delimiter" },
  ["@markup.list.checked"] = { link = "Todo" },
  ["@markup.list.unchecked"] = { link = "Statement" },
  ["@comment.todo"] = { link = "Todo" },
  ["@comment.note"] = { link = "SpecialComment" },
  ["@comment.warning"] = { link = "WarningMsg" },
  ["@comment.error"] = { link = "ErrorMsg" },
  ["@diff.plus"] = { link = "diffAdded" },
  ["@diff.minus"] = { link = "diffRemoved" },
  ["@diff.delta"] = { link = "diffChanged" },
  ["@symbol"] = { link = "Identifier" },
  ["@module"] = { link = "Normal" },
  ["@namespace"] = { link = "Normal" },
  ["@text"] = { link = "Normal" },
  ["@text.title"] = { link = "Title" },
  ["@text.literal"] = { link = "String" },
  ["@text.uri"] = { link = "Underlined" },
  ["@text.math"] = { link = "Special" },
  ["@text.environment"] = { link = "Macro" },
  ["@text.environment.name"] = { link = "Type" },
  ["@text.reference"] = { link = "Constant" },
  ["@text.todo"] = { link = "Todo" },
  ["@text.todo.checked"] = { link = "WildMenu" },
  ["@text.todo.unchecked"] = { link = "Statement" },
  ["@text.note"] = { link = "SpecialComment" },
  ["@text.warning"] = { link = "WarningMsg" },
  ["@text.danger"] = { link = "ErrorMsg" },
  ["@text.diff.add"] = { link = "diffAdded" },
  ["@text.diff.delete"] = { link = "diffRemoved" },
  ["@tag"] = { link = "Tag" },
  ["@tag.attribute"] = { link = "Identifier" },
  ["@tag.delimiter"] = { link = "Delimiter" },
  ["@punctuation"] = { link = "Delimiter" },
  ["@macro"] = { link = "Macro" },
  ["@structure"] = { link = "Structure" },
  ["@lsp.type.class"] = { link = "@type" },
  ["@lsp.type.comment"] = { link = "@comment" },
  ["@lsp.type.decorator"] = { link = "@macro" },
  ["@lsp.type.enum"] = { link = "@type" },
  ["@lsp.type.enumMember"] = { link = "@constant" },
  ["@lsp.type.function"] = { link = "@function" },
  ["@lsp.type.interface"] = { link = "@constructor" },
  ["@lsp.type.macro"] = { link = "@macro" },
  ["@lsp.type.method"] = { link = "@method" },
  ["@lsp.type.namespace"] = { link = "@namespace" },
  ["@lsp.type.parameter"] = { link = "@parameter" },
  ["@lsp.type.property"] = { link = "@property" },
  ["@lsp.type.struct"] = { link = "@type" },
  ["@lsp.type.type"] = { link = "@type" },
  ["@lsp.type.typeParameter"] = { link = "@type.definition" },
  ["@lsp.type.variable"] = { link = "@variable" },
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

local fzf_lua_highlights = {
  FzfLuaNormal = { link = "Normal" },
  FzfLuaBorder = { link = "FloatBorder" },
  FzfLuaCursorLine = { link = "CursorLine" },
  FzfLuaSearch = { link = "IncSearch" },
  FzfLuaTitle = { link = "Title" },
  FzfLuaPrompt = { link = "Comment" },
  FzfLuaPointer = { link = "CursorLineNr" },
  FzfLuaMarker = { link = "CursorLineNr" },
  FzfLuaPreviewNormal = { link = "Constant" },
}

L.get_base_links = function()
  return links
end

L.get_ministarter = function()
  return ministarter_hl
end

L.get_fzf_lua = function()
  return fzf_lua_highlights
end

return L