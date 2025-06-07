---@type vim.lsp.Config
local cfg = {
  -- name = 'bash-language-server',
  -- autostart = false,
  cmd = {  require('mason-registry').get_package('biome'):get_install_path() .. '/node_modules/.bin/biome', 'lsp-proxy' },
  filetypes =  { "astro", "css", "graphql", "javascript", "javascriptreact", "json", "jsonc", "svelte", "typescript", "typescript.tsx", "typescriptreact", "vue" },
  single_file_support=true
}
return cfg
