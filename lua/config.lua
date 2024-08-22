local M = {
  palette = {},
  transparent = false
}

--- Set Neovim base for the colorscheme
M.set_theme = function(user_config)
  local p = require('palette')
  local palette = p.dark
  local vim_bg = "dark"

  if user_config ~= nil then
    M.transparent = user_config.transparent

    if user_config.light then
      palette = p.light
      vim_bg = "light"
    end
    M.palette = palette
  end


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
  vim.o.background = vim_bg
end

return M;
