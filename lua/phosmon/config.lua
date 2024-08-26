local M = {
  options = {},
  defaults = {
    transparent = false,
    mode = "dark",
    custom_colors = nil,
    enable = {
      ministarter = true,
      fzf_lua = false
    },
  }
}

M.setup = function(user_config)
  M.options = vim.tbl_deep_extend('force', M.defaults, user_config or {})
end

-- Function to get the current mode (dark or light)
M.get_current_mode = function()
  return M.options.mode
end

M.get_options = function()
  return M.options
end

return M;
