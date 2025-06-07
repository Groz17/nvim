" ==============================================================================
" Run xidel (the command-line XML processor) interactively in Vim
" File:         plugin/xidelplay.vim
" Author:       Groz17 <https://github.com/Groz17>
" Website:      https://github.com/Groz17/vim-xidelplay
" Last Change:  Feb 06, 2024
" License:      Same as Vim itself (see :h license)
" ==============================================================================

if exists('g:loaded_xidelplay') || (!has('nvim') && !has('patch-8.1.1776'))
    finish
endif
let g:loaded_xidelplay = 1

command -nargs=* -complete=customlist,xidelplay#complete Xidelplay call xidelplay#start(<q-mods>, <q-args>, bufnr('%'))
command -bang -nargs=* -complete=customlist,xidelplay#complete XidelplayScratch call xidelplay#scratch(<bang>0, <q-mods>, <q-args>)
