local config = require('phosmon.config')
local cmds = require('phosmon.cmds')

local phosmon = {}

function phosmon.set_colors()
  local theme = require('phosmon.colorscheme.theme')
  theme.colorscheme()
end

function phosmon.load()
  cmds.set_commands()

  if config.get_ai_options().enable then
    require("phosmon.ai").setup()
  end
end

phosmon.setup = config.setup

return phosmon
