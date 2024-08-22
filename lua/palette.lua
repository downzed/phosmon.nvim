local palette = {}

local dark = {
  normal_fg = "#c6c6c6",
  normal_bg = "#262626",
  endofbuffer_bg = "#1c1c1c",
  floatborder_bg = "#303030",
  comment_fg = "#626262",
  conceal_bg = "#262626",
  constant_fg = "#af87d7",
  identifier_fg = "#c6c6c6",
  statement_fg = "#767676",
  operator_fg = "#c6c6c6",
  preproc_bg = "#262626",
  preproc_fg = "#767676",
  type_fg = "#5f8787",
  special_fg = "#767676",
  error_fg = "#d75f5f",
  warning_fg = "#d7af5f",
  modmsg_fg = "#767676",
  todo_bg = "#262626",
  todo_fg = "#af5f87",
  underlined_fg = "#c6c6c6",
  statusline_bg = "#3a3a3a",
  statusline_fg = "#af87d7",
  statuslinenc_bg = "#303030",
  statuslinenc_fg = "#767676",
  wildmenu_bg = "#303030",
  wildmenu_fg = "#d75f5f",
  vertsplit_bg = "#303030",
  title_fg = "#c6c6c6",
  linenr_fg = "#444444",
  cursorlinenr_bg = "#303030",
  cursorlinenr_fg = "#af87d7",
  cursor_bg = "#af87d7",
  cursor_fg = "#c6c6c6",
  cursorline_bg = "#303030",
  colorcolumn_bg = "#303030",
  signcolumn_fg = "#767676",
  visual_bg = "#3a3a3a",
  visualnos_bg = "#3a3a3a",
  pmenu_bg = "#3a3a3a",
  pmenusbar_bg = "#303030",
  pmenusel_bg = "#303030",
  pmenusel_fg = "#af87d7",
  pmenuthumb_bg = "#d75f5f",
  folded_bg = "#1c1c1c",
  folded_fg = "#767676",
  specialkey_fg = "#767676",
  incsearch_bg = "#d75f5f",
  search_bg = "#af87d7",
  directory_fg = "#af87d7",
  matchparen_fg = "#d75f5f",
  spellbad_fg = "#af5f87",
  spellcap_fg = "#87af87",
  spelllocal_fg = "#d7af5f",
  quickfixline_bg = "#1c1c1c",
  diffadd_bg = "#303030",
  diffadd_fg = "#87af87",
  diffchange_bg = "#303030",
  diffdelete_bg = "#303030",
  diffdelete_fg = "#af5f87",
  difftext_bg = "#303030",
  difftext_fg = "#d7af5f",
  function_fg = "#c6c6c6",
  helphypertextjump_fg = "#d75f5f",
}

local light = {
  normal_fg = "#262626",
  normal_bg = "#ffffff",
  nontext_fg = "#b0b0b0",
  nontext_bg = "NONE",
  endofbuffer_fg = "#ffffff",
  floatborder_fg = "#ffffff",
  comment_fg = "#949494",
  conceal_fg = "#949494",
  constant_fg = "#875fd7",
  identifier_fg = "#262626",
  statement_fg = "#767676",
  operator_fg = "#262626",
  preproc_fg = "#767676",
  type_fg = "#5f8787",
  special_fg = "#767676",
  error_fg = "#d75f5f",
  warning_fg = "#d7af5f",
  modmsg_fg = "#767676",
  todo_fg = "#d75fa7",
  underlined_fg = "#262626",
  statusline_fg = "#875fd7",
  statuslinenc_fg = "#767676",
  wildmenu_fg = "#d75f5f",
  vertsplit_fg = "#e0e0e0",
  title_fg = "#262626",
  linenr_fg = "#b0b0b0",
  cursorlinenr_fg = "#875fd7",
  cursor_fg = "#262626",
  cursorline_bg = "#e0e0e0",
  colorcolumn_bg = "#e0e0e0",
  signcolumn_fg = "#767676",
  visual_bg = "#c0c0c0",
  visualnos_bg = "#c0c0c0",
  pmenu_bg = "#c0c0c0",
  pmenusb_bg = "#e0e0e0",
  pmenusel_fg = "#875fd7",
  pmenuthumb_bg = "#d75f5f",
  foldcolumn_fg = "#949494",
  folded_bg = "#f2f2f2",
  specialkey_fg = "#767676",
  incsearch_fg = "#ffffff",
  search_fg = "#ffffff",
  directory_fg = "#875fd7",
  matchparen_fg = "#d75f5f",
  spellbad_fg = "#d75fa7",
  spellcap_fg = "#afdab7",
  spelllocal_fg = "#d7af5f",
  quickfixline_bg = "#f2f2f2",
  diffadd_fg = "#afdab7",
  diffchange_bg = "#e0e0e0",
  diffdelete_fg = "#d75fa7",
  difftext_fg = "#d7af5f",
  function_fg = "#262626",
  helphypertextjump_fg = "#d75f5f"
}

palette = {
  dark = dark,
  light = light
}

return palette
