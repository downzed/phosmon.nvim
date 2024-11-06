local model = require('phosmon.ai.services.model')
local ogen = require('phosmon.ai.services.ogen')
local olsp = require('phosmon.ai.services.olsp')

local M = {}

M.setup = function()
  model.start()
  vim.keymap.set('n', '<leader>Pa', olsp.run, {
    noremap = true,
    silent = true,
    desc = require('phosmon.logger').notify_opts.title .. ' run LSP',
  })

  vim.keymap.set('v', '<leader>Pd', function()
    ogen.run('docstring')
  end, {
    noremap = true,
    silent = true,
    desc = require('phosmon.logger').notify_opts.title .. ' [D]ocstring Gen',
  })

  vim.keymap.set('v', '<leader>Pt', function()
    ogen.run('testsuite')
  end, {
    noremap = true,
    silent = true,
    desc = require('phosmon.logger').notify_opts.title .. ' [T]estsuite Gen',
  })

  vim.keymap.set('v', '<leader>Ps', function()
    ogen.run('tsinterface')
  end, {
    noremap = true,
    silent = true,
    desc = require('phosmon.logger').notify_opts.title .. ' Type[S]cript Interface Gen',
  })
end

return M
