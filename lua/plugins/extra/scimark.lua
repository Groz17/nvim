-- FIX: se apri ed esegui :q! aggiunge riga vuota a fine tabella
return {
  -- FIX: usa treesitter per individuare pipe_table?
  'mipmip/vim-scimark',
  -- change table by opening?
  -- keys = { [[c\]]},
  keys = { 'g|'},
  config = function() vim.keymap.del('n', '<leader>sc')
    -- vim.keymap.set('n', [[c\]], '<CMD>OpenInScim<CR>', { desc = "Edit embedded markdown table" })
    vim.keymap.set('n', 'g|', '<CMD>OpenInScim<CR>', { desc = "Edit embedded markdown table" })
  end,
}
