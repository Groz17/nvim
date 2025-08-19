-- -- https://www.reddit.com/r/neovim/comments/1jkdzlm/whats_new_in_neovim_011/
-- local configs = {}
--
-- for _, v in ipairs(vim.api.nvim_get_runtime_file('lsp/*', true)) do
--   local name = vim.fn.fnamemodify(v, ':t:r')
--   -- TODO: remove in lspconfig 3.0
--   if name ~= 'volar' and vim.fn.exepath(v) then
--   configs[name] = true
-- end
-- end
--
-- vim.lsp.enable(vim.tbl_keys(configs))
--
-- -- crea comando per ottnere lspconfig per lsp? parse html webpage
--

-- https://github.com/TheMikeste1/my-neovim/blob/3901b2164bb967db0eba8caa4d6fc5f3e7444712/lua/after/enable_installed_lsps.lua#L14
local lsp_names = {}
for _, package in ipairs(require("mason-registry").get_installed_packages()) do
  if vim.tbl_contains(package.spec.categories, "LSP") then
    local name = package.spec.name
    if package.spec.neovim ~= nil and package.spec.neovim.lspconfig ~= nil then
      name = package.spec.neovim.lspconfig
    else
      name = name:gsub("%-", "_")
    end
    table.insert(lsp_names, name)
  end
end

vim.lsp.enable(lsp_names, true)
