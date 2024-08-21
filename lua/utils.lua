local M = {}

---@description Applying highlights
---@param groups table
---@usage groups = { Character = { bg = "NONE", fg = colors.fg } }
M.apply_highlights = function(groups)
  for hl, props in pairs(groups) do
    vim.api.nvim_set_hl(0, hl, props)
  end
end

---@description Applying links
---@param links table
---@usage links = { Character = "Constant" }
M.apply_links = function(links)
  for from, to in pairs(links) do
    vim.api.nvim_set_hl(0, from, { link = to })
  end
end

--- Set Neovim base for the colorscheme
M.set_theme = function()
  if vim.version().minor < 9 then
    vim.notify_once("phosmon.nvim: you must use neovim 0.9 or higher")
    return
  end

  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end
  if vim.g.colors_name then
    vim.cmd.hi("clear")
  end
  vim.g.colors_name = "phosmon"
  vim.o.termguicolors = true
  vim.o.background = "dark"
end

---@description Toggle opacity, if bg is nil, default bg is #262626
---@param? bg string
---@usage bg = "#262626"
M.toggle_opacity = function(bg)
  local default_bg = "#262626"

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
      vim.api.nvim_set_hl(0, string.format("%s", name), { bg = bg or default_bg })
    end
  else
    for _, name in ipairs(hl_groups) do
      vim.api.nvim_set_hl(0, string.format("%s", name), { bg = "none" })
    end
  end
end

return M
