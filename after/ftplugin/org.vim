augroup auto_tangle
autocmd!
" src block doesn't contain elisp code
" usa emacsclient eval...
autocmd BufWritePost <buffer> if
      \ expand("<afile>:p")=~'^'..$HOME..'/\%(dotfiles/\|\.config/\(emacs\|nvim\)/config\.org$\)' |
      \ echo system('emacsclient --eval "(org-babel-tangle-file \"'.expand('<afile>:p').'\")"') |
      \ endif
augroup END

"lua<<EOF
"-- vim.schedule(function()Snacks.zen()end)
"-- Snacks.toggle.zen():toggle()
"EOF

lua <<
vim.keymap.set({"n","o"},"gO",function()Snacks.picker.lines({on_show = function()vim.cmd('1') vim.fn.feedkeys([[^* ]]) end, sort={fields={"idx",}}}) end)
vim.keymap.set({"n","o"},"<m-g>i",function()Snacks.picker.lines({on_show = function()vim.cmd('1')  vim.fn.feedkeys([[^* ]])end, sort={fields={"idx",}}} )end)
.
