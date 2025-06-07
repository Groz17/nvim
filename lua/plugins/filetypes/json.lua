-- json-lsp gives error
return
-- {
  --   "gennaro-tedesco/nvim-jqx",
  --   cond = vim.fn.executable("jq") == 1,
  --   event = { "VeryLazy" },
  -- },

  {
    -- dot-repeat doesn't work with gqaj??
    'tpope/vim-jdaddy',
    ft = 'json',
  }
