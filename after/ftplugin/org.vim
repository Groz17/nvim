augroup auto_tangle
autocmd!
" also should tangle files that reference just saved file...
" src block doesn't contain elisp code
" usa emacsclient eval...
" maybe async calls everytime except vimleave?
" don't tangle files w/ pattern |.org (| looks like a barrier)
autocmd BufWritePost <buffer> if
      \ expand("<afile>:p")=~'^'..$HOME..'/\%(dotfiles/.*[^|].org\|\.config/\(emacs\|nvim\)/config\.org$\)' |
      \ echo system('emacsclient -a "" --eval "(org-babel-tangle-file \"'.expand('<afile>:p').'\")"') |
      \ endif
augroup END

"lua<<EOF
"-- vim.schedule(function()Snacks.zen()end)
"-- Snacks.toggle.zen():toggle()
"EOF

lua <<
vim.keymap.set({"n","o"},"gO",function()Snacks.picker.lines({on_show = function()vim.cmd('1') vim.fn.feedkeys([[^* ]]) end, sort={fields={"idx",}}},{buffer=true}) end)
vim.keymap.set({"n","o"},"<m-g>i",function()Snacks.picker.lines({on_show = function()vim.cmd('1')  vim.fn.feedkeys([[^* ]])end, sort={fields={"idx",}}},{buffer=true} )end)
.

nnoremap<buffer> <c-c><c-v><c-t> <cmd>echo system('emacsclient -a "" --eval "(org-babel-tangle-file \"'.expand('%:p').'\")"')<cr>
