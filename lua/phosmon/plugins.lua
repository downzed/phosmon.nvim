local plugins = {}

--- @name Phosmon lualine theme
--- @description load colorscheme based on current mode
--- @return table
plugins.load_lualine = function()
  local p = require("phosmon.colors").get_palette()
  local c = require("phosmon.config")
  local m = c.get_current_mode()
  local is_transparent = c.get_options().transparent

  local phosmon = {
    dark = {
      normal = {
        a = { bg = p.bg, fg = p.fg, gui = "bold" },
        b = { bg = p.dark_gray, fg = p.light_gray },
        c = { bg = is_transparent and "none" or p.light_gray, fg = is_transparent and p.light_gray or p.bg },
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
        a = { bg = p.mid_gray, fg = p.teal, gui = "bold" },
        b = { bg = p.light_gray, fg = p.dark_gray },
        c = { bg = p.cursorline_bg, fg = p.teal },
        z = { bg = p.visual_bg, fg = p.mid_gray },
      },
      insert = {
        a = { bg = p.light_gray, fg = p.purple, gui = "bold" },
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
