local model = require("phosmon.ai.services.model")
local olsp = require("phosmon.ai.services.olsp")
local ogen = require("phosmon.ai.services.ogen")

local M = {}

M.setup = function()
  model.start()
  vim.keymap.set('n', '<leader>Pa', olsp.run, {
    noremap = true,
    silent = true,
    desc = require("phosmon.logger").notify_opts.title .. " run LSP",
  })

  vim.keymap.set('v', '<leader>Pg', ogen.run, {
    noremap = true,
    silent = true,
    desc = require("phosmon.logger").notify_opts.title .. " run Gen",
  })
end

return M
