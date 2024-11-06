local M = {}

---@description Applying highlights
---@param groups table
---@usage groups = { Character = { bg = "NONE", fg = colors.fg } }
M.apply_highlights = function(groups)
  for hl, props in pairs(groups) do
    vim.api.nvim_set_hl(0, hl, {
      bg = props.bg or 'NONE',
      fg = props.fg or 'NONE',
      italic = props.italic == true,
      bold = props.bold == true,
      underline = props.underline == true,
      strikethrough = props.strikethrough == true,
      link = props.link,
      nocombine = props.nocombine,
    })
  end
end

M.set_hlgroups = function()
  local base_groups = require('phosmon.colorscheme.groups.hl').get_hlgroups()
  local l = require('phosmon.colorscheme.groups.links')

  local hl_groups = vim.tbl_extend('force', base_groups, l.get_base_links())

  hl_groups = vim.tbl_extend('force', hl_groups, l.get_treesitter())

  local opts = require('phosmon.config').get_options()

  if opts.enable.fzf_lua then
    hl_groups = vim.tbl_extend('force', hl_groups, l.get_fzf_lua())
  end

  if opts.enable.ministarter then
    hl_groups = vim.tbl_extend('force', hl_groups, l.get_ministarter())
  end

  M.apply_highlights(hl_groups)
end

return M
