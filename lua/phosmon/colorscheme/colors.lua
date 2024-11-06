local M = {}

local palettes = {
  photon = {
    fg = '#c6c6c6',
    bg = '#262626',
    dark_gray = '#3a3a3a',
    light_gray = '#8a8a8a',
    purple = '#af87d7',
    teal = '#87a8a8',
    red = '#d75f5f',
    yellow = '#d7af5f',
    pink = '#d75f87',
    statusline_bg = '#2e2e2e',
    statusline_fg = '#af87d7',
    cursorline_bg = '#2e2e2e',
    visual_bg = '#444444',
    search_fg = '#f2f2f2',
    incsearch_bg = '#d75f5f',
    search_bg = '#af87d7',
    sign_fg = '#767676',
    diff_add_fg = '#87af87',
    diff_change_fg = '#303030',
    diff_delete_fg = '#d75f87',
    diff_text_fg = '#d7af5f',
  },
  dark = {
    fg = '#d0d0d0', -- Slightly brighter muted white for text (more contrast)
    bg = '#1c1c1c', -- Slightly softened black-gray background
    dark_gray = '#3e3e3e', -- Dark gray, slightly lighter for better contrast
    light_gray = '#909090', -- Light gray, muted for less contrast
    purple = '#a680a6', -- Softer purple, maintaining subtlety
    teal = '#4a94b3', -- Muted teal with a touch of calmness
    red = '#c57070', -- Warm, soft red to avoid eye strain
    yellow = '#c8c89a', -- Muted yellow, softer and warmer
    pink = '#c0708f', -- Soft pink with reduced intensity
    statusline_bg = '#2c2c2c', -- Slightly lighter for reduced contrast
    statusline_fg = '#a680a6', -- Softer purple for statusline text
    cursorline_bg = '#2c2c2c', -- Same as statusline background for consistency
    visual_bg = '#2d3a56', -- Keep the slightly muted dark blue for visual selection
    search_fg = '#e0e0e0', -- Slightly muted white for search text
    incsearch_bg = '#c57070', -- Warm, soft red for incremental search background
    search_bg = '#4a94b3', -- Muted teal with a calmer tone for search background
    sign_fg = '#707070', -- Softer gray for sign column
    diff_add_fg = '#6a9a60', -- Muted green with a slight warmth for added lines
    diff_change_fg = '#3e3e3e', -- Dark gray for changes, slightly lightened
    diff_delete_fg = '#c57070', -- Warm, soft red for deletions
    diff_text_fg = '#c8c89a', -- Muted yellow for changed text, warmer tone
  },

  light = {
    fg = '#4a4a4a', -- Slightly darker gray for text (balanced contrast)
    bg = '#f7f7f7', -- Slightly warmer off-white background
    dark_gray = '#808080', -- Balanced dark gray for contrast
    light_gray = '#c8c8c8', -- Light gray for secondary elements
    mid_gray = '#b0b0b0', -- Mid gray with a little more contrast
    purple = '#9a7fd6', -- Softened purple with a touch of warmth
    teal = '#4a90a4', -- Muted teal with less blue, more neutral
    red = '#d88a8a', -- Warm, soft red for a gentle pop
    yellow = '#d6aa5f', -- Warm yellow, balanced for legibility
    pink = '#d68fa3', -- Softened pink, less intense
    statusline_bg = '#e0e0e0', -- Light gray for statusline background
    statusline_fg = '#8f81b6', -- Softer purple for statusline text
    cursorline_bg = '#ececec', -- Warmer light gray for cursor line background
    visual_bg = '#e1ebf2', -- Light blue-gray with a hint of warmth for visual selection
    search_fg = '#4a4a4a', -- Balanced dark gray for search text
    incsearch_bg = '#d88a8a', -- Warm, soft red for incremental search background
    search_bg = '#4a90a4', -- Muted teal with a more neutral tone for search background
    sign_fg = '#a0a0a0', -- Softer gray for sign column
    diff_add_fg = '#86d6a1', -- Warm, muted green for added lines
    diff_change_fg = '#c0c0c0', -- Light gray for changes
    diff_delete_fg = '#d68fa3', -- Softened pink for deletions
    diff_text_fg = '#d6aa5f', -- Warm yellow for changed text
  },
}

M.get_palette = function()
  local config = require('phosmon.config')
  local palette = palettes[config.get_current_mode()]
  return palette
end

return M
