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
vim.lsp.enable('lua_ls')
vim.lsp.enable('jdtls')
