-- rule: use keymaps for stuff that modifies the content and commands for everything else
-- todo: add aliases also for subcommands? shouln't really be necessary with blink.cmp completion but still
-- how to auto show the menu after expanding alias though?
return {
  'Konfekt/vim-alias',
  cmd = 'Alias',
  event = 'CmdLineEnter',
  config = function()
    --  let g:cmdalias_cmdprefixes+=[ "help", "FloatingHelp" ]
    -- vim.g.cmdalias_cmdprefixes+=[ "checkhealth" ]
    -- rule: uppercase for neovim command, lowercase for plugins
    --   Alias -range C  checkhealth
    --  "for commands w/ subcommands, type letter and enter to execute
    -- automatically autocomplete for these?
    vim.cmd [[
 Alias -range g  Neogit
 Alias -range gs  Gitsigns
 Alias -range o  Octo
 Alias -range l  Lazy
 Alias -range m  Mason
 Alias -range f  Feed
]]
      -- "Alias -range <space>  lua
    for char_code = 33, 126 do
      local char = string.char(char_code)
      if char:match("[%p]") then
        vim.keymap.set('c', char, tostring([[getcmdtype()==#'/'?]] .. vim.fn.string(char) .. ":" .. vim.fn.string(char)), { expr = true })
      end
    end

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
