---@type vim.lsp.Config
return {
  -- name = 'bash-language-server',
  -- autostart = false,
  cmd = {  require('mason-registry').get_package('basedpyright'):get_install_path() .. '/venv/bin/basedpyright-langserver', "--stdio" },
  filetypes = {'python'},
  single_file_support=true
}
