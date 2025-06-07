return {
  'snacks.nvim',
  opts = {
    bufdelete = {},
  },
  keys = {
    { '<leader>bd', function() Snacks.bufdelete() end, desc = 'Delete Buffer' },
    { '<leader><bs>', function() Snacks.bufdelete() end, desc = 'Delete Buffer' },
    { '<leader>bD', function() Snacks.bufdelete({ force = true }) end, desc = 'Delete Buffer (Force)' },
    { '<leader>bo', function() Snacks.bufdelete.other() end, desc = 'Delete Other Buffers' },
    { '<leader>bO', function() Snacks.bufdelete.other({ force = true }) end, desc = 'Delete Other Buffers (Force)' },
  },
}
