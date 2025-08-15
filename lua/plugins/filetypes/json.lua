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
    keys = { {"<localleader>v", "<cmd>Videre<cr>", ft = {'json','yaml','toml','xml'}}, },
    dependencies = {
        "Owen-Dechow/graph_view_yaml_parser", -- Optional: add YAML support
        "Owen-Dechow/graph_view_toml_parser", -- Optional: add TOML support
        "a-usr/xml2lua.nvim", -- Optional | Experimental: add XML support
    },
    opts = {
        round_units = false
    }
}
}
