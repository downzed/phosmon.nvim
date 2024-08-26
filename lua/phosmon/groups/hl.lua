local M = {}

M.get_hlgroups = function()
  local options = require('phosmon.config').get_options()
  local palette = require('phosmon.colors').get_palette()

  local highlights = {
    Normal = { bg = palette.bg, fg = palette.fg },
    NonText = { bg = false, fg = palette.dark_gray },
    EndOfBuffer = { bg = false, fg = palette.bg },
    FloatBorder = { bg = false, fg = palette.bg },
    Comment = { fg = options.mode == 'light' and palette.mid_gray or palette.light_gray, italic = true },
    Conceal = { bg = palette.bg, fg = palette.mid_gray },
    Constant = { bg = false, fg = palette.purple },
    Identifier = { bg = false, fg = palette.fg },
    Statement = { bg = false, fg = palette.teal },
    Operator = { bg = false, fg = palette.fg },
    PreProc = { bg = palette.bg, fg = palette.light_gray },
    Type = { bg = false, fg = palette.teal, bold = true },
    Special = { bg = false, fg = palette.light_gray, italic = true },
    Error = { bg = false, fg = palette.red, bold = true },
    Warning = { bg = false, fg = palette.yellow },
    ModeMsg = { bg = false, fg = palette.light_gray },
    Todo = { bg = palette.bg, fg = palette.pink, bold = true },
    Underlined = { bg = false, fg = palette.fg, underline = true },
    StatusLine = { bg = palette.statusline_bg, fg = palette.statusline_fg },
    StatusLineNC = { bg = palette.cursorline_bg, fg = palette.light_gray },
    WildMenu = { bg = palette.cursorline_bg, fg = palette.red },
    VertSplit = { bg = palette.cursorline_bg, fg = palette.dark_gray },
    Title = { bg = false, fg = palette.fg, bold = true },
    LineNr = { bg = false, fg = palette.dark_gray },
    CursorLineNr = { bg = palette.cursorline_bg, fg = palette.purple },
    Cursor = { bg = palette.purple, fg = palette.fg },
    CursorLine = { bg = palette.cursorline_bg, fg = false },
    ColorColumn = { bg = palette.cursorline_bg, fg = false },
    SignColumn = { bg = false, fg = palette.light_gray },
    Visual = { bg = palette.visual_bg, fg = false },
    VisualNOS = { bg = palette.dark_gray, fg = false },
    Pmenu = { bg = palette.statusline_bg, fg = false },
    PmenuSbar = { bg = palette.cursorline_bg, fg = false },
    PmenuSel = { bg = palette.cursorline_bg, fg = palette.purple },
    PmenuThumb = { bg = palette.red, fg = false },
    FoldColumn = { bg = false, fg = palette.light_gray },
    Folded = { bg = palette.visual_bg, fg = palette.light_gray },
    SpecialKey = { bg = false, fg = palette.light_gray },
    IncSearch = { bg = palette.red, fg = palette.bg },
    Search = { bg = palette.purple, fg = palette.bg },
    Directory = { bg = false, fg = palette.purple },
    MatchParen = { bg = false, fg = palette.red, bold = true },
    SpellBad = { bg = false, fg = palette.pink, underline = true },
    SpellCap = { bg = false, fg = palette.teal, underline = true },
    SpellLocal = { bg = false, fg = palette.yellow, underline = true },
    QuickFixLine = { bg = palette.visual_bg, fg = false },
    DiffAdd = { bg = palette.cursorline_bg, fg = palette.teal },
    DiffChange = { bg = palette.cursorline_bg, fg = false },
    DiffDelete = { bg = palette.cursorline_bg, fg = palette.pink },
    DiffText = { bg = palette.cursorline_bg, fg = palette.yellow },
    Function = { bg = false, fg = palette.fg, bold = true },
    helpHyperTextJump = { fg = palette.red, bg = palette.bg },

    -- Treesitter
    ["@none"] = { bg = false, fg = false },
    ["@markup.strong"] = { bold = true },
    ["@markup.underline"] = { underline = true },
    ["@markup.strikethrough"] = { strikethrough = true },
    ["@text.strong"] = { bold = true },
    ["@text.emphasis"] = { italic = true },
    ["@text.underline"] = { underline = true },
    ["@text.strike"] = { strikethrough = true },
  }

  return highlights
end

return M
