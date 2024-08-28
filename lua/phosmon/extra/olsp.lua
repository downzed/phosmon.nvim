local M = {}

local encode_to_json = function(data)
  local json = vim.fn.json_encode(data)
  return vim.fn.shellescape(json)
end

local decode_from_json = function(data)
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

local function get_symbol_info(callback)
  local params = vim.lsp.util.make_position_params()

  vim.lsp.buf_request(0, 'textDocument/hover', params, function(_, result, _, _)
    if result and result.contents then
      local symbol_info = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
      callback(symbol_info[2] or symbol_info[1])
    else
      callback(nil)
    end
  end)
end

local handle_the_job = function(cmd, callback)
  local job = vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = function(_, data, event)
      if event == "stderr" or not data then
        return
      end

      local decoded = decode_from_json(data[1])
      if decoded == nil then
        return
      end
      if decoded.message and decoded.message.content then
        local content = decoded.message.content
        print(vim.inspect(content))
        callback(content)
        return
      end
    end,
    on_stderr = function(_, res)
      if res then
        -- vim.notify("Error: " .. table.concat(res, "\n"), vim.log.levels.ERROR)
        -- print("Error: " .. table.concat(res, "\n"))
      end
    end,
    on_exit = function(_, code)
      if code ~= 0 then
        vim.notify("Ollama query failed with exit code " .. code, vim.log.levels.ERROR)
      end
    end
  })
end

local function query_ollama(term, callback)
  local filetype = vim.bo.filetype
  local messages = {}

  get_symbol_info(function(lsp_symbol)
    table.insert(messages, {
      role = "system",
      content =
          "You're an LSP expert, you are to enhance the LSP result with given context: " ..
          lsp_symbol ..
          ", and filetype: " ..
          filetype .. "." ..
          "You will write short LSP-like description no more than 2 sentences. Give a explanation in markdown format"

    })

    local msg = "Give a concise LSP-like explanation with a minimal example of " .. term

    table.insert(messages, { role = "user", content = msg })

    local json_body = encode_to_json({
      model    = "llama3.1:latest",
      stream   = false,
      messages = messages
    })

    local port = "11434"

    local cmd = string.format(
      "curl --silent --no-buffer http://localhost:" .. port .. "/api/chat -d %s",
      json_body
    )

    handle_the_job(cmd, callback)
  end)
end

local handle_response = function(_response)
  print("TODO: handling response")
  --[[ TODO: implement
  if response then
    vim.api.nvim_buf_set_lines(0, -1, -1, false, response)
  else
    -- TODO: implement
  end
  ]] --
end


M.set_keys = function()
  vim.keymap.set('n', '<leader>q',
    function()
      query_ollama(vim.fn.expand('<cword>'),
        handle_response
      )
    end,
    { noremap = true, silent = true, desc = "Query Ollama" })
end



return M
