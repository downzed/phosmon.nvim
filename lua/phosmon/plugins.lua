local plugins = {}

--- @name Phosmon lualine theme
--- @description load colorscheme based on current mode
--- @return table
plugins.load_lualine = function()
  local p = require("phosmon.colors").get_palette()
  local m = require("phosmon.config").get_current_mode()

  local phosmon = {
    dark = {
      normal = {
        a = { bg = p.bg, fg = p.fg, gui = "bold" },
        b = { bg = p.dark_gray, fg = p.light_gray },
        c = { bg = p.light_gray, fg = p.bg },
        z = { bg = p.bg, fg = p.light_gray },
      },
      insert = {
        a = { bg = p.bg, fg = p.purple, gui = "bold" },
        b = { bg = p.statusline_bg, fg = p.light_gray },
        c = { bg = p.light_gray, fg = p.fg },
        z = { bg = p.bg, fg = p.light_gray },
      },
      inactive = {
        a = { bg = p.statusline_bg, fg = p.light_gray },
        b = { bg = p.statusline_bg, fg = p.light_gray },
        c = { bg = p.statusline_bg, fg = p.light_gray },
        z = { bg = p.bg, fg = p.light_gray },
      },
    },
    light = {
      normal = {
        a = { bg = p.visual_bg, fg = p.purple, gui = "bold" },
        b = { bg = p.light_gray, fg = p.dark_gray },
        c = { bg = p.cursorline_bg, fg = p.mid_gray },
        z = { bg = p.visual_bg, fg = p.mid_gray },
      },
      insert = {
        a = { bg = p.dark_gray, fg = p.purple, gui = "bold" },
        b = { bg = p.mid_gray, fg = p.dark_gray },
        c = { bg = p.cursorline_bg, fg = p.fg },
        z = { bg = p.visual_bg, fg = p.light_gray },
      },
      inactive = {
        a = { bg = p.statusline_bg, fg = p.light_gray },
        b = { bg = p.statusline_bg, fg = p.light_gray },
        c = { bg = p.statusline_bg, fg = p.light_gray },
        z = { bg = p.bg, fg = p.light_gray },
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

return plugins
