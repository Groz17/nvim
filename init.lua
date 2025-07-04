-- check in which order you should require your modules
-- local core_modules = {
--     'settings',
--     'mappings',
--     'lazy',
-- --    'autocmds',
-- --    'colorscheme',
-- --    'diagnostics',
-- --    'paste',
-- --    'lang',
-- --    'lsp',
-- }
-- 
-- for _, module in ipairs(core_modules) do
--   local ok, err = pcall(require, "config." .. module)
--   if not ok then
--     vim.notify('Error loading ' .. module .. '\n\n' .. err)
--   end
-- end

require("config.options")
-- mimics autochdir?
require("rooter")
---@diagnostic disable-next-line: different-requires
require("config.lazy")
-- metto qua senno autocmd per apkg, xopp non vanno
require("config.autocmds")

require("config.diagnostics")

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    -- It makes more sense to load commands that may be used in keymaps than viceversa
    require("config.commands")
    require("config.keymaps")
    require("config.files")
    require("config.lsp")
  end,
})
