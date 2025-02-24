local logger = require('phosmon.logger')
local model = require('phosmon.ai.services.model')
local ogen = require('phosmon.ai.services.ogen')
local olsp = require('phosmon.ai.services.olsp')

local M = {}

local map_keys = function(mode, keys, func, desc)
  vim.keymap.set(mode, keys, func, {
    noremap = true,
    silent = true,
    desc = logger.notify_opts.title .. ' ' .. desc,
  })
end

M.setup = function()
  if not os.getenv('OLLAMA_HOST') then
    logger.error('OLLAMA_HOST is not set')
    logger.info('Please set OLLAMA_HOST in your environment files')
    return
  end

  model.start()

  map_keys('n', '<leader>Pl', olsp.run, '[L]SP')

  -- Code generation keybinds
  local mappings = {
    {
      'v',
      '<leader>Pd',
      function()
        ogen.run('docstring')
      end,
      '[D]ocstring',
    },
    {
      'v',
      '<leader>Pt',
      function()
        ogen.run('testsuite')
      end,
      '[T]estsuite',
    },
    {
      'v',
      '<leader>Ps',
      function()
        ogen.run('tsinterface')
      end,
      'Type[S]cript Interface',
    },
    {
      'v',
      '<leader>Pr',
      function()
        ogen.run('refactor')
      end,
      '[R]efactor',
    },
  }

  -- Apply all mappings
  for _, map in ipairs(mappings) do
    map_keys(map[1], map[2], map[3], map[4])
  end
end

return M
