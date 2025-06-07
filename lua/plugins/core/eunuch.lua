-- If you create a new file that starts with #!, `chmod +x` will automatically be invoked on it when you first write the file.
return {
  'tpope/vim-eunuch',
  -- for shebang behaviour
  -- event = 'VeryLazy',
  init = function() vim.g.eunuch_interpreters = { lua = '/usr/bin/lua5.1' } end,
  cmd = {
    -- how to add description to cmd??? desc="Like :wall, but for windows rather than buffers"},
    'Remove', 'Unlink',
    'Delete',
    'Copy',
    'Duplicate',
    'Move',
    'Rename',
    'Chmod',
    'Mkdir',
    'Cfind',
    'Lfind',
    'Clocate',
    'Llocate',
    'SudoEdit',
    'SudoWrite',
    'Wall', 'W',
  },
  -- keys = {'n','<a-f4>','Remove'}
  -- tasto scomodo per un buon motivo (talvolta avere tasti scomodi ha il suo xke)
  -- keys = {{[[\\]],'<CMD>Unlink<CR>'}}
  -- keys = {{'n',[[<f52>]],'<CMD>Unlink<CR>'}}
}
