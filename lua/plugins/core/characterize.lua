return {
  -- Would be nice if it could visually select an HTML entity and show the character...
  -- I mean, you can alread you ]x from unimpaired but whatever
  'tpope/vim-characterize',
  -- keys = { { '<a-a>', '<Plug>(characterize)' } },
  cmd = 'Characterize',
}

-- " nmap <leader>ga <Plug>(characterize)
-- " misto fra g-<c-g> e ga
-- " nmap g<c-c> <Plug>(characterize)
-- " nmap g<a-a> <Plug>(characterize)
-- nmap <a-a> <Plug>(characterize)
--

-- return
--   {
--     "tpope/vim-characterize",
--     keys = { "gA" },
--     config = function()
--       vim.keymap.set('n',"gA", "<Plug>(characterize)")
--     end,
--   },
