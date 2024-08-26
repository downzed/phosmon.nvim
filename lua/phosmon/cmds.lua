local theme = require("phosmon.theme")
local M = {}

---@description Set phosmon colorscheme commands
---@return nil
---@usage `Phosmon toggle opacity`
M.set_commands = function()
  vim.api.nvim_create_user_command('Phosmon', function(opts)
    local args = vim.split(opts.args, " ")
    if #args == 2 and args[1] == "toggle" then
      if args[2] == "opacity" then
        theme.toggle_opacity()
      end
    elseif #args == 2 and args[1] == "select" then
      if args[2] == "mode" then
        theme.select_mode()
      end
    else
      vim.notify("phosmon.nvim: invalid phosmon command")
    end
  end, {
    nargs = "*",
    desc = "phosmon colorscheme commands. Use 'toggle opacity' to toggle opacity.",
    complete = function(arg_lead, cmd_line, cursor_pos)
      local cmd_parts = vim.split(cmd_line, " ")
      local complete_args = {}

      if #cmd_parts == 2 then
        complete_args = { "toggle", "select" }
      elseif #cmd_parts == 3 and cmd_parts[2] == "toggle" then
        complete_args = { "opacity" }
      elseif #cmd_parts == 3 and cmd_parts[2] == "select" then
        complete_args = { "mode" }
      end

      return complete_args
    end
  })
end

return M
