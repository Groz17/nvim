return {
  'snacks.nvim',
  opts = {
    bufdelete = {},
  },
  keys = {
    { '<f12>k', function() Snacks.bufdelete() end, desc = 'Delete Buffer' },
    -- { '<leader>bD', function() Snacks.bufdelete({ force = true }) end, desc = 'Delete Buffer (Force)' },
    -- { '<leader>bo', function() Snacks.bufdelete.other() end, desc = 'Delete Other Buffers' },
    -- { '<leader>bO', function() Snacks.bufdelete.other({ force = true }) end, desc = 'Delete Other Buffers (Force)' },
  },
}
