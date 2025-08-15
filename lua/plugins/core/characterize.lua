return {
  -- Would be nice if it could visually select an HTML entity and show the character...
  -- I mean, you can alread you ]x from unimpaired but whatever
  'tpope/vim-characterize',
  keys = { { '<F12>=', '<Plug>(characterize)' } },
  cmd = 'Characterize',
}
