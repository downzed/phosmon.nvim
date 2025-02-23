local model = require('phosmon.ai.services.model')
local ogen = require('phosmon.ai.services.ogen')
local olsp = require('phosmon.ai.services.olsp')

local M = {}

M.setup = function()
  model.start()
  vim.keymap.set('n', '<leader>Pl', olsp.run, {
    noremap = true,
    silent = true,
    desc = require('phosmon.logger').notify_opts.title .. ' [L]SP',
  })

  vim.keymap.set('v', '<leader>Pd', function()
    ogen.run('docstring')
  end, {
    noremap = true,
    silent = true,
    desc = require('phosmon.logger').notify_opts.title .. ' [D]ocstring',
  })

  vim.keymap.set('v', '<leader>Pt', function()
    ogen.run('testsuite')
  end, {
    noremap = true,
    silent = true,
    desc = require('phosmon.logger').notify_opts.title .. ' [T]estsuite',
  })

  vim.keymap.set('v', '<leader>Ps', function()
    ogen.run('tsinterface')
  end, {
    noremap = true,
    silent = true,
    desc = require('phosmon.logger').notify_opts.title .. ' Type[S]cript Interface',
  })
  vim.keymap.set('v', '<leader>Pr', function()
    ogen.run('refactor')
  end, {
    noremap = true,
    silent = true,
    desc = require('phosmon.logger').notify_opts.title .. ' [R]efactor',
  })
end

return M
