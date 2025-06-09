vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "highlight yanked region",
	group = vim.api.nvim_create_augroup("highlight_yank", {clear=true}),
	callback = function()
		-- vim.hl.on_yank({higroup = "IncSearch", timeout = 150, on_visual = true})
		vim.highlight.on_yank({higroup = "IncSearch", timeout = 150, on_visual = true})
	end
})

-- use *i_CTRL-U*
-- vim.api.nvim_create_autocmd(
--     "FileType",{
--     pattern = "*",
--     -- command = "set fo-=c fo-=r fo-=o",
--         callback = function() vim.opt.formatoptions = vim.opt.formatoptions - { "c","r","o" } end,
--     group   = vim.api.nvim_create_augroup("Disable annoying formatoptions' defaults", { clear = true })
-- })


-- terminal
-- local term_group = vim.api.nvim_create_augroup("ConfigTerminal", { clear = true })
-- vim.api.nvim_create_autocmd("WinEnter", {
    -- group = term_group,
    -- pattern = "term://*",
    -- command = 'startinsert'
-- })
-- vim.api.nvim_create_autocmd("TermEnter", {
--     group = term_group,
--     command = 'set signcolumn=no | startinsert'
-- })
-- vim.api.nvim_create_autocmd('TermOpen', {
--     group = term_group,
--     command = 'setlocal listchars= nonumber norelativenumber nocursorline nolist scl=no',
-- })

-- ---@see https://github.com/mfussenegger/nvim-dap/issues/439#issuecomment-1380787919
vim.api.nvim_create_autocmd("TermOpen", {
    group = vim.api.nvim_create_augroup("ConfigTerminal", { clear = true }),
    callback = function(opts)
        if opts.file:match('dap%-terminal') then
            return
        end
        -- vim.cmd('startinsert')
        -- vim.cmd('setlocal nonu')
    end,
})

        -- vim.api.nvim_create_autocmd("TermOpen",
        --         { pattern = "term://*", command = [[nnoremap <buffer> <LeftRelease> <LeftRelease>i]] })
        --
        --     vim.api.nvim_create_autocmd({ "TermEnter", "TermOpen", "BufNew", "BufEnter" }, {
        --         pattern = "term://*",
        --
        --         callback = function(arg)
        --             if not arg.file:match("dap%-terminal") then
        --                 vim.api.nvim_command("startinsert")
        --             end
        --         end
        --     })

-- quickfix
local qf_group = vim.api.nvim_create_augroup("ConfigQuickfix", { clear = true })
-- I don't want to move my eyes
-- vim.api.nvim_create_autocmd('Filetype', {
--   group = qf_group,
--   pattern = 'qf',
--   command = 'wincmd K'
-- })
-- from nvchad
-- -- dont list quickfix buffers
vim.api.nvim_create_autocmd("FileType", {
  group = qf_group,
  pattern = "qf",
  callback = function()
    vim.opt_local.buflisted = false
  end,
})

-- edit xournal files (see https://vi.stackexchange.com/a/10390/854)
vim.cmd([[
augroup gzip_local2
    autocmd!
    autocmd BufReadPre,FileReadPre     *.xopp setlocal bin
    autocmd BufReadPost,FileReadPost   *.xopp call gzip#read("gzip -dn -S .xopp")
    autocmd BufWritePost,FileWritePost *.xopp call gzip#write("gzip -S .xopp")
    autocmd FileAppendPre              *.xopp call gzip#appre("gzip -dn -S .xopp")
    autocmd FileAppendPost             *.xopp call gzip#write("gzip -S .xopp")
augroup END
]])

-- anki
vim.cmd([[
augroup zip_local2
    autocmd!
    au BufReadCmd *.apkg call zip#Browse(expand("<amatch>"))
augroup END
]])

-- 7z? (/tmp/.mount_nvimoTFDZO/usr/share/nvim/runtime/doc/pi_zip.txt)

-- https://vim.fandom.com/wiki/Automatically_indent_an_XML_file_using_XSLT
-- vim.cmd([[
-- if version >= 540
--   augroup filetype
--     autocmd FileType xml exe "'[,']!xsltproc " .. stdpath('config') .. "/lua/config/indent.xsl %"
--   augroup END
-- endif
-- " other autocmds
-- if version>540
--   autocmd!
-- endif
-- ]])

-- https://www.reddit.com/r/neovim/comments/1abd2cq/what_are_your_favorite_tricks_using_neovim/
-- Jump to last edit position on opening file
-- can I use g; instead of g'"?
-- vim.cmd([[
--   au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"zzzv" | endif
-- ]])

-- vim.api.nvim_create_autocmd("Filetype", {
--   pattern = 'help',
--   desc = "Fuzzy find tags in current help file",
-- 	group = vim.api.nvim_create_augroup("HelpTags", {clear=true}),
-- 	callback = function()
--     -- vim.keymap.set('n','m',[[/\*[^*]\+\*$<CR>]],{buffer=true})
--     vim.keymap.set('n','m',function()
--       -- use shellescape?
--       -- Così ho i tag, ma come posso fuzzy findarli...
--       -- require('telescope.builtin').live_grep({ default_text = [[\*[^*]+\*$]], disable_coordinates = true,path_display = {'hidden'},additional_args = {'-o'}, search_dirs = {vim.fn.expand('%')} })
--       -- Non accetta regex
--       require('telescope.builtin').current_buffer_fuzzy_find({ default_text = [[\*[^*]+\*$]], disable_coordinates = true,path_display = {'hidden'},additional_args = {'-o'}, search_dirs = {vim.fn.expand('%')} })
--     end,{buffer=true})
-- 	end
-- })

-- https://www.reddit.com/r/neovim/comments/zrl381/i_need_help_finishing_the_translation_from_vimrc/
-- vim.api.nvim_create_augroup("numbertoggle", { clear = true })

-- vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave" }, {
--   callback = function()
--     vim.opt.relativenumber = true
--   end,
--   group = "numbertoggle",
-- })

-- vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter" }, {
--   callback = function()
--     vim.opt.relativenumber = false
--   end,
--   group = "numbertoggle",
-- })

-- vim.api.nvim_create_autocmd("Filetype", {
--     pattern = 'gitcommit',
--     desc = "Goto next commit template marker",
--     group = vim.api.nvim_create_augroup("gitcommit_marker", {clear=true}),
--     callback = function()
--         -- Subject,  Problem,  Solution, Note
--         -- vim.keymap.set({'n','i'},'<space><space>',[[<CMD>call search('^\u')|call setline(".","")|startinsert<CR>]],{buffer=true})
--         vim.keymap.set({'n','i'},'<space><space>',[[<CMD>call search('^#')|+|call setline(".","")|startinsert<CR>]],{buffer=true})
--     end
-- })

-- vim.api.nvim_create_autocmd("BufLeave", {
--     pattern = '*',
--     desc = "Backup of unsaved notes",
--     group = vim.api.nvim_create_augroup("Save_Note", {clear=true}),
--     callback = function()
--         if vim.fn.expand('%') == '' and vim.fn.line('$') > 100 then
--         vim.cmd.write('/dev/stdin','/tmp/'..os.date('%s'))
--         end
--     end

-- })

vim.cmd([=[
fun! ToggleRot13()
" https://vi.stackexchange.com/questions/4120/how-to-enable-disable-an-augroup-on-the-fly
"if !exists('#Rot13#TextChangedI')
if !exists('#Rot13#InsertCharPre')
    augroup Rot13
    autocmd!
    "autocmd TextChangedI * let save_cursor = getcurpos()|s/\a\%#/\=submatch(0) =~ '[a-mA-M]' ?  (char2nr(submatch(0))+13)->nr2char() : (char2nr(submatch(0))-13)->nr2char()/e|call setpos('.', save_cursor)
    "autocmd TextChangedI * let save_cursor = getcurpos() |
    "\ s/\a\%#/\=submatch(0) =~ '[a-mA-M]' ?  (char2nr(submatch(0))+13)->nr2char() : (char2nr(submatch(0))-13)->nr2char()/e |
    "\ call setpos('.', save_cursor)
    "augroup END
    au InsertCharPre * let v:char = v:char =~ '[[:alpha:]]' ? (v:char =~ '[a-mA-M]' ?  (char2nr(v:char)+13)->nr2char() : (char2nr(v:char)-13)->nr2char()) : v:char
else
    augroup Rot13
    autocmd!
    augroup END
endif
endfun

" Related to g?
nnoremap g! <CMD>call ToggleRot13()<CR>
]=])

---@see https://www.reddit.com/r/neovim/comments/1ct2w2h/lua_adaptation_of_vimcool_auto_nohlsearch/
vim.api.nvim_create_autocmd('CursorMoved', {
  group = vim.api.nvim_create_augroup('auto-hlsearch', { clear = true }),
  callback = function ()
    if vim.v.hlsearch == 1 and vim.fn.searchcount().exact_match == 0 then
      vim.schedule(function () vim.cmd.nohlsearch() end)
    end
  end
})

