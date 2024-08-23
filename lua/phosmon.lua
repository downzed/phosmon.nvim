local utils = require('utils')
local cmds = require('cmds')

local phosmon = {}

phosmon.setup = function(user_config)
  require('config').set_theme(user_config or nil)

  utils.set_hlgroups()

  cmds.set_commands()

  phosmon.palette = require('config').palette
end

phosmon.toggle_opacity = utils.toggle_opacity
phosmon.toggle_dark_mode = utils.toggle_dark_mode

return phosmon
