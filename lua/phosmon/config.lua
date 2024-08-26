local M = {
  options = {},
  defaults = {
    transparent = false,
    mode = "dark",
    custom_colors = nil,
    enable = {
      ministarter = true,
      fzf_lua = true
    },
  }
}

M.setup = function(user_config)
  M.options = vim.tbl_deep_extend('force', M.defaults, user_config or {})
end

---@description Set phosmon mode
---@param mode "dark" | "light" | "photon"
M.set_mode = function(mode)
  M.options.mode = mode
end
---@description Get current phosmon mode
---@return "dark" | "light" | "photon"
M.get_current_mode = function()
  return M.options.mode
end

---@description Get phosmon options
---@return table
M.get_options = function()
  return M.options
end

return M;
