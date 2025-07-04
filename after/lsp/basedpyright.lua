---@type vim.lsp.Config
return {
  -- name = 'bash-language-server',
  -- autostart = false,
  cmd = {  vim.fn.exepath'/basedpyright-langserver', "--stdio" },
  filetypes = {'python'},
  single_file_support=true
}
