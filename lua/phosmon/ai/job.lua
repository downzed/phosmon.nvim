local logger = require("phosmon.logger")
local utils = require("phosmon.ai.utils")

local M = {}

M.handle_on_stderr = function(_, res)
  if res ~= nil then
    if type(res) == "string" then
      logger.error(res)
    elseif table.concat(res, "\n") ~= "" then
      logger.error(table.concat(res, "\n"))
    end
  end
end

-- local handle_on_stdout = function(data, event, callback)
--   if event == "stderr" or not data then
--     handle_on_stderr(_, data)
--   end
--
--   local decoded = utils.decode_from_json(data)
--   if decoded == nil then
--     return
--   end
--
--   if decoded.message and decoded.message.content then
--     callback(decoded.message.content)
--   end
-- end

local handle_on_exit = function(_, code, data)
  if code ~= 0 then
    logger.error("Query failed with exit code " .. code)
    return
  end
  if data ~= "exit" then
    print(vim.inspect(data))
  end
end

M.handle_the_job = function(cmd, msg, handle_stdout)
  local job_id = vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = handle_stdout,
    on_stderr = M.handle_on_stderr,
    on_exit = handle_on_exit
  })

  if job_id ~= nil or job_id ~= 0 then
    logger.info(msg)
  else
    logger.error("Job failed")
  end
end

return M
