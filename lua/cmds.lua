local utils = require("utils")
local M = {}

---@description Set phosmon colorscheme commands
---@return nil
---@usage `Phosmon toggle opacity`
M.set_commands = function()
  vim.api.nvim_create_user_command('Phosmon', function(opts)
    local args = vim.split(opts.args, " ")
    if #args == 2 and args[1] == "toggle" then
      if args[2] == "opacity" then
        utils.toggle_opacity()
      -- elseif args[2] == "dark_mode" then
      --   utils.toggle_dark_mode()
      else
        print("only 'toggle opacity' is supported rn")
      end
    else
      print("Invalid phosmon command")
    end
  end, {
    nargs = "*",
    desc = "phosmon colorscheme commands. Use 'toggle opacity' to toggle opacity.",
    complete = function(arg_lead, cmd_line, cursor_pos)
      local cmd_parts = vim.split(cmd_line, " ")
      local complete_args = {}

      if #cmd_parts == 2 then
        complete_args = { "toggle" }
      elseif #cmd_parts == 3 and cmd_parts[2] == "toggle" then
        complete_args = { "opacity" } --, "dark_mode" }
      end

      return complete_args
    end
  })
end

return M
