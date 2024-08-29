local B = {}

local create_buffer = function(content)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
  vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
  vim.api.nvim_buf_set_option(buf, 'filetype', 'markdown')

  -- Set the content of the buffer
  local sentences = {}
  for sentence in content:gmatch("([^.]+%.%s)") do
    if sentence:match("%S") then
      table.insert(sentences, sentence)
    end
  end

  -- Set the content of the buffer
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, sentences)

  return buf, sentences
end

local get_window_opts = function(sentences)
  local max_width = 80
  local width = 0

  for _, sentence in ipairs(sentences) do
    width = math.max(width, #sentence)
  end
  width = math.min(width, max_width) < max_width and max_width

  local height = #sentences
  local win_height = vim.api.nvim_get_option("lines")
  local win_width = vim.api.nvim_get_option("columns")
  local row = math.floor((win_height - height) / 2)
  local col = math.floor((win_width - width) / 2)

  -- return floating window options
  return {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded"
  }
end

local auto_close = function(win, buf)
  -- Set up autocommand to close the window when cursor moves
  vim.api.nvim_command([[
    augroup close_tooltip
      autocmd! * <buffer>
      autocmd CursorMoved,CursorMovedI,InsertEnter <buffer> lua vim.api.nvim_win_close(]] .. win .. [[, true)
    augroup END
  ]])

  -- Set up keymapping to close the window with 'q'
  vim.api.nvim_buf_set_keymap(
    buf,
    'n',
    'q',
    ':close<CR>',
    { noremap = true, silent = true }
  )
end

B.open_tooltip = function(content)
  local buf, sentences = create_buffer(content)
  local opts = get_window_opts(sentences)

  -- Create the floating window
  local win = vim.api.nvim_open_win(buf, true, opts)

  -- Format the buffer content
  vim.api.nvim_command("normal! gg=G")
  auto_close(win, buf)
end

return B
