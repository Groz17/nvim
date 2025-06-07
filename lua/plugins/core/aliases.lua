-- rule: use keymaps for stuff that modifies the content and commands for everything else
-- todo: add aliases also for subcommands? shouln't really be necessary with blink.cmp completion but still
-- how to auto show the menu after expanding alias though?
return {
  'Konfekt/vim-alias',
  cmd = 'Alias',
  event = 'CmdLineEnter',
  config = function()
    vim.cmd([[
    let g:cmdalias_cmdprefixes+=[ "help", "FloatingHelp" ]
    let g:cmdalias_cmdprefixes+=[ "checkhealth" ]
    "rule: uppercase for neovim command, lowercase for plugins
  Alias -range C  checkhealth
 "for commands w/ subcommands, type letter and enter to execute
  Alias -range g  Git
  Alias -range o  Octo
  Alias -range n  Neorg
  Alias -range l  Lazy
  Alias -range m  Mason
  Alias -range f  Feed
  "Alias -range <space>  lua
" Auto escape / and ? in search command
cnoremap <expr> / getcmdtype() ==# '/' ? "\/" : "/"
"TODO:  do this for all other non-space characters like , (low priority)
]])
  end,
}

-- do for cli commands plugins, like git and github (copy from their config the aliases)
-- actually fugitive does the work
-- use for octo...
        --Alias -buffer    spl  setlocal\ spell<bar>setlocal\ spelllang=en
        --Alias            w!!  write\ !sudo\ tee\ >\ /dev/null\ %
        --Alias            F    find\ *<c-r>=Eatchar("\ ")<cr>
        --Alias            th   tab\ help
        --Alias            sft  setfiletype
        --Alias -range     il   ilist\ /\v/<left><c-r>=EatChar("\ ")<cr>
        --Alias -range     dl   dlist\ //<left><c-r>=EatChar("\ ")<cr>
        --Alias            g  Git
        --Alias            gbl  Silent\ tig\ blame\ +<c-r>=line('.')<cr>\ --\ %:S<c-left><c-left><left>
        --Alias -range     tl   !translate\ -no-warn\ -no-ansi\ -brief\ -to
        --Aliases
-- vim.cmd[[
-- "cnoreabbrev <expr> g ((getcmdtype() is# ':' && getcmdline() =~ '^t')?('G'):('g'))
-- ]]
