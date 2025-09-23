return {
  'duqcyxwd/stringbreaker.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  keys = {
    { mode = { 'n', 'x' }, [[<leader>\]], function() require('string-breaker').break_string() end, { desc = 'Break string for editing' } },
    { mode = { 'n', 'x' }, [[<leader>u<leader>\]], function() require('string-breaker').preview() end, { desc = 'Preview string content' } },
  },
  opts = {},
}

-- -- Auto-keybindings in string editor buffers
-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = 'stringBreaker',
--   callback = function()
--     local opts = { buffer = true, silent = true }
--     vim.keymap.set('n', '<space>fs', stringBreaker.save, opts)
--     vim.keymap.set('n', '<space>qq', stringBreaker.cancel, opts)
--   end
-- })
