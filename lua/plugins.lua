local plugins = {}

--- @name Phosmon lualine theme
--- @description load colorscheme based on current mode
--- @return table
plugins.load_lualine = function()
  local p = require("config").palette
  local m = require("config").get_current_mode()

  local phosmon = {
    dark = {
      normal = {
        a = { bg = p.normal_bg, fg = p.normal_fg, gui = "bold" },
        b = { bg = p.floatborder_bg, fg = p.comment_fg },
        c = { bg = p.comment_fg, fg = p.normal_bg },
        z = { bg = p.normal_bg, fg = p.comment_fg },
      },
      insert = {
        a = { bg = p.normal_bg, fg = p.constant_fg, gui = "bold" },
        b = { bg = p.statusline_bg, fg = p.comment_fg },
        c = { bg = p.comment_fg, fg = p.normal_fg },
        z = { bg = p.normal_bg, fg = p.comment_fg },
      },
      inactive = {
        a = { bg = p.statusline_bg, fg = p.comment_fg },
        b = { bg = p.statusline_bg, fg = p.comment_fg },
        c = { bg = p.statusline_bg, fg = p.comment_fg },
        z = { bg = p.normal_bg, fg = p.comment_fg },
      },
    },
    light = {
      normal = {
        a = { bg = p.visual_bg, fg = p.constant_fg, gui = "bold" },
        b = { bg = p.pmenusb_bg, fg = p.todo_fg },
        c = { bg = p.cursorline_bg, fg = p.comment_fg },
        z = { bg = p.visual_bg, fg = p.comment_fg },
      },
      insert = {
        a = { bg = p.pmenusb_bg, fg = p.constant_fg, gui = "bold" },
        b = { bg = p.cursorline_bg, fg = p.comment_fg },
        c = { bg = p.cursorline_bg, fg = p.normal_fg },
        z = { bg = p.visual_bg, fg = p.comment_fg },
      },
      inactive = {
        a = { bg = p.statusline_bg, fg = p.comment_fg },
        b = { bg = p.statusline_bg, fg = p.comment_fg },
        c = { bg = p.statusline_bg, fg = p.comment_fg },
        z = { bg = p.normal_bg, fg = p.comment_fg },
      },
    },
  }

  phosmon[m].visual = phosmon[m].insert
  phosmon[m].replace = phosmon[m].insert
  phosmon[m].command = phosmon[m].insert

  local ok, _ = pcall(require, 'lualine')
  if ok then
    return phosmon[m]
  end
end

plugins.load_fzflua = function()
  local ok, _ = pcall(require, 'fzf-lua')
  if not ok then
    return
  end

  local palette = require('config').palette

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

  print(vim.inspect(fzf_lua_highlights))
  require('utils').apply_highlights(fzf_lua_highlights)
end

return plugins
