local utils = require("phosmon.ai.utils")
local job = require("phosmon.ai.job")
local buffer = require("phosmon.ai.buffer")

local M = {}

local get_params_for_gen = function(term)
  local system = require("phosmon.ai.services.msg_templates").get_gen_system(vim.bo.filetype)

  local messages = {}

  table.insert(messages, system)
  table.insert(messages, {
    role = "user",
    content = "Give me a docstring for this code: " .. term
  })

  return {
    messages = messages,
    format   = vim.bo.filetype
  }
end

local handle_stdout = function(_, data, event)
  if event == "stderr" or not data then
    job.handle_on_stderr(_, data)
  end

  local ok, decoded = pcall(utils.decode_from_json, data[1])

  if not ok or (decoded and decoded.error) then
    job.handle_on_stderr(_, (decoded and decoded.error))
    return
  end

  if decoded and decoded.message and decoded.message.content then
    buffer.open_split(decoded.message.content)
  end
end

M.run = function()
  local _, term = utils.get_visual_selection()

  local ai_opts = require("phosmon.config").get_ai_options()

  local params  = get_params_for_gen(term)

  local model   = require("phosmon.config").get_ai_model()

  local data    = vim.tbl_extend("force", params, {
    stream = false,
    model = model,
  })

  local body    = utils.encode_to_json(data)

  local cmd     = string.format(
    "curl --silent --no-buffer http://localhost:" .. ai_opts.port .. "/api/chat -d %s", body
  )

  local msg     = "quering.."

  job.handle_the_job(cmd, msg, handle_stdout)
end

return M
