local buffer = require('phosmon.ai.buffer')
local job = require('phosmon.ai.job')
local utils = require('phosmon.ai.utils')

local M = {}

local gen_types = {
  docstring = 'Docstring',
  testsuite = 'Test Suite',
  tsinterface = 'TypeScript Interface',
  refactor = 'Refactor',
}

local get_params_for_gen = function(content_type, term)
  local system = require('phosmon.ai.services.msg_templates').get_docstring_system()
  local templates = require('phosmon.ai.services.msg_templates')

  local is_refactor = content_type == gen_types.refactor
  if content_type == gen_types.testsuite then
    system = templates.get_testsuite_system()
  elseif content_type == gen_types.tsinterface then
    system = templates.get_tsinterface_system()
  elseif is_refactor then
    system = templates.get_refactor_system()
  end

  local messages = {}

  local content = is_refactor and 'Improve and optimize the following code:\n' .. term
    or 'Create a ' .. content_type .. ' for this code: ' .. term

  table.insert(messages, system)
  table.insert(messages, {
    role = 'user',
    content = content,
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

  if not ok and decoded ~= nil and decoded.error then
    job.handle_on_stderr(_, decoded.error)
    return
  end

  if decoded and decoded.message and decoded.message.content then
    buffer.open_split(decoded.message.content)
  end
end

--- @param gen_type "docstring" | "testsuite" | "tsinterface" | "refactor"
--- @return nil
M.run = function(gen_type)
  local _, term = utils.get_visual_selection()
  local is_refactor = gen_type == 'refactor'

  local content_type = gen_types[gen_type]

  local params = get_params_for_gen(content_type, term)

  local model = require('phosmon.config').get_ai_model()

  local data = vim.tbl_extend('force', params, {
    stream = false,
    model = model,
  })

  local body = utils.encode_to_json(data)

  local cmd = string.format(
    'curl --silent --no-buffer http://' .. os.getenv('OLLAMA_HOST') .. '/api/chat -d %s',
    body
  )

  local msg = 'Generating ' .. content_type
  if is_refactor then
    msg = 'Refactoring '
  end

  job.handle_the_job(cmd, msg, handle_stdout)
end

return M
