local model = require("phosmon.ai.capabilities.model")
local olsp = require("phosmon.ai.capabilities.olsp")
local ogen = require("phosmon.ai.capabilities.ogen")

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
