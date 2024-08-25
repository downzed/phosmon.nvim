local config = require('phosmon.config')
local theme = require('phosmon.theme')
local cmds = require('phosmon.cmds')

local phosmon = {}

function phosmon.load()
  theme.colorscheme()
  cmds.set_commands()
end

phosmon.setup = config.setup

return phosmon
