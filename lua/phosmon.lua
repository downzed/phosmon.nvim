local utils = require('utils')
local cmds = require('cmds')

local phosmon = {}

phosmon.setup = function(user_config)
  local config = require('config')
  config.set_theme(user_config or nil)
  utils.set_hlgroups()

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "none",
  })

  cmds.set_commands()
  phosmon.palette = config.palette
end

phosmon.toggle_opacity = utils.toggle_opacity

return phosmon
