local B = {
  buffer = nil,
  win = nil,
}

local create_buffer = function(content, title)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
  vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
  vim.api.nvim_buf_set_option(buf, 'filetype', 'markdown')

  local words = {}
  for word in content:gmatch('%S+') do
    table.insert(words, word)
  end

  local max_words_per_line = 7

  local lines = {}

  for i = 1, #words, max_words_per_line do
    table.insert(lines, table.concat(words, ' ', i, math.min(i + max_words_per_line - 1, #words)))
  end

  table.insert(lines, 1, '')
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

  local width = calculate_dynamic_width(lines)
  local height = #lines

  return {
    focusable = false,
    noautocmd = true,
    relative = 'cursor',
    width = width,
    height = height,
    row = 0, -- position just below the cursor
    col = 0, -- position slightly to the right of the cursor
    style = 'minimal',
    border = 'rounded',
  }
end

-- Function to handle the input prompt and chat continuation
-- local function chat_prompt(buf)
--   vim.ui.input({ prompt = '󰢚 [phosmon.ai] Your message: ' }, function(input)
--     if buf == nil or not buf then
--       return
--     end
--
--     if input and input ~= "" then
--       -- Append the user's input to the buffer
--       vim.api.nvim_buf_set_lines(buf, -1, -1, false, { "### You: " .. input })
--
--       -- Call your chat function to process the input
--       -- local response = process_chat_input(input)   -- You need to define this function to handle the chat logic
--
--       -- Display the response
--       -- vim.api.nvim_buf_set_lines(buf, -1, -1, false, { "Bot: " .. response })
--
--       -- Keep the prompt active for more input
--       chat_prompt()
--     else
--       -- Handle the case where the user cancels the input
--       vim.api.nvim_buf_set_lines(buf, -1, -1, false, { "󰢚 Chat ended." })
--     end
--   end)
-- end

local auto_close = function(_, buf)
  vim.api.nvim_buf_set_keymap(buf, 'n', 'q', ':close<CR>', { noremap = true, silent = true })
end

B.open_split = function(content)
  local lines = {}
  for line in (content .. '\n'):gmatch('(.-)\n') do
    table.insert(lines, line)
  end

  if B.buffer ~= nil and B.win ~= nil then
    if vim.api.nvim_win_is_valid(B.win) and vim.api.nvim_buf_is_valid(B.buffer) then
      -- append lines to existing buffer
      vim.api.nvim_buf_set_lines(B.buffer, -1, -1, false, lines)
      vim.api.nvim_command('normal! gg=G')
      return
    end
  end
  vim.cmd('vsplit :enew')

  local buf = vim.api.nvim_get_current_buf()
  B.buffer = buf
  local win = vim.api.nvim_get_current_win()
  B.win = win

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_win_set_option(0, 'wrap', true) -- Enable line wrapping in the split window
  vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe') -- Wipe the buffer when it's no longer displayed
  vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
  vim.api.nvim_buf_set_option(buf, 'filetype', 'markdown')
  -- set buffer name
  vim.api.nvim_buf_set_name(buf, '[phosmon.ai]')

  -- half width
  vim.api.nvim_win_set_width(win, math.floor(vim.api.nvim_win_get_width(win) / 2))
  vim.api.nvim_command('normal! gg=G')

  -- Focus the prompt window
  vim.api.nvim_set_current_win(win)

  -- chat_prompt(buf)
end

B.open_tooltip = function(content)
  local model_name = require('phosmon.config').get_ai_model()
  local title = 'Model: `' .. model_name .. '`  󰢚  [phosmon.ai]'
  local buf = create_buffer(content, title)
  local opts = get_window_opts()

  local win = vim.api.nvim_open_win(buf, true, opts)

  vim.api.nvim_command('normal! gg=G')
  auto_close(win, buf)
end

return B
