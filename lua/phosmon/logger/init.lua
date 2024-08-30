local M = {
  notify_opts = {
    timeout = 1000,
    title = "[phosmon.ai]"
  }
}

local function log(level, msg, opts)
  local options = vim.tbl_deep_extend("force", M.notify_opts, opts or {})
  return vim.notify(" 󰢚 " .. options.title .. ": " .. msg, vim.log.levels[level], options)
end

M.success = function(msg, opts)
  log("INFO", msg, opts)
end

M.error = function(msg, opts)
  log("ERROR", msg, opts)
end

M.warn = function(msg, opts)
  log("WARN", msg, opts)
end

return M
