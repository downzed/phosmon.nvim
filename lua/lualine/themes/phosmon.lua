local colors = require("phosmon").colors

local common_bg = colors.bg
-- config.transparent and "NONE" or colors.bg
local bold_fg = true
-- config.bold and "bold" or "NONE"

local phosmon = {
  normal = {
    a = { bg = common_bg, fg = colors.fg, gui = "bold" },
    b = { bg = colors.dark_gray, fg = colors.comment },
    c = { bg = colors.comment, fg = colors.bg },
    z = { bg = common_bg, fg = colors.comment },
  },
  insert = {
    a = { bg = common_bg, fg = colors.constant, gui = "bold" },
    b = { bg = colors.dark_gray, fg = colors.fg },
    c = { bg = colors.comment, fg = colors.fg },
    z = { bg = common_bg, fg = colors.comment },
  },
  inactive = {
    a = { bg = colors.dark_gray, fg = colors.comment },
    b = { bg = colors.dark_gray, fg = colors.comment },
    c = { bg = colors.dark_gray, fg = colors.comment },
    z = { bg = common_bg, fg = colors.comment },
  },
}

phosmon.visual = phosmon.insert
phosmon.replace = phosmon.insert
phosmon.command = phosmon.insert

return phosmon
