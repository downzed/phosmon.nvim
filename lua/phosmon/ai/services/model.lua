local config = require('phosmon.config')
local job = require('phosmon.ai.job')
local logger = require('phosmon.logger')
local utils = require('phosmon.ai.utils')

local M = {}

M.start = function()
  local ok = pcall(io.popen, 'ollama serve > /dev/null 2>&1 &')
  if not ok then
    logger.error('Failed to start ollama')
    return
  end

  vim.defer_fn(function()
    local model_name = config.get_ai_model()
    logger.info('running ' .. model_name .. ' in the background')
  end, 1000)
end

M.stop = function()
  local capital_ok = pcall(io.popen, 'killall Ollama')
  local small_ok = pcall(io.popen, 'killall ollama')

  if not capital_ok or not small_ok then
    return 'Failed to stop ollama'
  end

  logger.info('stopped')
end

M.toggle = function()
  local ai_opts = config.get_ai_options()
  if ai_opts.enable then
    config.set_ai_options({ enable = false })
    M.stop()
  else
    config.set_ai_options({ enable = true })
    M.start()
  end
end

local catch_stderr = function(event, data)
  if event == 'stderr' then
    job.handle_on_stderr('', data)
    return true
  end
end

local format_item = function(item)
  local current_model = require('phosmon.config').get_ai_model()
  if item == current_model then
    return item .. ' (current)'
  end

  return item
end

local on_selected = function(model)
  if model then
    require('phosmon.config').set_ai_model(model)
    logger.info('Model set to ' .. model)
  end
end

local handle_list_stdout = function(_, data, event)
  if catch_stderr(event, data) then
    return
  end

  local ok, res = pcall(utils.decode_from_json, data[1])
  if not ok or (res and res.error) then
    job.handle_on_stderr(_, (res and res.error))
    return
  end

  local list = {}

  if not res or not res.models then
    logger.error('Failed to get model list')
    return
  end

  if res and res.models then
    for _, model in ipairs(res.models) do
      local name = string.gsub(model.name, ':latest', '')
      list[#list + 1] = name
    end

    logger.info('Model list refreshed', { timeout = 400 })

    vim.ui.select(list, {
      prompt = ' 󰢚 [phosmon.ai] Select model',
      format_item = format_item,
    }, on_selected)
  end
end

local handle_pull_stdout = function(_, data, event)
  if catch_stderr(event, data) then
    return
  end

  local ok, res = pcall(utils.decode_from_json, data[1])
  if not ok or (res and res.error) then
    job.handle_on_stderr(_, (res and res.error))
    return
  end

  if res and res.status == 'success' then
    logger.info(M.model_to_dl .. ' 󰮺 download complete')
    config.set_ai_model(M.model_to_dl)
  end
end

M.list = function()
  local ai_opts = config.get_ai_options()
  local cmd = string.format('curl --silent http://localhost:' .. ai_opts.port .. '/api/tags')
  local msg = 'Refreshing list'

  job.handle_the_job(cmd, msg, handle_list_stdout)
end

M.pull = function()
  local ai_opts = config.get_ai_options()
  vim.ui.input({ prompt = '󰢚 [phosmon.ai] Model name: ' }, function(model)
    if model == nil then
      logger.warn('No model name provided')
      return
    end

    M.model_to_dl = model

    local body = utils.encode_to_json({ model = model, stream = false })

    local cmd =
      string.format('curl --silent http://localhost:' .. ai_opts.port .. '/api/pull -d %s', body)

    local msg = 'Pulling `' .. model .. '`'

    job.handle_the_job(cmd, msg, handle_pull_stdout)
  end)
end

return M
