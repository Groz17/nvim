-- json-lsp gives error
return
{
  --   "gennaro-tedesco/nvim-jqx",
  --   cond = vim.fn.executable("jq") == 1,
  --   event = { "VeryLazy" },
  -- },

  {
    -- dot-repeat doesn't work with gqaj??
    'tpope/vim-jdaddy',
    ft = 'json',
  },
{
    "Owen-Dechow/videre.nvim",
    keys = { {"<localleader>v", "<cmd>Videre<cr>", ft = 'json'}, },
    opts = {
        round_units = false
    }
}
}
