local M = {}

---@class Options
M.defaults = {
  transparent = false,
  mode = "dark",
  custom_colors = nil,
  extra = {
    olsp = true
  },
  enable = {
    ministarter = true,
    fzf_lua = true
  },
}

---@type Options
M.options = {}

local modes = { "dark", "light", "photon" }

---description: Validate phosmon mode
local function validate_mode(mode)
  if not vim.tbl_contains(modes, mode) then
    vim.notify_once("phosmon.nvim: invalid mode '" .. mode .. "', defaulting to 'dark'")
    return M.defaults.mode
  end

  return mode
end

---description: Setup phosmon
M.setup = function(user_config)
  M.options = vim.tbl_deep_extend('force', M.defaults, user_config or {})
end

---description: Sets phosmon mode
M.set_mode = function(mode)
  M.options.mode = mode
end

---description: Get current phosmon mode
M.get_current_mode = function()
  return validate_mode(M.options.mode)
end

---description: Get phosmon options
M.get_options = function()
  return M.options
end

return M;
