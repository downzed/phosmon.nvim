local config = require("phosmon.config")
local M = {}

M.colorscheme = function()
  if vim.version().minor < 9 then
    vim.notify_once("phosmon.nvim: you must use neovim 0.9 or higher")
    return
  end
  vim.cmd("hi clear")

  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end
  local mode = require("phosmon.config").get_current_mode()

  vim.o.background = mode == "photon" and "dark" or mode
  vim.o.termguicolors = true
  vim.g.colors_name = "phosmon"

  require("phosmon.highlight").set_hlgroups()

  if config.options.transparent then
    M.toggle_opacity()
  end
end

M.select_mode = function()
  local modes = { "dark", "light", "photon" }
  local current_mode = config.get_current_mode()
  vim.ui.select(modes, {
    prompt = "Phosmon mode",
    format_item = function(item)
      return (item == current_mode and item .. " (current)" or item)
    end
  }, function(choice)
    if choice then
      require("phosmon.config").set_mode(choice)
      vim.o.background = choice == "photon" and "dark" or choice
      require("phosmon.highlight").set_hlgroups()
    end
  end)
end

M.toggle_dark_mode = function()
  local mode = config.get_current_mode()
  local m = mode

  if mode == "dark" then
    m = "light"
  else
    m = "dark"
  end

  require("phosmon.config").set_mode(m)
  vim.o.background = m
  require("phosmon.highlight").set_hlgroups()
end

--- @name phosmon toggle opacity
M.toggle_opacity = function()
  if require("phosmon.config").get_current_mode() == "light" then
    vim.notify_once("phosmon.nvim: can't toggle opacity in light mode")
    return
  end

  local default_bg = require("phosmon.colors").get_palette().bg

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

  ok, lualine = pcall(require, "lualine")
  if ok then
    lualine.refresh()
  end
end

return M