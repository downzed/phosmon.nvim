package.path = package.path .. ';./lua/?.lua;./lua/phosmon/?.lua'
local logger = require('phosmon.logger.init')

describe('log function', function()
  -- Mock vim.notify to capture its output
  local notify_output = nil
  before_each(function()
    _G.vim = _G.vim or {} -- Ensure `vim` exists for testing
    vim.notify = function(msg, level, opts)
      notify_output = msg -- Capture the last notification message
    end
  end)

  it('should log a message', function()
    local msg = 'Hello, world!'
    logger.info(msg) -- Call the function

    -- Check that the logger formatted the message correctly
    assert.are.same('󰢚 [phosmon.ai]  Hello, world!', notify_output)
  end)
end)
