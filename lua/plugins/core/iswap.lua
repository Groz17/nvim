return {
  -- what about sorting?
  -- use w/ flash?
  'mizlan/iswap.nvim',
  dependencies = {
    -- works with dot-repeat with this plugin
    "tpope/vim-repeat"
  },
  opts = {
    autoswap = true,
    keys = 'asdfghjkl',
  },
  keys = {
    -- { "<leader>Is", "<cmd>ISwap<cr>", desc = "Swap node" },
    -- { "<leader>Iw", "<cmd>ISwapWith<cr>", desc = "Swap current node" },
    -- { "<leader>In", "<cmd>ISwapNode<cr>", desc = "Swap chosen node" },
    -- { "<leader>Ih", "<cmd>ISwapNodeLeft<cr>", desc = "Swap with left" },
    -- { "<leader>Il", "<cmd>ISwapNodeRight<cr>", desc = "Swap with right" },
    --
    -- { "<leader>Im", "<cmd>IMove<cr>", desc = "Move node" },
    -- { "<leader>Ie", "<cmd>IMoveWith<cr>", desc = "Move current node" },
    -- { "<leader>Ij", "<cmd>IMoveNode<cr>", desc = "Move chosen node" },

  -- {mode = { "n", "x" },[[\ss]], '<cmd>ISwapWith<cr>', desc = 'iswap_with' },
  -- {mode = { "n", "x" },[[\sl]], '<cmd>ISwapWithRight<cr>', desc = 'iswap_with_right' },
  -- {mode = { "n", "x" },[[\sh]], '<cmd>ISwapWithLeft<cr>', desc = 'iswap_with_left' },
  -- {mode = { "n", "x" },[[\sS]], '<cmd>ISwap<cr>', desc = 'iswap' },
  --
  -- {mode = { "n", "x" },[[\mm]], '<cmd>IMoveWith<cr>', desc = 'imove_with' },
  -- {mode = { "n", "x" },[[\ml]], '<cmd>IMoveWithRight<cr>', desc = 'imove_with_right' },
  -- {mode = { "n", "x" },[[\mh]], '<cmd>IMoveWithLeft<cr>', desc = 'imove_with_left' },
  -- {mode = { "n", "x" },[[\mM]], '<cmd>IMove<cr>', desc = 'imove' },

  -- {mode = { "n", "x" },'<a-s>', '<cmd>ISwapNodeWith<cr>', desc = 'iswap_node_with' },
  -- {mode = { "n", "x" },'<a-l>', '<cmd>ISwapNodeWithRight<cr>', desc = 'iswap_node_with_right' },
  -- {mode = { "n", "x" },'<a-h>', '<cmd>ISwapNodeWithLeft<cr>', desc = 'iswap_node_with_left' },
  -- {mode = { "n", "x" },'<a-s-s>', '<cmd>ISwapNode<cr>', desc = 'iswap_node' },

  -- {mode = { "n", "x" },'<a-m>', '<cmd>IMoveNodeWith<cr>', desc = 'imove_node_with' },
  -- {mode = { "n", "x" },'<a-l>', '<cmd>IMoveNodeWithRight<cr>', desc = 'imove_node_with_right' },
  -- {mode = { "n", "x" },'<a-h>', '<cmd>IMoveNodeWithLeft<cr>', desc = 'imove_node_with_left' },
  -- {mode = { "n", "x" },'<a-s-m>', '<cmd>IMoveNode<cr>', desc = 'imove_node' },
  },
}

-- { mode = { "x", "v" }, "gh", ":ISwapNodeWithLeft<CR>" },
-- { mode = { "x", "v" }, "gl", ":ISwapNodeWithRight<CR>" },
-- { mode = { "x", "v" }, "gh", ":ISwapWithLeft<CR>" },
-- { mode = { "x", "v" }, "gl", ":ISwapWithRight<CR>" },
-- { mode = { "x", "v" }, "gH", ":ISwapNodeWithLeft<CR>" },
-- { mode = { "x", "v" }, "gL", ":ISwapNodeWithRight<CR>" },
