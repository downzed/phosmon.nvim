local M = {}

---@description Applying highlights
---@param groups table
---@usage groups = { Character = { bg = "NONE", fg = colors.fg } }
M.apply_highlights = function(groups)
  for hl, props in pairs(groups) do
    vim.api.nvim_set_hl(0, hl, {
      bg = props.bg or "NONE",
      fg = props.fg or "NONE",
      italic = props.italic and true or false,
      bold = props.bold and true or false,
      underline = props.underline and true or false,
      strikethrough = props.strikethrough and true or false,
      link = props.link or nil,
      nocombine = props.nocombine or nil,
    })
  end
end

---@description Applying links
---@param links table
---@usage links = { Character = "Constant" }
M.apply_links = function(links)
  for from, to in pairs(links) do
    vim.api.nvim_set_hl(0, from, { link = to })
  end
end

---@usage `require('phosmon').toggle_opacity()`
M.toggle_opacity = function()
  local default_bg = require("config").palette.normal_bg

  local hl_groups = {
    "Normal",
    "SignColumn",
    "NormalNC",
    "NvimTreeNormal",
    "NvimTreeNormalNC",
    "EndOfBuffer",
    "MsgArea",
  }

  if vim.api.nvim_get_hl(0, { name = "Normal" }).bg == nil then
    for _, name in ipairs(hl_groups) do
      vim.api.nvim_set_hl(0, string.format("%s", name), { bg = default_bg })
    end
  else
    for _, name in ipairs(hl_groups) do
      vim.api.nvim_set_hl(0, string.format("%s", name), { bg = "none" })
    end
  end
end

M.set_hlgroups = function()
  local config = require('config')
  local palette = config.palette

  local highlights = {
    Normal = { bg = palette.normal_bg, fg = palette.normal_fg },
    NonText = { bg = false, fg = palette.linenr_fg },
    EndOfBuffer = { bg = false, fg = palette.normal_bg },
    FloatBorder = { bg = false, fg = palette.normal_bg },
    Comment = { fg = palette.comment_fg, italic = true },
    Conceal = { bg = palette.normal_bg, fg = palette.comment_fg },
    Constant = { bg = false, fg = palette.constant_fg },
    Identifier = { bg = false, fg = palette.normal_fg },
    Statement = { bg = false, fg = palette.statement_fg },
    Operator = { bg = false, fg = palette.normal_fg },
    PreProc = { bg = palette.normal_bg, fg = palette.statement_fg },
    Type = { bg = false, fg = palette.type_fg },
    Special = { bg = false, fg = palette.statement_fg },
    Error = { bg = false, fg = palette.error_fg, bold = true },
    Warning = { bg = false, fg = palette.warning_fg },
    ModeMsg = { bg = false, fg = palette.statement_fg },
    Todo = { bg = palette.normal_bg, fg = palette.todo_fg, bold = true },
    Underlined = { bg = false, fg = palette.normal_fg, underline = true },
    StatusLine = { bg = palette.statusline_bg, fg = palette.constant_fg },
    StatusLineNC = { bg = palette.cursorline_bg, fg = palette.statement_fg },
    WildMenu = { bg = palette.cursorline_bg, fg = palette.error_fg },
    VertSplit = { bg = palette.cursorline_bg, fg = palette.floatborder_bg },
    Title = { bg = false, fg = palette.normal_fg, bold = true },
    LineNr = { bg = false, fg = palette.linenr_fg },
    CursorLineNr = { bg = palette.cursorline_bg, fg = palette.constant_fg },
    Cursor = { bg = palette.constant_fg, fg = palette.normal_fg },
    CursorLine = { bg = palette.cursorline_bg, fg = false },
    ColorColumn = { bg = palette.cursorline_bg, fg = false },
    SignColumn = { bg = false, fg = palette.statement_fg },
    Visual = { bg = palette.statusline_bg, fg = false },
    VisualNOS = { bg = palette.statusline_bg, fg = false },
    Pmenu = { bg = palette.statusline_bg, fg = false },
    PmenuSbar = { bg = palette.cursorline_bg, fg = false },
    PmenuSel = { bg = palette.cursorline_bg, fg = palette.constant_fg },
    PmenuThumb = { bg = palette.error_fg, fg = false },
    FoldColumn = { bg = false, fg = palette.comment_fg },
    Folded = { bg = palette.cursorline_bg_too, fg = palette.statement_fg },
    SpecialKey = { bg = false, fg = palette.statement_fg },
    IncSearch = { bg = palette.error_fg, fg = palette.normal_bg },
    Search = { bg = palette.constant_fg, fg = palette.normal_bg },
    Directory = { bg = false, fg = palette.constant_fg },
    MatchParen = { bg = false, fg = palette.error_fg, bold = true },
    SpellBad = { bg = false, fg = palette.todo_fg, underline = true },
    SpellCap = { bg = false, fg = palette.statusline_bgish_green, underline = true },
    SpellLocal = { bg = false, fg = palette.warning_fg, underline = true },
    QuickFixLine = { bg = palette.cursorline_bg_too, fg = false },
    DiffAdd = { bg = palette.cursorline_bg, fg = palette.statusline_bgish_green },
    DiffChange = { bg = palette.cursorline_bg, fg = false },
    DiffDelete = { bg = palette.cursorline_bg, fg = palette.todo_fg },
    DiffText = { bg = palette.cursorline_bg, fg = palette.warning_fg },
    Function = { bg = false, fg = palette.normal_fg, bold = true },
    helpHyperTextJump = { fg = palette.error_fg, bg = palette.normal_bg },

    -- TS
    ["@none"] = { bg = false, fg = false },
    ["@markup.strong"] = { bold = true },
    ["@markup.underline"] = { underline = true },
    ["@markup.strikethrough"] = { strikethrough = true },
    ["@text.strong"] = { bold = true },
    ["@text.emphasis"] = { italic = true },
    ["@text.underline"] = { underline = true },
    ["@text.strike"] = { strikethrough = true },
  }

  local l = require("links")
  M.apply_highlights(highlights)
  M.apply_highlights(l.ministarter_hl)
  M.apply_links(l.links)

  if config.transparent then
    M.toggle_opacity()
  end
end

M.toggle_dark_mode = function()
  if vim.o.background == "dark" then
    vim.o.background = "light"
    require("config").palette = require("palette").light
  else
    vim.o.background = "dark"
    require("config").palette = require("palette").dark
  end
end

return M
