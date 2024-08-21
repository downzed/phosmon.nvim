local M = {}

M.apply_highlights = function(hl)
  for group, properties in pairs(hl) do
    vim.api.nvim_set_hl(0, group, properties)
  end
end

M.apply_links = function(links)
  for from, to in pairs(links) do
    vim.api.nvim_set_hl(0, from, { link = to })
  end
end

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
  -- Set Neovim background color
  vim.o.background = "dark"
end

M.toggle_opacity = function(colors)
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
      vim.api.nvim_set_hl(0, string.format("%s", name), { bg = colors.bg })
    end
  else
    for _, name in ipairs(hl_groups) do
      vim.api.nvim_set_hl(0, string.format("%s", name), { bg = "none" })
    end
  end
end

return M
