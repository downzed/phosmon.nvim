local logger = {
  notify_opts = {
    timeout = 1000,
    title = '[phosmon.ai] ',
  },
}

--- @Description Logs a message to the Vim status line with a specified level and additional options.
---
--- @param level 'INFO' | 'WARN' | 'ERROR'
--- @param msg string message to be logged.
--- @param opts table of optional parameters to customize the notification behavior.
---
--- @return `vim.notify` function
local function log(level, msg, opts)
  local notify = vim.notify
  if opts == nil then
    opts = {}
  end
  local options = vim.tbl_deep_extend('force', logger.notify_opts, opts)
  return notify('󰢚 ' .. options.title .. ' ' .. msg, vim.log.levels[level], options)
end

logger.info = function(msg, opts)
  opts = opts or {}
  log('INFO', msg, opts)
end

logger.error = function(msg, opts)
  log('ERROR', msg, opts)
end

logger.warn = function(msg, opts)
  log('WARN', msg, opts)
end

return logger
