local utils = require("phosmon.ai.utils")
local buffer = require("phosmon.ai.buffer")
local job = require("phosmon.ai.job")

local M = {}

local get_params_for_lsp = function(term, lsp_symbol)
  local filetype = vim.bo.filetype
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

  return {
    messages = messages,
    format   = "markdown"
  }
end

local handle_stdout = function(_, data, event)
  if event == "stderr" or not data then
    job.handle_on_stderr(_, data)
  end

  local decoded = utils.decode_from_json(data[1])
  if decoded == nil then
    return
  end

  if decoded.message and decoded.message.content then
    buffer.open_tooltip(decoded.message.content)
  end
end

M.run_lsp = function(term)
  local ai_opts = require("phosmon.config").get_ai_options()

  utils.get_symbol_info(function(lsp_symbol)
    local params = get_params_for_lsp(term, lsp_symbol)

    local model = require("phosmon.config").get_ai_model()

    local data = vim.tbl_extend("force", params, {
      stream = false,
      model = model,
    })

    local body = utils.encode_to_json(data)

    local cmd = string.format(
      "curl --silent --no-buffer http://localhost:" .. ai_opts.port .. "/api/chat -d %s", body
    )

    local msg = "Searching for `" .. term .. "`"

    job.handle_the_job(cmd, msg, handle_stdout)
  end)
end

return M
