-- visually select all if/else/etc? with multicursor.lua?

-- nmap <silent> <F7> <plug>(matchup-hi-surround)
-- match-up provides built-in support for vim-surround-style ds% and cs% operations (let g:matchup_surround_enabled = 1).
-- https://github.com/andymass/vim-matchup#tree-sitter-integration

return {
  "andymass/vim-matchup",
  -- event = 'VeryLazy',
  event = "BufReadPost",
  init = function()
    vim.g.matchup_surround_enabled = 1
    -- may set any options here
    vim.g.matchup_matchparen_offscreen = { method = "popup" }

  end,
  config = function()
    -- set up m as alias of % (also for text objects?)
    -- vim.keymap.set('o', 'm', '%', { noremap = false })
    vim.keymap.set('n', 'dsm', 'ds%', { noremap = false })
    vim.keymap.set('n', 'csm', 'cs%', { noremap = false })
    -- vim.cmd([[
    --   function! s:matchup_convenience_maps()
    --     xnoremap <sid>(std-I) I
    --     xnoremap <sid>(std-A) A
    --     xmap <expr> I mode()=='<c-v>'?'<sid>(std-I)':(v:count?'':'1').'i'
    --     xmap <expr> A mode()=='<c-v>'?'<sid>(std-A)':(v:count?'':'1').'a'
    --     for l:v in ['', 'v', 'V', '<c-v>']
    --       execute 'omap <expr>' l:v.'I%' "(v:count?'':'1').'".l:v."i%'"
    --       execute 'omap <expr>' l:v.'A%' "(v:count?'':'1').'".l:v."a%'"
    --     endfor
    --   endfunction
    --   call s:matchup_convenience_maps()
    -- ]])
  end,
}
