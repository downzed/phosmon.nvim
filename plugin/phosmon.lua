-- You can use this loaded variable to enable conditional parts of your plugin.
if _G.Phosmon then
  return
end

_G.Phosmon = true

require('phosmon').load()
