local Utils = {}

---@description Applying highlights
---@param groups table
---@usage groups = { Character = { bg = "NONE", fg = colors.fg } }
Utils.apply_highlights = function(groups)
  for hl, props in pairs(groups) do
    vim.api.nvim_set_hl(0, hl, {
      bg = props.bg or "NONE",
      fg = props.fg or "NONE",
      italic = props.italic == true,
      bold = props.bold == true,
      underline = props.underline == true,
      strikethrough = props.strikethrough == true,
      link = props.link,
      nocombine = props.nocombine,
    })
  end
end

--- @name phosmon toggle opacity
--- @usage `require('phosmon').toggle_opacity()`
Utils.toggle_opacity = function()
  if require("config").mode == "light" then
    vim.notify_once("phosmon.nvim: can't toggle opacity in light mode")
    return
  end
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

Utils.set_hlgroups = function()
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
    Type = { bg = false, fg = palette.type_fg, bold = true },
    Special = { bg = false, fg = palette.statement_fg, italic = true },
    Error = { bg = false, fg = palette.error_fg, bold = true },
    Warning = { bg = false, fg = palette.warning_fg },
    ModeMsg = { bg = false, fg = palette.statement_fg },
    Todo = { bg = palette.normal_bg, fg = palette.todo_fg, bold = true },
    Underlined = { bg = false, fg = palette.normal_fg, underline = true },
    StatusLine = { bg = palette.statusline_bg, fg = palette.statusline_fg },
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
    Visual = { bg = palette.visual_bg, fg = false },
    VisualNOS = { bg = palette.visualnos_bg, fg = false },
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
  local hl_groups = vim.tbl_extend("force", highlights, l.get_base_links())

  if config.enable.fzf_lua then
    hl_groups = vim.tbl_extend("force", hl_groups, l.get_fzf_lua())
  end

  if config.enable.ministarter then
    hl_groups = vim.tbl_extend("force", hl_groups, l.get_ministarter())
  end

  Utils.apply_highlights(hl_groups)

  if config.transparent then
    Utils.toggle_opacity()
  end
  if config.transparent then
    Utils.toggle_opacity()
  end
  if config.cursor_pulse then
    Utils.toggle_cursor_pulse()
  end
end

Utils.toggle_dark_mode = function()
  local mode = ""
  if vim.o.background == "dark" then
    mode = "light"
  else
    mode = "dark"
  end

  vim.o.background = mode
  require("config").mode = mode
  require("config").palette = require("palette")[mode]

  Utils.set_hlgroups()
end

local is_pulse_on = false
Utils.toggle_cursor_pulse = function()
  -- Define highlight groups
  if is_pulse_on then
    vim.api.nvim_set_hl(0, 'Cursor', { link = 'CursorNormal' })
    is_pulse_on = false
    return
  end
  local p = require("config").palette
  vim.api.nvim_set_hl(0, 'CursorNormal', { fg = '#c6c6c6', bg = '#af87d7' })
  vim.api.nvim_set_hl(0, 'CursorPulse', { fg = '#c6c6c6', bg = '#d7af87' })

  -- Toggle function

  local function toggle_cursor_pulse()
    if is_pulse_on then
      vim.api.nvim_set_hl(0, 'Cursor', { link = 'CursorNormal' })
    else
      vim.api.nvim_set_hl(0, 'Cursor', { link = 'CursorPulse' })
    end
    is_pulse_on = not is_pulse_on
  end

  -- Timer setup
  local pulse_interval = 500 -- 500ms pulse interval
  local pulse_timer = vim.loop.new_timer()

  pulse_timer:start(0, pulse_interval, vim.schedule_wrap(function()
    toggle_cursor_pulse()
  end))

  -- Stop the timer on exit
  vim.cmd([[
    autocmd VimLeavePre * lua pulse_timer:stop()
]])
end

return Utils
