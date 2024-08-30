local config = require('phosmon.config')
local theme = require('phosmon.colorscheme.theme')
local cmds = require('phosmon.cmds')

local phosmon = {}

function phosmon.load()
  theme.colorscheme()
  cmds.set_commands()

  if config.get_ai_options().enable then
    require("phosmon.ai").setup()
  end
end

phosmon.setup = config.setup

return phosmon
