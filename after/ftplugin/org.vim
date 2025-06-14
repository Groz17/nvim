" non funge con elisp immagino (ghostty)
augroup auto_tangle
autocmd!
" doesn't contain elisp code
" autocmd BufWritePost <buffer> if expand("<afile>:p")=~'^'..$HOME..'/dotfiles' && !search(':tangle\s*(') | exe 'lua require("orgmode").action("org_mappings.org_babel_tangle")' | endif
autocmd BufWritePost <buffer> if expand("<afile>:p")=~'^'..$HOME..'/\%(dotfiles\|\.config/emacs/config\.org$\)' && !search('^#+begin_src .\+(','n') | exe 'lua require("orgmode").action("org_mappings.org_babel_tangle")' | endif
augroup END

"lua<<EOF
"-- vim.schedule(function()Snacks.zen()end)
"-- Snacks.toggle.zen():toggle()
"EOF

