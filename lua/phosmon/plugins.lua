local plugins = {}

--- @name Phosmon lualine theme
--- @description load colorscheme based on current mode
--- @return table
plugins.load_lualine = function()
  local p = require("phosmon.colors").get_palette()
  local c = require("phosmon.config")
  local is_transparent = c.get_options().transparent

  local phosmon = {
    dark = {
      normal = {
        a = { bg = p.dark_gray, fg = p.fg, gui = "bold" },                 -- Dark gray background, soft white text
        b = { bg = p.statusline_bg, fg = p.light_gray },                   -- Statusline background with light gray text
        c = { bg = is_transparent and "none" or p.bg, fg = p.light_gray }, -- Background color with light gray text
        z = { bg = p.dark_gray, fg = p.fg },                               -- Dark gray background, soft white text at end
      },
      insert = {
        a = { bg = p.teal, fg = p.bg, gui = "bold" },              -- Teal background, dark background text
        b = { bg = p.statusline_bg, fg = p.light_gray },           -- Consistent with normal mode
        c = { bg = is_transparent and "none" or p.bg, fg = p.fg }, -- Background color with light gray text
        z = { bg = p.teal, fg = p.bg },                            -- Teal background, dark background text at end
      },
      inactive = {
        a = { bg = p.statusline_bg, fg = p.dark_gray }, -- Muted colors for inactive mode
        b = { bg = p.statusline_bg, fg = p.dark_gray }, -- Consistent with section `a`
        c = { bg = p.statusline_bg, fg = p.dark_gray }, -- Uniformity across inactive sections
        z = { bg = p.bg, fg = p.dark_gray },            -- Dark gray text on background for inactive `z`
      },
    },
    light = {
      normal = {
        a = { bg = p.light_gray, fg = p.teal, gui = "bold" }, -- Subtle contrast, teal stands out without being too harsh
        b = { bg = p.visual_bg, fg = p.dark_gray },           -- Softer background with less intense dark gray
        c = { bg = p.bg, fg = p.mid_gray },                   -- Mid-gray for a more balanced contrast
        z = { bg = p.visual_bg, fg = p.teal },                -- Teal for a slight emphasis on the end of the statusline
      },
      insert = {
        a = { bg = p.light_gray, fg = p.statusline_fg, gui = "bold" }, -- Softer purple to reduce eye strain
        b = { bg = p.statusline_bg, fg = p.dark_gray },                -- Statusline background with less contrast
        c = { bg = p.bg, fg = p.mid_gray },                            -- Mid-gray for consistency across modes
        z = { bg = p.visual_bg, fg = p.teal },                         -- Teal for continuity with normal mode
      },
      inactive = {
        a = { bg = p.statusline_bg, fg = p.mid_gray }, -- Softer contrast for inactive mode
        b = { bg = p.statusline_bg, fg = p.mid_gray }, -- Keep background and foreground consistent
        c = { bg = p.statusline_bg, fg = p.mid_gray }, -- Maintain uniformity in inactive mode
        z = { bg = p.bg, fg = p.light_gray },          -- Subtle contrast for the end of the statusline
      },
    }
  }

  local mode = c.get_current_mode()
  local m = mode == "photon" and "dark" or mode

  phosmon[m].visual = phosmon[m].insert
  phosmon[m].replace = phosmon[m].insert
  phosmon[m].command = phosmon[m].insert

  local ok, _ = pcall(require, 'lualine')
  if ok then
    return phosmon[m]
  end
end

return plugins
