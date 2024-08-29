local utils = require("phosmon.extra.utils")
local buffer = require("phosmon.extra.buffer")

local M = {}

local handle_on_stderr = function(_, res)
  if res ~= nil and table.concat(res, "\n") ~= "" then
    vim.notify(
      "[phosmon.nvim] Error: " .. table.concat(res, "\n"),
      vim.log.levels.ERROR
    )
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
    vim.notify("[phosmon.nvim]: Ollama query failed with exit code " .. code, vim.log.levels.ERROR)
    return
  end
end

local handle_the_job = function(cmd)
  local job = vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = handle_on_stdout,
    on_stderr = handle_on_stderr,
    on_exit = handle_on_exit
  })

  if job ~= nil or job ~= 0 then
    vim.notify("[phosmon.nvim]: Ollsp running", vim.log.levels.SUCCESS)
  else
    vim.notify("[phosmon.nvim]: Ollama query failed", vim.log.levels.WARN)
  end
end

local query_ollama = function(term)
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

    handle_the_job(cmd)
  end)
end

M.set_keys = function()
  vim.keymap.set('n', '<leader>K',
    function()
      query_ollama(vim.fn.expand('<cword>'))
    end,
    { noremap = true, silent = true, desc = "Query Ollama" })
end

return M
