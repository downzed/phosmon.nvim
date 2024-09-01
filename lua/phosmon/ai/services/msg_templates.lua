local M = {}
M.get_lsp_system = function()
  return {
    role = "system",
    content =
        "You're an LSP expert. you answer in less than 2 concise sentences. you are to enhance LSP given input, " ..
        "regarding a specific filetype: " .. vim.bo.filetype .. "."
  }
end

M.get_gen_system = function()
  return {
    role = "system",
    content =
        "You're a DocString expert. you answer in docstring template based on given code." ..
        "You specifically regarding the filetype: " .. vim.bo.filetype .. "."
  }
end


return M
