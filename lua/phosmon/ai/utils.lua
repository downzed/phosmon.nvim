local M = {}

M.encode_to_json = function(data)
  local ok, json = pcall(vim.fn.json_encode, data)

  if not ok then
    vim.notify('Error encoding JSON: ' .. json, vim.log.levels.ERROR)
    return nil
  end

  return vim.fn.shellescape(json)
end

M.decode_from_json = function(data)
  if type(data) ~= 'string' or data == '' then
    return nil
  end

  local ok, decoded = pcall(vim.fn.json_decode, data)
  if not ok then
    vim.notify('Error decoding JSON: ' .. decoded, vim.log.levels.ERROR)
    return nil
  end

  return decoded
end

M.get_symbol_info = function(callback)
  local params = vim.lsp.util.make_position_params()

  vim.lsp.buf_request(0, 'textDocument/hover', params, function(_, result, _, _)
    if result and result.contents then
      local symbol_info = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
      if callback then
        callback(symbol_info[2] or symbol_info[1])
      end
    end
  end)
end

M.get_visual_selection = function()
  local _, csrow, cscol, cerow, cecol
  local mode = vim.fn.mode()
  if mode == 'v' or mode == 'V' or mode == '' then
    -- if we are in visual mode use the live position
    _, csrow, cscol, _ = unpack(vim.fn.getpos('.'))
    _, cerow, cecol, _ = unpack(vim.fn.getpos('v'))
    if mode == 'V' then
      -- visual line doesn't provide columns
      cscol, cecol = 0, 999
    end
    -- exit visual mode
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', true)
  else
    -- otherwise, use the last known visual position
    _, csrow, cscol, _ = unpack(vim.fn.getpos("'<"))
    _, cerow, cecol, _ = unpack(vim.fn.getpos("'>"))
  end

  -- swap vars if needed
  if cerow < csrow then
    csrow, cerow = cerow, csrow
  end
  if cecol < cscol then
    cscol, cecol = cecol, cscol
  end
  local lines = vim.fn.getline(csrow, cerow)

  local tbl_length = function(T)
    local count = 0
    for _ in pairs(T) do
      count = count + 1
    end
    return count
  end

  local n = tbl_length(lines)

  if n <= 0 then
    return ''
  end
  lines[n] = string.sub(lines[n], 1, cecol)
  lines[1] = string.sub(lines[1], cscol)

  local str_result = table.concat(lines, '\n')

  return lines, str_result
end

return M
