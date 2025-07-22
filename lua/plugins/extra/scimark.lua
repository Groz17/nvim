-- FIX: se apri ed esegui :q! aggiunge riga vuota a fine tabella
return {
  -- FIX: usa treesitter per individuare pipe_table?
  'mipmip/vim-scimark',
  keys = { "<f15>'"},
  config = function() vim.keymap.del('n', '<leader>sc')
    -- vim.keymap.set('n', [[c\]], '<CMD>OpenInScim<CR>', { desc = "Edit embedded markdown table" })
    vim.keymap.set('n', "<f15>'", '<CMD>OpenInScim<CR>', { desc = "Edit embedded markdown table" })
  end,
}
