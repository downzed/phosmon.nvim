local services_model = require('phosmon.ai.services.model')
local theme = require('phosmon.colorscheme.theme')
local M = {}

--- @description Set phosmon colorscheme commands
--- @return nil
--- @usage `Phosmon toggle opacity`
M.set_commands = function()
  vim.api.nvim_create_user_command('PhosmonLight', function()
    require('phosmon.config').set_mode('light')
    vim.o.background = 'light'
    require('phosmon.colorscheme.highlight').set_hlgroups()
  end, {
    nargs = '*',
    desc = 'Set phosmon to light mode',
  })

  vim.api.nvim_create_user_command('PhosmonDark', function()
    require('phosmon.config').set_mode('dark')
    vim.o.background = 'dark'
    require('phosmon.colorscheme.highlight').set_hlgroups()
  end, {
    nargs = '*',
    desc = 'Set phosmon to dark mode',
  })

  vim.api.nvim_create_user_command('PhosmonPhoton', function()
    require('phosmon.config').set_mode('photon')
    vim.o.background = 'dark'
    require('phosmon.colorscheme.highlight').set_hlgroups()
  end, {
    nargs = '*',
    desc = 'Set phosmon to photon mode',
  })

  vim.api.nvim_create_user_command('Phosmon', function(opts)
    local args = vim.split(opts.args, ' ')
    if #args == 2 and args[1] == 'toggle' then
      if args[2] == 'opacity' then
        theme.toggle_opacity()
      elseif args[2] == 'ai' then
        services_model.toggle()
      end
    elseif require('phosmon.config').get_ai_options().enable and #args == 2 and args[1] == 'ai' then
      if args[2] == 'select_model' then
        services_model.list()
      elseif args[2] == 'pull_model' then
        services_model.pull()
      end
    elseif #args == 2 and args[1] == 'select' then
      if args[2] == 'mode' then
        theme.select_mode()
      end
    else
      vim.notify('phosmon.nvim: invalid phosmon command')
    end
  end, {
    nargs = '*',
    desc = "phosmon colorscheme commands. Use 'toggle opacity' to toggle opacity.",
    complete = function(_arg_lead, cmd_line, _cursor_pos)
      local cmd_parts = vim.split(cmd_line, ' ')
      local complete_args = {}

      if #cmd_parts == 2 then
        complete_args = { 'toggle', 'select' }
        if require('phosmon.config').get_ai_options().enable then
          complete_args[#complete_args + 1] = 'ai'
        end
      elseif #cmd_parts == 3 and cmd_parts[2] == 'toggle' then
        complete_args = { 'opacity', 'ai' }
      elseif #cmd_parts == 3 and cmd_parts[2] == 'select' then
        complete_args = { 'mode' }
      elseif
        #cmd_parts == 3
        and cmd_parts[2] == 'ai'
        and require('phosmon.config').get_ai_options().enable
      then
        complete_args = { 'pull_model', 'select_model' }
      end

      return complete_args
    end,
  })
end

return M
