local L = {}

local base_links = function()
  local palette = require('phosmon.colorscheme.colors').get_palette()
  return {
    Character = { link = 'Constant' },
    Number = { link = 'Constant' },
    Float = { link = 'Number' },
    Boolean = { link = 'Constant' },
    String = { link = 'Constant' },
    Function = { bg = false, fg = palette.teal, bold = true },
    Conditional = { link = 'Statement' },
    Repeat = { link = 'Statement' },
    Label = { link = 'Statement' },
    Keyword = { link = 'Statement' },
    Exception = { link = 'Statement' },
    Include = { link = 'PreProc' },
    Define = { link = 'PreProc' },
    Macro = { link = 'PreProc' },
    PreCondit = { link = 'PreProc' },
    StorageClass = { link = 'Type' },
    Structure = { link = 'Type' },
    Typedef = { link = 'Type' },
    SpecialChar = { link = 'Special' },
    Tag = { link = 'Special' },
    Delimiter = { link = 'Special' },
    SpecialComment = { link = 'Special' },
    Debug = { link = 'Special' },
    ErrorMsg = { link = 'Error' },
    WarningMsg = { link = 'Warning' },
    MoreMsg = { link = 'ModeMsg' },
    Question = { link = 'ModeMsg' },
    Ignore = { link = 'NonText' },
    StatusLineTerm = { link = 'StatusLine' },
    StatusLineTermNC = { link = 'StatusLineNC' },
    TabLine = { link = 'StatusLineNC' },
    TabLineFill = { link = 'StatusLineNC' },
    TabLineSel = { link = 'StatusLine' },
    CursorColumn = { link = 'CursorLine' },
    SpellRare = { link = 'SpellLocal' },
    diffAdded = { link = 'DiffAdd' },
    diffRemoved = { link = 'DiffDelete' },
    htmlTag = { link = 'htmlTagName', bold = true },
    htmlEndTag = { link = 'htmlTag', bold = true },
    gitcommitSummary = { link = 'Title' },
  }
end

