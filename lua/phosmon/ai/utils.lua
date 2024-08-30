local M = {}

M.encode_to_json = function(data)
  local ok, json = pcall(vim.fn.json_encode, data)

  if not ok then
    vim.notify("Error encoding JSON: " .. json, vim.log.levels.ERROR)
    return nil
  end

  return vim.fn.shellescape(json)
end

M.decode_from_json = function(data)
  if type(data) ~= "string" or data == "" then
    return nil
  end

  local ok, decoded = pcall(vim.fn.json_decode, data)
  if not ok then
    vim.notify("Error decoding JSON: " .. decoded, vim.log.levels.ERROR)
    return nil
  end

  return decoded
end

M.get_symbol_info = function(callback)
  local params = vim.lsp.util.make_position_params()

  vim.lsp.buf_request(0, 'textDocument/hover', params, function(_, result, _, _)
    if result and result.contents then
      local symbol_info = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
      if callback then callback(symbol_info[2] or symbol_info[1]) end
    end
  end)
end

return M
