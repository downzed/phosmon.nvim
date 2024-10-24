local M = {}

---@class Options
M.defaults = {
  transparent = false,
  mode = "dark",
  custom_colors = nil,
  colorscheme = {
    enable = true
  },
  ai = {
    enable = true,
    model = "codegeex4",
    port = "11434"
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

M.get_is_colorscheme_enabled = function()
  return M.options.colorscheme.enable or M.defaults.colorscheme.enable
end

M.get_ai_options = function()
  return M.options.ai or M.defaults.ai
end

M.set_ai_model = function(model)
  M.options.ai.model = model
end

M.get_ai_model = function()
  return M.options.ai and M.options.ai.model or M.defaults.ai.model
end

M.set_ai_options = function(opts)
  M.options.ai = vim.tbl_extend('force', M.options.ai, opts)
end

M.get_options = function()
  return M.options
end

return M;
