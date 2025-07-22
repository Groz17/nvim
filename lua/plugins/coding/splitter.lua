-- splitter: https://www.reddit.com/r/neovim/comments/1gv1jfs/comment/ly2bzcq/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button

-- would be nice to toggle every element inside an array/list/dict
return {{
  -- should support comments turning them in block comments no?
  -- TODO: add Perl support
  'Wansmer/treesj',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  -- crea operator con vim-toot
  -- Make it so that pressing e.g. 3gK will put 3 items per line and with recursive 3 level deep
  keys = {
    -- keys = { "<Leader>jm", "<Leader>js", "<Leader>jj" },
    -- cool mappings (ispirati a H e L)
    -- fallback to regex when treesitter doesn't work in buffer?
    -- { "gS", "<cmd>TSJToggle<cr>",  desc = "Toggle join/split syntax node" },
    -- { 'gh', [[:lua require('treesj').join()<CR>]],  desc = "Join syntax node in a single line"  },
    -- { 'gH', [[:lua require('treesj').join({ join = { recursive = true } })<cr>]] , desc = "Recursively join syntax node in a single line" },
    -- { 'gl', [[:lua require('treesj').split()<CR>]],  desc = "Split syntax node in multiple lines"  },
    -- { 'gL', [[:lua require('treesj').split({ split = { recursive = true } })<cr>]],  desc = "Recursively split syntax node in multiple lines"  },
    -- ala unimpaired (y -> toggle)
    -- { "gY", "<cmd>TSJToggle<cr>",  desc = "Toggle join/split syntax node" },
    -- { 'gJ', [[:lua require('treesj').join()<CR>]],  desc = "Join syntax node in a single line"  },
    -- { 'gX', [[:lua require('treesj').join({ join = { recursive = true } })<cr>]] , desc = "Recursively join syntax node in a single line" },
    -- { 'gK', [[:lua require('treesj').split()<CR>]],  desc = "Split syntax node in multiple lines"  },
    -- { 'gS', [[:lua require('treesj').split({ split = { recursive = true } })<cr>]],  desc = "Recursively split syntax node in multiple lines"  },
    -- join -> , because you use commas to join, . -> split because a dot split sentences (also lowercase versions of < and >, nice to better learn US layout)
    -- magari fungono anche in visual mode?
    -- join/split kinda looks like folding -> use z as prefix
    -- cool because you bind shift to parenthesis, now bind shift + shift to brace...
    { 'z(', function() require('treesj').join() end,  desc = "Join syntax node in a single line"  },
    -- { 'z}', function() require('treesj').join({ join = { recursive = true } }) end , desc = "Recursively join syntax node in a single line" },
    -- { 'z[', function() require('treesj').join({ join = { recursive = true } }) end , desc = "Recursively join syntax node in a single line" },
    { 'z{', function() require('treesj').join({ join = { recursive = true } }) end , desc = "Recursively join syntax node in a single line" },
    { 'z)', function() require('treesj').split() end,  desc = "Split syntax node in multiple lines"  },
    -- { 'z}', function() require('treesj').split({ split = { recursive = true } }) end,  desc = "Recursively split syntax node in multiple lines"  },
    -- { 'z]', function() require('treesj').split({ split = { recursive = true } }) end,  desc = "Recursively split syntax node in multiple lines"  },
    { 'z}', function() require('treesj').split({ split = { recursive = true } }) end,  desc = "Recursively split syntax node in multiple lines"  },
  },
  opts = {
    -- you can split/join object from name of variable
    -- sarebbe bello splittasse anche gli html tags come in splitjoin.vim
    use_default_keymaps = false,
    -- max_join_length = 10000,
    max_join_length = math.huge,
  }
},
}

