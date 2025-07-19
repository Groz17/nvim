-- how to highlight before surrounding? in general do this for all operators?
-- https://github.com/gbprod/stay-in-place.nvim how to do for all operators?
-- "christoomey/vim-sort-motion"
-- use kanata symbol layer for non-conflicting keymaps...
return { {
  'echasnovski/mini.operators',
  keys = function(_, keys)
    local opts = require("lazy.core.plugin").values(require("lazy.core.config").spec.plugins["mini.operators"], "opts",
      false)
    local mappings = {}
    -- TODO: find more elegant way (it should read, not map values)
    mappings = vim.iter(opts):filter(function(_, v) return v.prefix ~= '' end):map(function(_, v) return { mode = { "n", "x" },
        v.prefix } end):totable()
    table.insert(mappings, "cx")
    table.insert(mappings, "cX")
    table.insert(mappings, "S")
    table.insert(mappings, { mode = "x", "X" })
    return mappings
  end,
  version = false,
  -- create new operator (execute lua), with gl mapping to execute lua commands (and gL to execute viml wrapping w/ vim.cmd?)
  -- so you can do stuff like glif in lazy's specs
  opts = {
    -- Evaluate text and replace with output
    evaluate = {
      -- idea: use sniprun (put as dependencies? or better put below because you only need it for gs (use lazy=true for sniprun))
      prefix = 'g=',
      -- Function which does the evaluation
      -- TODO: use vimscript when in vimscript expression, lua otherwise? maybe just check &ft if lazy (check out scriptease and mini.operator plugins' functions)
      -- on_substitute = require("yanky.integration").substitute(),
      func = nil,
    },

    -- Exchange text regions
    exchange = {
      prefix = '',
      -- Whether to reindent new text to match previous indent
      reindent_linewise = true,
    },

    -- Multiply (duplicate) text
    multiply = {
      -- prefix = 'gy',
      prefix = '',
      -- Function which can modify text before multiplying
      func = nil,
    },

    -- Replace text with register
    -- use {>,<}s to shift the inserted text?
    -- check if magheggio kanata
    -- cool to use w/ flash.nvim
    replace = {
      -- prefix = 's',
      prefix = 'gs',
      -- prefix = '<cr>',
      -- prefix = '<tab>',
      -- prefix = '\\',
      -- prefix = '<space>r',
      -- Whether to reindent new text to match previous indent
      reindent_linewise = true,
    },

    -- Sort text
    sort = {
      prefix = '',
      -- Function which does the sort
      func = nil,
    },
  },
  config = function(_, opts)
    local operators = require "mini.operators"
    operators.setup(opts)
    operators.make_mappings("exchange", { textobject = "cx", line = "cxx", selection = "X" })
    -- TODO: make it work with dot
    -- vim.keymap.set('n', 'S', 's$', { remap = true })
    -- vim.keymap.set('n', 'cX', 'cx$', { remap = true })
  end,
},
  {
    "gbprod/stay-in-place.nvim",
    cond = false,
    opts = {}
  }
}
-- ]6 and [6 for base64 like in evil-collection-unimpaired.el
