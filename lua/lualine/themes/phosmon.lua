local palette = require("phosmon").palette

local phosmon = {
  normal = {
    a = { bg = palette.normal_bg, fg = palette.normal_fg, gui = "bold" },
    b = { bg = palette.statusline_bg, fg = palette.comment_fg },
    c = { bg = palette.comment_fg, fg = palette.normal_bg },
    z = { bg = palette.normal_bg, fg = palette.comment_fg },
  },
  insert = {
    a = { bg = palette.normal_bg, fg = palette.constant_fg, gui = "bold" },
    b = { bg = palette.statusline_bg, fg = palette.comment_fg },
    c = { bg = palette.comment_fg, fg = palette.normal_fg },
    z = { bg = palette.normal_bg, fg = palette.comment_fg },
  },
  inactive = {
    a = { bg = palette.statusline_bg, fg = palette.comment_fg },
    b = { bg = palette.statusline_bg, fg = palette.comment_fg },
    c = { bg = palette.statusline_bg, fg = palette.comment_fg },
    z = { bg = palette.normal_bg, fg = palette.comment_fg },
  },
}

phosmon.visual = phosmon.insert
phosmon.replace = phosmon.insert
phosmon.command = phosmon.insert

return phosmon
