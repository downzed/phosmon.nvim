local M = {}

local palettes = {
  dark = {
    fg = "#c6c6c6",
    bg = "#2a2a2a",
    dark_gray = "#3a3a3a",
    light_gray = "#8a8a8a",
    purple = "#af87d7",
    teal = "#87a8a8",
    red = "#d75f5f",
    yellow = "#d7af5f",
    pink = "#d75f87",
    statusline_bg = "#2e2e2e",
    statusline_fg = "#af87d7",
    cursorline_bg = "#2e2e2e",
    visual_bg = "#444444",
    search_fg = "#f2f2f2",
    incsearch_bg = "#d75f5f",
    search_bg = "#af87d7",
    sign_fg = "#767676",
    diff_add_fg = "#87af87",
    diff_change_fg = "#303030",
    diff_delete_fg = "#d75f87",
    diff_text_fg = "#d7af5f",
  },

  light = {
    fg = "#262626",
    bg = "#f2f2f2",
    dark_gray = "#9a9a9a",
    light_gray = "#d8d8d8",
    mid_gray = "#c0c0c0",
    purple = "#875fd7",
    teal = "#5f8787",
    red = "#d75f5f",
    yellow = "#d7af5f",
    pink = "#d75fa7",
    statusline_bg = "#e8e8e8",
    statusline_fg = "#875fd7",
    cursorline_bg = "#e8e8e8",
    visual_bg = "#d8d8d8",
    search_fg = "#f2f2f2",
    incsearch_bg = "#d75f5f",
    search_bg = "#875fd7",
    sign_fg = "#767676",
    diff_add_fg = "#afdab7",
    diff_change_fg = "#e0e0e0",
    diff_delete_fg = "#d75fa7",
    diff_text_fg = "#d7af5f",
  }
}

M.get_palette = function()
  local config = require("phosmon.config")
  local palette = palettes[config.get_options().mode]
  -- if options.custom_colors then
  --   return vim.tbl_deep_extend("force", palette, options.custom_colors)
  -- end
  return palette
end

return M