-- fai in modo che edit/read/etc... usino directory del current buffer come cwd, se vuoi usare file di progetto usa Gedit
---@see https://stackoverflow.com/a/3847823
-- limitazione: non usando questo o autochdir hai tre cartelle/cwd a disposizione: quella del buffer, quella del progetto (.git) e quella con cui hai aperto vim; cosi ne hai solo 2 (ti manca quest'ultima)
---@see https://github.com/HakonHarnes/img-clip.nvim/issues/15#issuecomment-1878254072 (maybe just use this for wiki files?)
-- vim.api.nvim_create_autocmd({ 'BufEnter' }, {
--   group = vim.api.nvim_create_augroup('autochdir', { clear = false }),
--   -- pattern = '*',
--   pattern = vim.fn.expand('~') .. '/vimwiki/**',
--   -- command = [[silent! if empty(v:lua.Snacks.git.get_root()) | lcd %:p:h | endif]]
--   -- cool setup: if not in project (usually git dir), then mimick autochdir
--   -- setup inverso: uso :e per file nella directory del file corrente e Gedit per quelli di progetto
--   command = [[silent! lcd %:p:h]],
--   -- command = [[silent! if !empty(v:lua.Snacks.git.get_root()) | lcd %:p:h | endif]]
-- })

-- vim.api.nvim_create_autocmd("BufEnter", {
--   group = vim.api.nvim_create_augroup('IHateYAML', { clear = false }),
--   pattern = "~/.config/lazygit/config.yml",
--   callback = function()
--       vim.cmd.norm('%!yq -P -ol')
--   end,
-- })
-- vim.api.nvim_create_autocmd("BufLeave", {
--   group = vim.api.nvim_create_augroup('IHateYAML', { clear = false }),
--   pattern = "~/.config/lazygit/config.yml",
--   callback = function()
--       vim.cmd.norm('%!yq -P -oy')
--   end,
-- })
-- vim.cmd[[au BufRead,BufNewFile ~/.config/nvim/doc/*.txt set filetype=help]]
-- interessante ;d (finche non fixo kanata discussion)
-- vim.cmd[[au InsertEnter * !systemctl --user stop kanata.service]]
-- vim.cmd[[au InsertLeave * !systemctl --user restart kanata.service]]

vim.api.nvim_create_autocmd("BufEnter", {
  desc = "Goto next section",
  pattern = "/tmp/apy_note_*.md",
	group = vim.api.nvim_create_augroup("anki_goto", {clear=true}),
	callback = function()
        -- vim.keymap.set({'n','i'},'<space><space>','<cmd>/^##/+<cr><cmd>startinsert<cr>')
        vim.keymap.set({'n'},']]','<cmd>/^##/+<cr><cmd>startinsert<cr>')
        vim.keymap.set({'n'},'[[','<cmd>?^##?+<cr><cmd>startinsert<cr>')
	end
})
-- ╭─────────────────────────────────────────────────────────╮
-- │ kanata.nvim plugin?                                     │
-- ╰─────────────────────────────────────────────────────────╯
-- -- also do these two for emacs/tridactyl/etc...
-- -- HACK: spawn neovim in far far workspace so for successive neovim spawn this code doesn't get executed (doesn't work)
-- vim.api.nvim_create_autocmd({--[["FocusGained",]]"VimEnter"}, {
-- -- vim.api.nvim_create_autocmd("BufEnter", {
--   desc = "Kanata mouse to brackets&backslash",
-- 	group = vim.api.nvim_create_augroup("KanataRem", {clear=true}), -- pattern = "*",
--     command = [[
--     if str2nr(system("grep -cm1 '^;;SUB .* ;;SUB$' ~/.config/kanata/config.kbd"))==1
--     call system("sed -i '/ ;;SUB$/s/^;;SUB //' ~/.config/kanata/config.kbd")
--     "" lualine component?
--     "magari usa tasto reload kanata (rld) magari con f11 or smth
--     " wtype -k f11 doesn't work...
--     call system("systemctl --user restart kanata")
-- endif
--         ]],
-- })
--
-- vim.api.nvim_create_autocmd({--[["FocusLost",]]"VimLeave"}, {
--   desc = "Kanata mouse to brackets&backslash",
--   -- apparently u have to use another name for augroup?
-- 	group = vim.api.nvim_create_augroup("KanataAdd", {clear=true}),
--     --  maybe check if in another hyprland workspace?
--     command = [[
--     if str2nr(system("grep -m1 ' ;;SUB$' ~/.config/kanata/config.kbd | grep -c '^;;SUB '"))==0 && systemlist("pgrep -a nvim|grep -vw -- --embed")->len()==1
--     "if str2nr(system("grep -m1 ' ;;SUB$' ~/.config/kanata/config.kbd | grep -c '^;;SUB '"))==0 && str2nr(system("pgrep -c nvim"))==1
--     call system("sed -i '/ ;;SUB$/s/^/;;SUB /' ~/.config/kanata/config.kbd")
--     call system("systemctl --user restart kanata")
-- endif
--         ]],
-- })

-- for git add --patch
-- same as editdiff really
-- vim.api.nvim_create_autocmd( "BufWritePre", {
-- vim.api.nvim_create_autocmd( "VimLeave", {
--     pattern = "addp-hunk-edit.diff",
--     -- would be nice to restore cursor position (if using BufWritePre obviously)
--     command = "%!rediff % /dev/stdin"
-- }
-- )

-----------------------------------------------------------
-- Man Pages
-----------------------------------------------------------

-- doesn't work when man called from the command line :/
-- Make check this implementation?
-- q                         :quit if invoked as $MANPAGER, otherwise :close.
local manpage_group = vim.api.nvim_create_augroup('Man Pages',{})

-- " search option (with flash.nvim integration)
vim.api.nvim_create_autocmd('Filetype', {
    -- vim.api.nvim_create_autocmd({'Filetype','VimEnter'}, {
    pattern = "man",
    -- nice that o, O and go complement Neovim's gO well (same letters, kinda)
    callback = function()
        -- vim.keymap.set('n', 's', [[/^\s\+\zs-]])
        -- s può tornare utile... mentre le man pages non possono essere modificate, quindi o/O vanno bene (o for option of course)
        -- vim.keymap.set('n', 'o', [[/^\s\+\zs-]])
        vim.api.nvim_buf_set_keymap(0,'n', 'o', [[/\C^\s\+\zs-]],{}) -- search short options
        -- " per le opzioni lunghe (2 dashes)
        -- vim.keymap.set('n', 'S', [[/^\s\+\zs--]])
        -- vim.keymap.set('n', 'S', [[/\C^\s\+\(-.*\)\=\zs--]])
        -- vim.keymap.set('n', 'O', [[/\C^\s\+\(-.*\)\=\zs--]])
        vim.api.nvim_buf_set_keymap(0,'n', 'O', [[/\C^\s\+\(-.*\)\=\zs--]],{}) -- search long options

        -- go to byte in a man page is beyond useless
        -- case insensitive? ci metto tutto
        vim.api.nvim_buf_set_keymap(0,'n', 'go', [[/^\s\+\zs--\=]],{}) -- search both short and long options

    end,
    group = manpage_group
})

-- https://www.reddit.com/r/neovim/comments/1k4efz8/share_your_proudest_config_oneliners/
vim.cmd[[autocmd QuickFixCmdPost l\=\(vim\)\=grep\(add\)\= norm mG]]

vim.api.nvim_create_autocmd('ColorScheme', {
    group = vim.api.nvim_create_augroup('DiffColors', { clear = true }),
    callback = function()
        local is_dark = vim.o.background == 'dark'
        if is_dark then
            vim.api.nvim_set_hl(0, 'DiffAdd', { fg = 'none', bg = '#2e4b2e', bold = true })
            vim.api.nvim_set_hl(0, 'DiffDelete', { fg = 'none', bg = '#4c1e15', bold = true })
            vim.api.nvim_set_hl(0, 'DiffChange', { fg = 'none', bg = '#45565c', bold = true })
            vim.api.nvim_set_hl(0, 'DiffText', { fg = 'none', bg = '#996d74', bold = true })
        else
            vim.api.nvim_set_hl(0, 'DiffAdd', { fg = 'none', bg = 'palegreen', bold = true })
            vim.api.nvim_set_hl(0, 'DiffDelete', { fg = 'none', bg = 'tomato', bold = true })
            vim.api.nvim_set_hl(0, 'DiffChange', { fg = 'none', bg = 'lightblue', bold = true })
            vim.api.nvim_set_hl(0, 'DiffText', { fg = 'none', bg = 'lightpink', bold = true })
        end
    end
})

vim.api.nvim_create_autocmd('BufRead', {
    desc = "Zen",
    pattern = '*',
    group = vim.api.nvim_create_augroup("Zen", {clear=true}),
    callback = function()
        if vim.bo.filetype ~= "org" then
            return
        end
        Snacks.zen()
    end,
})
