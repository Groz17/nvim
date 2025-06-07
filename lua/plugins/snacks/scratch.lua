return {
  'snacks.nvim',
  keys = {
    -- { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
    -- maybe global and local to buffer mappings?
    -- how to add changelog cool lines to plugin notes? like in lazy.nvim's window...
    -- { '<leader>.', function() Snacks.scratch({ ft = 'text' }) vim.cmd.startinsert() end, desc = 'Toggle Scratch Buffer' },
    -- { '<leader>.', function() Snacks.scratch() vim.cmd.startinsert() end, desc = 'Toggle Scratch Buffer' },
    -- like doom emacs?
    -- { '<leader>x', function() Snacks.scratch() end, desc = 'Toggle Scratch Buffer' },
    -- due punti puoi vederli come tanti scratch (un punto)
    -- { '<leader>X', function() Snacks.scratch.select() end, desc = 'Select Scratch Buffer' },
    -- picker? how to delete?
  },
  opts = {
    scratch = {
      autowrite = false,
      -- ft = 'markdown'
      ft = 'org'
    },
  },
}
