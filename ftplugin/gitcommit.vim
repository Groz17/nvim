" how to show cursor differentyl-in inset mode
if getline(1) == "" | startinsert | endif

lua <<
-- useful for git commit fugitive/magit...
-- blink doesn't make this work...
vim.keymap.set('i','<c-c><c-c>','<cmd>up|q<cr>')
vim.keymap.set('i','<c-c><c-k>','<cmd>q!<cr>')
.
