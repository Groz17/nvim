return {
  "Imngzx/jisho.nvim",
  cmd = "Jisho",
  keys = {
    -- {
    --   '<leader>J',
    --   function() require('jisho').search() end,
    --   mode = 'n',
    --   desc = 'Jisho (Word under cursor)',
    -- },
    {
      '<leader>J',
      function()
        local start_pos = vim.fn.getpos('v')
        local end_pos = vim.fn.getpos('.')
        local lines = vim.fn.getregion(start_pos, end_pos)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', true)
        require('jisho').search(table.concat(lines, ' '))
      end,
      mode = 'x',
      desc = 'Jisho (Selection)',
    },
  },
  opts = {},
}