local treesitter_hl = function()
  return {
    ['@comment'] = { link = 'Comment' },
    ['@preproc'] = { link = 'PreProc' },
    ['@define'] = { link = 'Define' },
    ['@operator'] = { link = 'Operator' },
    ['@punctuation.delimiter'] = { link = 'Delimiter' },
    ['@punctuation.bracket'] = { link = 'Delimiter' },
    ['@punctuation.special'] = { link = 'Delimiter' },
    ['@string'] = { link = 'String' },
    ['@string.regex'] = { link = 'String' },
    ['@string.regexp'] = { link = 'String' },
    ['@string.escape'] = { link = 'SpecialChar' },
    ['@string.special'] = { link = 'SpecialChar' },
    ['@string.special.path'] = { link = 'Underlined' },
    ['@string.special.symbol'] = { link = 'Identifier' },
    ['@string.special.url'] = { link = 'Underlined' },
    ['@character'] = { link = 'Character' },
    ['@character.special'] = { link = 'SpecialChar' },
    ['@boolean'] = { link = 'Boolean' },
    ['@number'] = { link = 'Number' },
    ['@number.float'] = { link = 'Float' },
    ['@float'] = { link = 'Float' },
    ['@function'] = { link = 'Function' },
    ['@function.builtin'] = { link = 'Special' },
    ['@function.call'] = { link = 'Function' },
    ['@function.macro'] = { link = 'Macro' },
    ['@function.method'] = { link = 'Function' },
    ['@method'] = { link = 'Function' },
    ['@method.call'] = { link = 'Function' },
    ['@constructor'] = { link = 'Special' },
    ['@parameter'] = { link = 'Identifier' },
    ['@keyword'] = { link = 'Keyword' },
    ['@keyword.conditional'] = { link = 'Conditional' },
    ['@keyword.debug'] = { link = 'Debug' },
    ['@keyword.directive'] = { link = 'PreProc' },
    ['@keyword.directive.define'] = { link = 'Define' },
    ['@keyword.exception'] = { link = 'Exception' },
    ['@keyword.function'] = { link = 'Keyword' },
    ['@keyword.import'] = { link = 'Include' },
    ['@keyword.operator'] = { link = 'ErrorMsg' },
    ['@keyword.repeat'] = { link = 'Repeat' },
    ['@keyword.return'] = { link = 'Keyword' },
    ['@keyword.storage'] = { link = 'StorageClass' },
    ['@conditional'] = { link = 'Conditional' },
    ['@repeat'] = { link = 'Repeat' },
    ['@debug'] = { link = 'Debug' },
    ['@label'] = { link = 'Label' },
    ['@include'] = { link = 'Include' },
    ['@exception'] = { link = 'Exception' },
    ['@type'] = { link = 'Type' },
    ['@type.builtin'] = { link = 'Type' },
    ['@type.definition'] = { link = 'Typedef' },
    ['@type.qualifier'] = { link = 'Type' },
    ['@storageclass'] = { link = 'StorageClass' },
    ['@attribute'] = { link = 'PreProc' },
    ['@field'] = { link = 'Identifier' },
    ['@property'] = { link = 'Identifier' },
    ['@variable'] = { link = 'Constant' },
    ['@variable.builtin'] = { link = 'Special' },
    ['@variable.member'] = { link = 'Identifier' },
    ['@variable.parameter'] = { link = 'Identifier' },
    ['@constant'] = { link = 'Constant' },
    ['@constant.builtin'] = { link = 'Special' },
    ['@constant.macro'] = { link = 'Define' },
    ['@markup'] = { link = 'Normal' },
    ['@markup.italic'] = { link = '@text.emphasis' },
    ['@markup.heading'] = { link = 'Title' },
    ['@markup.raw'] = { link = 'String' },
    ['@markup.math'] = { link = 'Special' },
    ['@markup.environment'] = { link = 'Macro' },
    ['@markup.environment.name'] = { link = 'Type' },
    ['@markup.link'] = { link = 'Underlined' },
    ['@markup.link.label'] = { link = 'SpecialChar' },
    ['@markup.list'] = { link = 'Delimiter' },
    ['@markup.list.checked'] = { link = 'Todo' },
    ['@markup.list.unchecked'] = { link = 'Statement' },
    ['@comment.todo'] = { link = 'Todo' },
    ['@comment.note'] = { link = 'SpecialComment' },
    ['@comment.warning'] = { link = 'WarningMsg' },
    ['@comment.error'] = { link = 'ErrorMsg' },
    ['@diff.plus'] = { link = 'diffAdded' },
    ['@diff.minus'] = { link = 'diffRemoved' },
    ['@diff.delta'] = { link = 'diffChanged' },
    ['@symbol'] = { link = 'Identifier' },
    ['@module'] = { link = 'Normal' },
    ['@namespace'] = { link = 'Normal' },
    ['@text'] = { link = 'Normal' },
    ['@text.title'] = { link = 'Title' },
    ['@text.literal'] = { link = 'String' },
    ['@text.uri'] = { link = 'Underlined' },
    ['@text.math'] = { link = 'Special' },
    ['@text.environment'] = { link = 'Macro' },
    ['@text.environment.name'] = { link = 'Type' },
    ['@text.reference'] = { link = 'Constant' },
    ['@text.todo'] = { link = 'Todo' },
    ['@text.todo.checked'] = { link = 'WildMenu' },
    ['@text.todo.unchecked'] = { link = 'Statement' },
    ['@text.note'] = { link = 'SpecialComment' },
    ['@text.warning'] = { link = 'WarningMsg' },
    ['@text.danger'] = { link = 'ErrorMsg' },
    ['@text.diff.add'] = { link = 'diffAdded' },
    ['@text.diff.delete'] = { link = 'diffRemoved' },
    ['@tag'] = { link = 'Tag' },
    ['@tag.attribute'] = { link = 'Identifier' },
    ['@tag.delimiter'] = { link = 'Delimiter' },
    ['@punctuation'] = { link = 'Delimiter' },
    ['@macro'] = { link = 'Macro' },
    ['@structure'] = { link = 'Structure' },
    ['@lsp.type.class'] = { link = '@type' },
    ['@lsp.type.comment'] = { link = '@comment' },
    ['@lsp.type.decorator'] = { link = '@macro' },
    ['@lsp.type.enum'] = { link = '@type' },
    ['@lsp.type.enumMember'] = { link = '@constant' },
    ['@lsp.type.function'] = { link = '@function', bold = true },
    ['@lsp.type.interface'] = { link = '@constructor' },
    ['@lsp.type.macro'] = { link = '@macro' },
    ['@lsp.type.method'] = { link = '@method' },
    ['@lsp.type.namespace'] = { link = '@namespace' },
    ['@lsp.type.parameter'] = { link = '@parameter' },
    ['@lsp.type.property'] = { link = '@property' },
    ['@lsp.type.struct'] = { link = '@type' },
    ['@lsp.type.type'] = { link = '@type' },
    ['@lsp.type.typeParameter'] = { link = '@type.definition' },
    ['@lsp.type.variable'] = { link = '@variable' },
  }
