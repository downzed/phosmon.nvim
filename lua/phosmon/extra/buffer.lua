local B = {}

local create_buffer = function(content, title)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
  vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
  vim.api.nvim_buf_set_option(buf, 'filetype', 'markdown')

  local words = {}
  for word in content:gmatch("%S+") do
    table.insert(words, word)
  end

  local max_words_per_line = 7

  local lines = {}

  for i = 1, #words, max_words_per_line do
    table.insert(lines, table.concat(words, " ", i, math.min(i + max_words_per_line - 1, #words)))
  end

  table.insert(lines, 1, "")
  table.insert(lines, 1, title)

  B.lines = lines
  B.buffer = buf

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  return buf, lines
end

local calculate_dynamic_width = function(lines)
  local max_width = 0
  for _, line in ipairs(lines) do
    max_width = math.max(max_width, vim.fn.strdisplaywidth(line))
  end
  return max_width
end

local get_window_opts = function()
  local lines = B.lines
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local cursor_row = cursor_pos[1] - 1 -- 0-indexed row
  local cursor_col = cursor_pos[2]     -- 0-indexed column

  local width = calculate_dynamic_width(lines)
  local height = #lines

  local win_height = vim.api.nvim_get_option("lines")
  local win_width = vim.api.nvim_get_option("columns")
  local row = cursor_row + 1
  local col = cursor_col + 1

  if row + height > win_height then
    row = cursor_row - height
  end
  if col + width > win_width then
    col = win_width - width
  end

  return {
    focusable = false,
    noautocmd = true,
    relative = "cursor",
    width = width,
    height = height,
    row = 0, -- position just below the cursor
    col = 0, -- position slightly to the right of the cursor
    style = "minimal",
    border = "rounded",
  }
end

local auto_close = function(win, buf)
  vim.api.nvim_buf_set_keymap(
    buf,
    'n',
    'q',
    ':close<CR>',
    { noremap = true, silent = true }
  )
end

B.open_tooltip = function(content)
  local title = "Phosmon.ai - I might be wrong"
  local buf = create_buffer(content, title)
  local opts = get_window_opts()

  local win = vim.api.nvim_open_win(buf, true, opts)

  vim.api.nvim_command("normal! gg=G")
  auto_close(win, buf)
end

return B
