local logger = require("phosmon.logger")
local utils = require("phosmon.extra.utils")
local buffer = require("phosmon.extra.buffer")

local M = {}

local handle_on_stderr = function(_, res)
  if res ~= nil and table.concat(res, "\n") ~= "" then
    logger.error(table.concat(res, "\n"))
  end
end

local handle_on_stdout = function(_, data, event)
  if event == "stderr" or not data then
    handle_on_stderr(_, data)
  end

  local decoded = utils.decode_from_json(data[1])
  if decoded == nil then
    return
  end

  if decoded.message and decoded.message.content then
    buffer.open_tooltip(decoded.message.content)
  end
end

local handle_on_exit = function(_, code)
  if code ~= 0 then
    logger.error("Query failed with exit code " .. code)
    return
  end
end

local handle_the_job = function(cmd, term)
  local job_id = vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = handle_on_stdout,
    on_stderr = handle_on_stderr,
    on_exit = handle_on_exit
  })

  if job_id ~= nil or job_id ~= 0 then
    logger.success("Searching for `" .. term .. "`")
  else
    logger.error("Job failed")
  end
end

local run_query = function(term)
  local filetype = vim.bo.filetype

  utils.get_symbol_info(function(lsp_symbol)
    local messages = {
      {
        role = "system",
        content =
            "You're an LSP expert. you answer only in less than 2 concise sentences. you are to enhance LSP experience, " ..
            "regarding a specific filetype: " .. filetype .. "."
      },
      {
        role = "user",
        content = "Give me a concise LSP-like exaplantion of lsp definition: " .. lsp_symbol ..
            " and " .. term
      },
    }

    local json_body = utils.encode_to_json({
      model    = "llama3.1:latest",
      stream   = false,
      messages = messages,
      format   = "markdown"
    })

    local port = "11434"

    local cmd = string.format(
      "curl --silent --no-buffer http://localhost:" .. port .. "/api/chat -d %s",
      json_body
    )

    handle_the_job(cmd, term)
  end)
end

M.set_keys = function()
  vim.keymap.set('n', '<leader>K',
    function()
      run_query(vim.fn.expand('<cword>'))
    end,
    { noremap = true, silent = true, desc = "Query Ollama" })
end

return M
