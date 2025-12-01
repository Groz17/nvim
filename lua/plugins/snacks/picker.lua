-- usa ctrl+m per <cr> (confirm)
-- how to grep on files found with files? (or in general switch to another picker inside picker? 3 pickers)
-- order/sort each picker by frecency? (by default)
-- check if some need visual mode mappings (like grep lines ig)
-- filter list w/ regex?
-- close picker when c-h and empty input?
-- rotate preview as in fzf-lua?
-- ivy feature parity: set the default action with C-M-a
-- show current index (idx/tot)
return {
  'snacks.nvim',
  -- crea mapping con which-key delle keybindings specifiche del picker
  -- basically in insert popup near cursor, otherwise auto
  -- add c-x 4,5 mappings?
  keys = {
    -- ╭─────────────────────────────────────────────────────────╮
    -- │ BUFFERS AND FILES                                       │
    -- ╰─────────────────────────────────────────────────────────╯
    -- you've got 4 variations for every mapping: {c,s,a}?<symbol>
    -- crea if not exist like emacs
    -- what about unlisted?
    -- should probably exclude first empty buffer?
    -- modified=true?
    { "<f12>b", function() Snacks.picker.buffers() end, desc = "Buffers" ,mode={'n','i'}},
    { "<f12>pb", function() Snacks.picker.buffers({ filter = { paths = { [Snacks.git.get_root()] = true } } }) end, desc = "Buffers (root)" ,mode={'n','i'}},

    -- show which-key when ctrl (d/k) held
    { '<c-p>', function() Snacks.picker.files({ cwd = vim.fn.expand('%:p:h') }) end, desc = 'Find Files relative to open buffer' ,mode={'n','i'}},
    { '<f12><c-f>', function() Snacks.picker.files({ cwd = vim.fn.expand('%:p:h'), args = {"-d1"}, }) end, desc = 'find-files' ,mode={'n','i'}},
    -- queste opzioni le puoi togglare tanto...
    -- usa stesso modello di usare shift per cwd
    -- should not open another picker if C-{c,g} pressed
    { '<c-s-p>', function() Snacks.picker.files({}) end, desc = 'Find File' ,mode={'n','i'}},
    { '<f12>pf', function() Snacks.picker.files({}) end, desc = 'Find File' ,mode={'n','i'}},

    { '<f18>P', function() Snacks.picker.files({rtp = true, pattern="file:md$ "}) end, desc = "Plugins' docs",mode={'n','i'}},

    -- ╭─────────────────────────────────────────────────────────╮
    -- │ SEARCH                                                  │
    -- ╰─────────────────────────────────────────────────────────╯
    -- on how repetedly apply search?
    -- grep operator?
    -- oppure C-q? magari solo x qwerty
    -- Make it work for current file as well
    -- grep functions should take v:count meaning -C (cxt)
    { '<c-q>', function() Snacks.picker.grep({ cwd = vim.fn.expand('%:p:h') }) end, desc = 'Grep' ,mode={'n','i'}},
    { '<c-s-q>', function() Snacks.picker.grep({}) end, desc = 'Grep' ,mode={'n','i'}},

    -- Snacks.picker.grep({rtp = true, pattern="file:md$"})

    -- win is winnr-1? or is it always -1?
    -- HACK (would be cool to show light version of current theme)
    { '<f17>/', function() Snacks.picker.lines({}) end, desc = 'Buffer Lines' ,mode={'n','i'}},
    -- same as swiper-all
    -- make it work for special buffers like man pages
    -- { [[<f17>/]], function() Snacks.picker.grep_buffers() end, desc = 'Grep Open Buffers' ,mode={'n','i'}}, -- same mapping as Snacks.picker.buffers()
    -- how to grep only in current buffer?
    -- { '<f17>W', function() Snacks.picker.grep_word({live=true, dirs = {vim.uv.cwd()}}) end, desc = 'Visual selection or word', mode = { 'n', 'x' } },
    -- escape regex?
    -- { '<f17>W', function() Snacks.picker.grep_word({live=true, dirs = {vim.fn.expand('%:p:h')}}) end, desc = 'Visual selection or word', mode = { 'n', 'x' } },
    -- vedi * come current directory (da qui ad avanti) e # come includi passato
    { '<f17>8', function() Snacks.picker.grep_word({live=true, dirs = {vim.fn.expand('%:p:h')}}) end, desc = 'Visual selection or word', mode = { 'n', 'x' } },
    -- { '<f17>W', function() Snacks.picker.grep_word({live=true}) end, desc = 'Visual selection or word', mode = { 'n', 'x' } },
    { '<f17>3', function() Snacks.picker.grep_word({live=true}) end, desc = 'Visual selection or word', mode = { 'n', 'x' } },
    { '<m-s>.', function() Snacks.picker.grep_word({live=true}) end, desc = 'Visual selection or word', mode = { 'n', 'x' } },
    -- ╭─────────────────────────────────────────────────────────╮
    -- │ GIT                                                     │
    -- ╰─────────────────────────────────────────────────────────╯
    -- { "<f17>F", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
    { '<f17>gf', function() Snacks.picker.git_files() end, desc = 'Files' ,mode={'n','i'}},
    { '<f17>gL', function() Snacks.picker.git_log() end, desc = 'Log' ,mode={'n','i'}},
    -- how to use delta here?
    { '<f17>gs', function() Snacks.picker.git_status() end, desc = 'Status' ,mode={'n','i'}},
    { '<f17>gb', function() Snacks.picker.git_branches() end, desc = 'Branches' ,mode={'n','i'}},
    { '<f17>gd', function() Snacks.picker.git_diff() end, desc = 'Diff' ,mode={'n','i'}},
    { '<f17>gl', function() Snacks.picker.git_log_file() end, desc = 'Log File' ,mode={'n','i'}},
    { '<f17>g.', function() Snacks.picker.git_log_line() end, desc = 'Log Line' ,mode={'n','i'}},
    { '<f17>gS', function() Snacks.picker.git_stash() end, desc = 'Stash' ,mode={'n','i'}},
    -- file:lua qua equivalent? for mapping
    { '<f17>gg', function() Snacks.picker.git_grep() end, desc = 'Grep' ,mode={'n','i'}},
    -- ╭─────────────────────────────────────────────────────────╮
    -- │ GITHUB                                                  │
    -- ╰─────────────────────────────────────────────────────────╯
    { "<leader>gi", function() Snacks.picker.gh_issue() end, desc = "GitHub Issues (open)" },
    { "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end, desc = "GitHub Issues (all)" },
    { "<leader>gp", function() Snacks.picker.gh_pr() end, desc = "GitHub Pull Requests (open)" },
    { "<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end, desc = "GitHub Pull Requests (all)" },
    -- ╭─────────────────────────────────────────────────────────╮
    -- │ NEOVIM                                                  │
    -- ╰─────────────────────────────────────────────────────────╯
    -- { mode = { 'c' }, '<a-r>', function() if cmdmode="/"Snacks.picker.search_history() end, desc = 'Command History' },
    -- fits kinda nice with default keybinding c-r
    -- { mode = { 'c' }, '<c-r>', function() Snacks.picker.command_history() end, desc = 'Command History' },
    -- incremental in command mode? add range if called in visual mode?
    -- { '<m-p>', function() Snacks.picker.command_history() end, desc = 'Command history' ,mode={'n','i','x'}},

    -- problema dei simboli con kanata: <f17>F e <space><space>fl for <space><space>=?
    { '<f17>+', function() Snacks.picker.cliphist() end, desc = 'Clipboard history' ,mode={'n','i'}},
    { "<f17>'", function() Snacks.picker.registers() end, desc = 'Registers' ,mode={'n','i'}},
    { '<f17>A', function() Snacks.picker.autocmds() end, desc = 'Autocmds' ,mode={'n','i'}},
    -- { '<f17>#', function() Snacks.picker.autocmds() end, desc = 'Autocmds' },
    -- like for exists() function
    { '<f17>:', function() Snacks.picker.command_history() end, desc = 'Command History' },
    -- { '<f17>/', function() Snacks.picker.search_history() end, desc = 'Search History' },
    -- doesn't work...
    -- { '<f17><cr>', function() Snacks.picker.commands() end, desc = 'Commands' },
    -- like emacs C-h x?
    -- { '<f17>x', function() Snacks.picker.commands() end, desc = 'Commands' },
    -- also include completions (subcommands)? so u don't have to use mappings... (use ^<name of command> as pattern), or maybe press enter and list subcommands?
    -- should respect v:count (also negative 😏)
    { '<m-x>', function() Snacks.picker.commands() end, desc = 'Commands' ,mode={'n','i','x'}},
    { '<f17>D', function() Snacks.picker.diagnostics() end, desc = 'Diagnostics' ,mode={'n','i'}},
    { '<f17>d', function() Snacks.picker.diagnostics_buffer() end, desc = 'Diagnostics buffer' ,mode={'n','i'}},
    -- mapping to seach only in neovim docs?
    { '<f18>o', function() Snacks.picker.help() end, desc = 'Help Pages' ,mode={'n','i'}},
    { '<f18>v', function() Snacks.picker.help({search="'"}) end, desc = 'Help Pages (variables)' ,mode={'n','i'}},
    -- { '<c-h>', function() Snacks.picker.help() end, desc = 'Help Pages' ,mode={'n','i'}},
    -- add PR to make mappings all work like this...
    -- C-u in Visual mode means the <cWORD> (because u concatenate C-u before the string is longer like the thing you're inputting)
    -- { mode='x','<f17>h', function() Snacks.picker.help({pattern=table.concat(vim.fn.getregion( vim.fn.getpos ".", vim.fn.getpos "v", { type = vim.fn.mode() }))}) end, desc = 'Help Pages' },

    -- use same binding as syoke?
    { '<f17>h', function() Snacks.picker.highlights() end, desc = 'Highlights' },
    -- similar to zS tpope binding
    -- M-s h?
    -- vedi se a <f17>J e <space><space>k puoi dare mapping migliori
    { '<f17>j', function() Snacks.picker.jumps() end, desc = 'Jumps' ,mode={'n','i'}},
    -- use v:count to target mods
    -- which-keys prefix desc should get prefixed in suffixed mappings desc
    { '<f18>b', function() Snacks.picker.keymaps() end, desc = 'Keymaps' ,mode={'n','i'}},
    -- { '<f18>B', function() Snacks.picker.keymaps({plugs=true}) end, desc = 'Keymaps' ,mode={'n','i'}},

    { '<f17>o', function() Snacks.picker.loclist() end, desc = 'Location List' ,mode={'n','i'}},
    { '<f17>O', function() Snacks.picker.qflist() end, desc = 'Quickfix List' ,mode={'n','i'}},

    -- what about info pages?
    { '<f17>m', function() Snacks.picker.man() end, desc = 'Man Pages' ,mode={'n','i'}},
    -- not sure
    { "<f12>rl", function() Snacks.picker.marks() end, desc = 'Marks' ,mode={'n','i'}},
    -- also create insert mode mapping <f17>D
    -- { '<bs>', function() Snacks.picker.resume() end, desc = 'Resume' ,mode={'n','i'}},
    -- v:count?
    { '<s-bs>', function() Snacks.picker.resume() end, desc = 'Resume' ,mode={'n','i'}},
    -- <f17>C for all colorschemes, <space><space>c for plugin's colorschemes? use univeral argument
    -- how to preview the current buffer? 
    -- { '<f17>C', function() Snacks.picker.colorschemes() end, desc = 'Colorschemes' },
    -- avoid jumpscare by sorting based on similar colors? use lowercase for same bg and uppercase for all?
    { '<f17>c', function() Snacks.picker.colorschemes() end, desc = 'Colorschemes' ,mode={'n','i'}},
    -- go back w/ C-h if first char?
    -- define your dirs?
    { '<f12>pp', function() Snacks.picker.projects() end, desc = 'Projects' ,mode={'n','i'}},
    -- ╭─────────────────────────────────────────────────────────╮
    -- │ LSP                                                     │
    -- ╰─────────────────────────────────────────────────────────╯
    { '<f17>L', function() Snacks.picker.lsp_config() end, desc = 'LSP' ,mode={'n','i'}},
    { 'grc', function() Snacks.picker.lsp_incoming_calls() end, desc = 'Incoming calls' ,mode={'n','i'}},
    { 'grC', function() Snacks.picker.lsp_outgoing_calls() end, desc = 'Outgoing calls' ,mode={'n','i'}},
    -- quickfix is just one keypress away (<c-q>)
    -- create kanata/vim leader layer for lsp mappings?
    -- { [[gD]], function() Snacks.picker.lsp_declarations() end, desc = 'Goto Declaration' ,mode={'n','i'}},
    -- { [[gd]], function() Snacks.picker.lsp_definitions() end, desc = 'Goto Definition' ,mode={'n','i'}},
    --C-u M-.              prompt jump to definition (TAB to complete)
    { '<m-.>', function() Snacks.picker.lsp_definitions() end, desc = 'Goto Definition' ,mode={'n','i'}},
    -- { [[grr]], function() Snacks.picker.lsp_references() end, nowait = true, desc = 'References' ,mode={'n','i'}},
    { '<m-s-/>', function() Snacks.picker.lsp_references() end, nowait = true, desc = 'References' ,mode={'n','i'}},
    -- { [[gri]], function() Snacks.picker.lsp_implementations() end, desc = 'Goto Implementation' ,mode={'n','i'}},
    -- { [[gy]], function() Snacks.picker.lsp_type_definitions() end, desc = 'Goto T[y]pe Definition' ,mode={'n','i'}},
    -- { '<m-g>i', function() Snacks.picker.lsp_symbols() end, desc = 'LSP Symbols' }, -- imenu
    -- counsel-semantic-or-imenu
    -- { '<m-g>i', function() Snacks.picker.lsp_symbols({layout = {preset = "vscode", preview = "main"}}) end, desc = 'LSP Symbols' ,mode={'n','i'}},
    { [[<c-m-.>]], function() Snacks.picker.lsp_workspace_symbols() end, desc = 'LSP Workspace Symbols' ,mode={'n','i'}},
    -- ╭─────────────────────────────────────────────────────────╮
    -- │ MISC                                                    │
    -- ╰─────────────────────────────────────────────────────────╯
    { '<f17>n', function() Snacks.picker.notifications() end, desc = 'Notifications' ,mode={'n','i'}},
    { '<f17>s', function() Snacks.picker.treesitter() end, desc = 'Treesitter' ,mode={'n','i'}},
    { '<f17>r', function() Snacks.picker.recent({ filter = { cwd = true }}) end, desc = 'Recent (cwd)' ,mode={'n','i'}},
    { '<f17>R', function() Snacks.picker.recent() end, desc = 'Recent' ,mode={'n','i'}},
    -- replace mini.files?
    -- open in the middle if it open a directory? and no other buffers maybe...
    { '<f17>e', function() Snacks.picker.explorer({ cwd = vim.fn.expand('%:p:h') }) end, desc = 'Explorer (cwd)' ,mode={'n','i'}},
    -- git repo/root? reveal?
    { '<f17>E', function() Snacks.picker.explorer() end, desc = 'Explorer' ,mode={'n','i'}},
    { '<f17>u', function() Snacks.picker.undo() end, desc = 'Undotree' ,mode={'n','i'}},
    -- doesnt show all plugins? maybe y and Y mappings?
    -- would be cool if it added tags like for colorschemes, etc... help files...
    -- add action to go to file lazy share?
    -- <f18>P for plugin docs
    { '<f17>l', function() Snacks.picker.lazy() end, desc = 'Lazy' },
    -- use v:count
    {mode={"n","i"},'<f12>8es', function() Snacks.picker.icons({icon_sources={'emoji'}}) end, desc = 'Emojis' },
    -- {mode={"i"},'<f17>i', function() Snacks.picker.icons({layout = {preset = "cursor"}}) end, desc = 'Icons' },
    -- cursor doesn't exist?
    -- {mode={"n","i"},'<f17>i', function() Snacks.picker.icons(--[[{layout = {preset = "dropdown"}]]) end, desc = 'Icons' },
    {mode={"n"},'<f17>i', function() Snacks.picker.icons(--[[{layout = {preset = "dropdown"}]]) end, desc = 'Icons' },

    { '<f17>z', function() Snacks.picker.zoxide() end, desc = 'Zoxide' ,mode={'n','i'}}, --crea file if no match?
    -- like for z=
    { '<M-S-4>', function() Snacks.picker.spelling() end, desc = 'Spelling' ,mode={'n','i'}},
  },
      opts = function()
            -- https://github.com/folke/snacks.nvim/discussions/2018
            local commands = {
              actions = {
                accept = function(picker, item)
                  vim.cmd(item.cmd)
                  picker:close()
                end,
              },
              win = {
                input = {
                  keys = {
                    -- like ivy?
                    -- ['<C-a-j>'] = { 'accept', mode = { 'i', 'n' } }, -- Execute
                    -- ['<CR>'] = { 'confirm', mode = { 'i', 'n' } }, -- Choose
                    -- like atuin (tab doesn't make sense here, does it?)
                    ['<cr>'] = { 'accept', mode = { 'i', 'n' } }, -- Execute
                    ['<tab>'] = { 'confirm', mode = { 'i', 'n' } }, -- Choose
                  }}}}
        return{
        picker = {
          -- layout = {preset = "telescope"},
          sources = {
            -- incremental <c-g>???
            -- use <c-space> instead and <c-g> for ignore like fzf-lua? or maybe <c-s-g>?
            grep = {
              need_search = false,
              hidden = true,
            },
            projects = {
              recent = false,
              -- projects = { "" },
            },
            git_grep = {
              need_search = false,
            },
            lazy = {
              pattern=""

            },
            help = {
              confirm = function(picker, item)
                picker:close()
                if item then
                  vim.schedule(function()
                    vim.cmd("FloatingHelp " .. item.text)
                  end)
                end
              end,
            },
            commands = commands,
            command_history = commands,
                  explorer = {
                    -- why two times for layout?
                    -- maybe floating window?
                    layout={layout = { position = "right" }} ,
                    win = {
                      list = {
                        keys = {
                          ['h'] = 'explorer_up',
                          -- ['<c-h>'] = 'explorer_close',
                          -- w/ kanata chord
                          -- ['ZQ'] = 'explorer_close',
                        },
                      },
                    },
                  },
                },
                previewers = {
                  diff = {
                    builtin = false,
                    cmd = { "delta" },
                  },
                  git = {
                    builtin = true,
                  },
                },
                -- how to adapt size to max string length?
                ui_select = true,
                auto_close= false,
                formatters = {
                  file = {
                    filename_first = true, -- display filename before the file path
                },
                },

                -- disable builtin keybindings?
                win = {
                  preview = {
                    wo = {
                      signcolumn = "no",
                      statuscolumn = "%l ",
                    },
                    keys = {
                      ["<f12>o"] = "cycle_win",
                      ["<c-g>"] = { "close", mode = { "n", "i" } },
                    },
                  },
                  -- input window
                  input = {
                    keys = {

                      ["<f17>t"] = { "trouble_open", mode = { "n", "i" }, },
                      -- ["<f17>s"] = { "flash", mode = { "n", "i" } },
                      -- avy-goto-line (maybe better built-in functions/keymaps?)
                      ["<m-g><m-g>"] = { "flash", mode = { "n", "i" } },
                      ["<m-g>g"] = { "flash", mode = { "n", "i" } },
                      ["s"] = { "flash" },
                      -- like emacs
                      ["<c-g>"] = { "close", mode = { "n", "i" } },

                      -- ivy-restrict-to-matches
                      ["<s-space>"] = { "toggle_live", mode = { "i" } },

                      q = "",
                      ['l'] = { 'confirm', mode = { 'n' } },
                      ["<c-o>"] = { "loclist", mode = { "i", "n" } },
                      -- first disable all keybindings?
                      ["<c-s-o>"] = { "qflist", mode = { "i", "n" } },
                      ['<c-l>'] = { 'confirm', mode = { 'i' } },
                      ['<f16>o'] = { 'toggle_maximize', mode = { 'i', 'n' } },
                      -- I want glob though...
                      -- what are those fields? docs?
                      -- ['<f17>'] = { 'file:',expr=true, mode= { 'i', 'n' } },
                      -- TODO: don't add space if no input...
                      -- ['<f17>'] = { tostring(vim.fn.len(vim.fn.line('.'))),expr=true, mode= { 'i', 'n' } },
                      -- ['<f17>'] = { ' file:',expr=true, mode= { 'i', 'n' } },
                      -- make a hydra with alt for all these toggle and exit when alt is released?
                      -- toggle show path?
                      -- toggle ignorecase? M-s c
                      -- in attesa di toggle...
                      -- stessi mapping del picker
                      -- emacs
                      ["<f12>h"] = { "select_all", mode = { "i", "n" } },
                      ["<f13>r"] = { "toggle_regex", mode = { "i", "n" } },
                      ["<f13>i"] = { "toggle_ignored", mode = { "i", "n" } },
                      ["<f13>h"] = { "toggle_hidden", mode = { "i", "n" } },
                      ["<f13>f"] = { "toggle_follow", mode = { "i", "n" } },
                      ["<f13>p"] = { "toggle_preview", mode = { "i", "n" } },
                      -- also add action for picker-specific bindings
                      ['<f18>m'] = 'toggle_help',
                      -- ["."] = "toggle_focus",
                      -- c-s-g to append searches?
                      -- do <c-{v,s,t} work with multiple selections?
                      -- floating keymap? define standard as for explorer, debug, etc...

                      ['<f12>o'] = { 'cycle_win', mode = { 'i', --[['n']] } },
                      -- TODO: doesn't yank all selected lines?
                      ['<a-w>'] = { {'yank','close'}, mode = { 'i', --[['n']] } },
                      -- ╭─────────────────────────────────────────────────────────╮
                      -- │ preview                                                 │
                      -- ╰─────────────────────────────────────────────────────────╯
                      ['<c-m-v>'] = { 'preview_scroll_down', mode = { 'i', --[['n']] } },
                      ['<c-m-s-v>'] = { 'preview_scroll_up', mode = { 'i', --[['n']] } },
                      -- BUG: doesn't merge with default?
                      -- ['<m-h>'] = { 'preview_scroll_left', mode = { 'i', 'n' } },
                      -- ['<m-l>'] = { 'preview_scroll_right', mode = { 'i', 'n' } },


                      -- center like in emacs
                      ['<m-r>'] = { '<esc>/M2k/', expr = true, mode = 'i', remap=true },

                      ["<f17>H"] = "layout_left",
                      ["<f17>J"] = "layout_bottom",
                      ["<f17>K"] = "layout_top",
                      ["<f17>L"] = "layout_right",
                      -- ╭─────────────────────────────────────────────────────────╮
                      -- │ toggles                                                 │
                      -- ╰─────────────────────────────────────────────────────────╯
                      -- follow = "f",
                      -- hidden = "h",
                      -- ignored = "i",
                      -- modified = "m",
                      -- regex = { icon = "R", value = false },

                      -- ╭─────────────────────────────────────────────────────────╮
                      -- │ emacs/readline                                                │
                      -- ╰─────────────────────────────────────────────────────────╯
                      -- emacs uses m-{n,p} in the minibuffer btw
                      ["<C-p>"] = { "history_back", mode = { "i"  } },
                      ["<C-n>"] = { "history_forward", mode = { "i"  } },
                      ['<M-S-,>'] = { 'list_top', mode = { 'i' } },
                      ['<M-S-.>'] = { 'list_bottom', mode = { 'i' } },
                      -- ["<f17>"] ={ ".*",mode={"i"},expr=true},
                      -- word
                      ['<M-f>'] = { function() require('readline').forward_word() end, mode = 'i' },
                      ['<M-b>'] = { function() require('readline').backward_word() end, mode = 'i' },
                      ['<M-d>'] = { function() require('readline').kill_word() end, mode = 'i' },
                      ['<M-BS>'] = { function() require('readline').backward_kill_word() end, mode = 'i' },
                      ['<c-w>'] = { function() require('readline').unix_word_rubout() end, mode = 'i' },

                      -- split/tab (like emacs C-x{2,3}) (magari usa C-x?)
                      -- ["<c-3>"] = { "edit_vsplit", mode = { "i", "n" } },
                      -- ["<c-2>"] = { "edit_split", mode = { "i", "n" } },
                      -- check if emacs has already a keybinding
                      ["<f17>v"] = { "edit_vsplit", mode = { "i", "n" } },
                      -- ["<f17>s"] = { "edit_split", mode = { "i", "n" } },
                      ["<f17>x"] = { "edit_split", mode = { "i", "n" } },

                      ["<a-v>"] = { "list_scroll_up", mode = { "i" } },
                      ["<c-v>"] = { "list_scroll_down", mode = { "i" } },

                      -- line
                      -- ["<C-k>"] = require("readline").kill_line,
                      ['<C-a>'] = { function() require('readline').beginning_of_line() end, mode = 'i' },
                      ['<C-e>'] = { function() require('readline').end_of_line() end, mode = 'i' },
                      ['<C-u>'] = { function() require('readline').backward_kill_line() end, mode = 'i' },
                      -- char
                      ['<C-d>'] = { '<Delete>', expr = true, mode = 'i' },
                      ['<C-b>'] = { '<Left>', expr = true, mode = 'i' },
                      ['<C-f>'] = { '<Right>', expr = true, mode = 'i' },
                      -- mapping to hide/make transparent? to peek current buffer's content
                    },
                  },

                  list = {
                    -- use d to delete entries?
                    keys = {
                      ["<c-g>"] = { "close", mode = { "n", "i" } },
                      ['<f12>o'] = { 'cycle_win', mode = { 'i', 'n' } }, -- like ^w^w
                      ['l'] = { 'confirm', mode = { 'n' } },
                      -- todo: visual mode + :global command confirm? or mulitcursors
                    },
                  },

                },

                actions =
                --           table.concat(
                  -- require("trouble.sources.snacks").actions,
                  -- does emacs have flash like keymaps/plugin?
                  {
                    flash = function(picker)
                      require("flash").jump({
                        pattern = "^",
                        label = { after = { 0, 0 } },
                        search = {
                          mode = "search",
                          exclude = {
                            function(win)
                              return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "snacks_picker_list"
                            end,
                          },
                        },
                        action = function(match)
                          local idx = picker.list:row2idx(match.pos[1])
                          picker.list:_move(idx, true, true)
                        end,
                      })
                    end}
                    -- )
                  },
                }end,
              }