end

local ministarter_hl = function()
  local palette = require('phosmon.colorscheme.colors').get_palette()
  local is_light = require('phosmon.config').get_current_mode() == 'light'

  return {
    MiniStarterCurrent = { nocombine = true },
    MiniStarterFooter = { link = 'NonText' },
    MiniStarterHeader = { link = 'FloatTitle' },
    MiniStarterInactive = { link = 'Comment' },
    MiniStarterItem = { link = 'Normal' },
    MiniStarterItemBullet = { link = 'Delimiter' },
    MiniStarterItemPrefix = { bg = false, fg = is_light and palette.purple or palette.yellow },
    MiniStarterSection = { link = 'Delimiter' },
    MiniStarterQuery = { fg = is_light and palette.purple or palette.yellow, bold = true },
  }
end

local fzf_lua_highlights = function()
  local palette = require('phosmon.colorscheme.colors').get_palette()
  local is_light = require('phosmon.config').get_current_mode() == 'light'

  local fzf_hl = {
    FzfLuaBorder = { fg = palette.dark_gray, bg = palette.bg }, -- Dark gray border with the background color
    FzfLuaCursor = 'IncSearch', -- Matches the IncSearch highlighting for consistency
    FzfLuaDirPart = { fg = is_light and palette.mid_gray or palette.dark_gray }, -- Mid gray for directory parts in light mode, dark gray in dark mode
    FzfLuaFilePart = { fg = palette.fg }, -- Normal foreground color for file parts
    FzfLuaFzfCursorLine = 'Visual', -- Uses Visual highlight group for selected lines
    FzfLuaFzfNormal = { fg = palette.fg }, -- Normal text foreground color
    FzfLuaFzfPointer = { fg = is_light and palette.pink or palette.purple }, -- Pink in light mode, purple in dark mode for pointers
    FzfLuaFzfSeparator = { fg = palette.yellow, bg = palette.bg }, -- Yellow separator with the background color
    FzfLuaHeaderBind = '@punctuation.special', -- Special punctuation highlight for header binds
    FzfLuaHeaderText = 'Title', -- Uses Title styling for header text
    FzfLuaNormal = { fg = palette.fg, bg = palette.bg }, -- Normal text with background color
    FzfLuaPath = 'Directory', -- Directory highlight for paths
    FzfLuaPreviewTitle = { fg = is_light and palette.teal or palette.purple, bg = palette.bg }, -- Teal in light mode, purple in dark mode for preview titles
    FzfLuaTitle = { fg = palette.teal, bg = palette.bg }, -- Teal title with background color
  }

  return fzf_hl
end

L.get_base_links = function()
  return base_links()
end

---@description Get treesitter highlights
---@return table "highlights"
L.get_treesitter = function()
  return treesitter_hl()
end

L.get_ministarter = function()
  return ministarter_hl()
end

L.get_fzf_lua = function()
  return fzf_lua_highlights()
end

return L
