local M = {
  palette = {},
  transparent = false,
  mode = "dark",
  enable = {
    ministarter = true,
    fzf_lua = true
  }
}

--- Set Neovim base for the colorscheme
M.set_theme = function(user_config)
  local p = require('palette')

  if user_config ~= nil then
    M.transparent = user_config.transparent

    if user_config.mode ~= nil then
      if user_config.mode ~= "dark" and user_config.mode ~= "light" then
        vim.notify_once("phosmon.nvim: 'mode' must be 'dark' or 'light'")
      else
        M.mode = user_config.mode
      end
    end

    M.palette = p[M.mode]
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
  vim.o.background = M.mode
end

M.get_current_mode = function()
  return M.mode
end

return M;
