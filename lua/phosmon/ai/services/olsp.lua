local buffer = require('phosmon.ai.buffer')
local job = require('phosmon.ai.job')
local utils = require('phosmon.ai.utils')

local M = {}

local get_params_for_lsp = function(term, lsp_symbol)
  local system = require('phosmon.ai.services.msg_templates').get_lsp_system()
  local messages = {}

  table.insert(messages, system)
  table.insert(messages, {
    role = 'user',
    content = 'Give me a concise explanation of the following symbol definition,\n'
      .. lsp_symbol
      .. '\n Term: '
      .. term
      .. '\n Filetype: '
      .. vim.bo.filetype,
  })

  return {
    messages = messages,
  }
end

local state = {
  content_words = {},
}

local handle_stdout = function(_, data, event)
  if not data or not data[1] then
    return
  end

  if event == 'stderr' or not data then
    job.handle_on_stderr(_, data)
  end

  for _, line in ipairs(data) do
    if line == '' then
      goto continue
    end -- Skip empty lines

    local ok, decoded = pcall(utils.decode_from_json, line)

    if not ok or (decoded and decoded.error) then
      job.handle_on_stderr(_, (decoded and decoded.error) or 'Invalid JSON')
      return
    end

    -- Check for message content in the streamed chunk
    if decoded and decoded.message and decoded.message.content then
      table.insert(state.content_words, decoded.message.content)
      -- buffer.open_bottom_window(decoded.message.content)
      buffer.open_bottom_window(state.content_words)
    end

    ::continue::
  end

  -- local ok, decoded = pcall(utils.decode_from_json, data[1])
  --
  -- if not ok or (decoded and decoded.error) then
  --   job.handle_on_stderr(_, (decoded and decoded.error))
  --   return
  -- end
  --
  -- if decoded and decoded.message and decoded.message.content then
  --   buffer.open_tooltip(decoded.message.content)
  -- end
end

M.run = function()
  local term = vim.fn.expand('<cword>')

  utils.get_symbol_info(function(lsp_symbol)
    local params = get_params_for_lsp(term, lsp_symbol)

    local model = require('phosmon.config').get_ai_model()

    local data = vim.tbl_extend('force', params, {
      stream = true,
      model = model,
    })

    local body = utils.encode_to_json(data)

    local cmd = string.format(
      'curl --silent --no-buffer http://' .. os.getenv('OLLAMA_HOST') .. '/api/chat -d %s',
      body
    )

    local msg = 'Searching for `' .. term .. '`'

    job.handle_the_job(cmd, msg, handle_stdout)
  end)
end

return M
