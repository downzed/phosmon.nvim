local buffer = require('phosmon.ai.buffer')
local job = require('phosmon.ai.job')
local utils = require('phosmon.ai.utils')

local M = {}

local gen_types = {
  docstring = 'Docstring',
  testsuite = 'Test Suite',
  tsinterface = 'TypeScript Interface',
}

local get_params_for_gen = function(content_type, term)
  local system = require('phosmon.ai.services.msg_templates').get_docstring_system()
  if content_type == gen_types.testsuite then
    system = require('phosmon.ai.services.msg_templates').get_testsuite_system()
  end

  if content_type == gen_types.tsinterface then
    system = require('phosmon.ai.services.msg_templates').get_tsinterface_system()
  end

  local messages = {}

  table.insert(messages, system)
  table.insert(messages, {
    role = 'user',
    content = 'Create a ' .. content_type .. ' for this code: ' .. term,
  })

  return {
    messages = messages,
  }
end

local handle_stdout = function(_, data, event)
  if event == 'stderr' or not data then
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

--- @param gen_type "docstring" | "testsuite" | "tsinterface"
M.run = function(gen_type)
  local _, term = utils.get_visual_selection()

  local ai_opts = require('phosmon.config').get_ai_options()

  local content_type = gen_types[gen_type]

  local params = get_params_for_gen(content_type, term)

  local model = require('phosmon.config').get_ai_model()

  local data = vim.tbl_extend('force', params, {
    stream = false,
    model = model,
  })

  local body = utils.encode_to_json(data)

  local cmd = string.format(
    'curl --silent --no-buffer http://localhost:' .. ai_opts.port .. '/api/chat -d %s',
    body
  )

  local msg = 'Generating ' .. content_type

  job.handle_the_job(cmd, msg, handle_stdout)
end

return M
