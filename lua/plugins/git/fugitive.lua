-- https://github.com/hotwatermorning/auto-git-diff (fugitive extensions?)
-- cabbrev git  <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Git'  : 'git')<CR>
-- cabbrev gitv <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Gitv' : 'gitv')<CR>
-- cabbrev gist <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Gist' : 'gist')<CR>
--
-- cabbrev gb <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Gbrowse' : 'gb')<CR>
-- cabbrev gc <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Gcommit' : 'gc')<CR>
-- cabbrev gd <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Gdiff'   : 'gd')<CR>
-- cabbrev ge <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Gedit'   : 'ge')<CR>
-- cabbrev gl <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Glog'    : 'gl')<CR>
-- cabbrev gs <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Gstatus' : 'gs')<CR>

return
  {
    -- how to commit single file in git status buffer? c<space><cfile> or c<space><c-r>a/f work (as long as the filename doesn't contain spaces)
    -- add filetype mapping with autocmd I guess, cf: "Git commit ". shellescape(getline(".")->substitute('^\S\+ ',"",""))

    -- would be nice to stage all files with S
    "tpope/vim-fugitive",
    lazy = false,
    init = function()
---@diagnostic disable-next-line: inject-field
      vim.g.fugitive_legacy_commands = 0
      -- FIX: code duplication
      vim.opt.fillchars:append { diff = "╱" }
    end,
    -- not sure about lazy loading vim-fugitive

    cmd = {
      -- how to show tab completion for Git commands?
      "G", "Git",
    },
    keys = function()
      -- create a function that toggle the fugitive  window.
      -- it should open it vertically if it's not open
      local function toggle_fugitive_window()
        -- check if there is a buffer with filetype fugitive
        local fugitive_buffer = vim.fn.bufnr("fugitive://")
        -- if there is no buffer with filetype fugitive, or if the buffer is not visible then open it vertically
        if fugitive_buffer == -1 or vim.fn.bufwinnr(fugitive_buffer) == -1 then
          vim.cmd("vertical G")
          -- if there is a buffer with filetype fugitive, close it
        else
          vim.cmd("bd" .. fugitive_buffer)
        end
      end

      -- TODO: find diff between Git! and Git --paginate...
      -- wait for blink completion extension to support typos
      local mappings = {
          -- Remove="",
          -- Delete="",
          -- Move="",
          -- Rename="",
          -- Browse="x",

          -- fai in modo che edit/read/etc... usino directory del current buffer come cwd, se vuoi usare file di progetto usa Gedit
          _edit = "e",
          _read = "r",
        --  nnoremap <Leader>gA :Git add -A<CR>
        --  Git add .???
        --  use gw to search for word under cursor?
        -- Note: Useful with `:argdo`, `:cdo`, and so on.
        -- prefisso f: così posso usare lettere maiuscole senza dovermi preoccupare se sono dovute a aggiunta di argument o per aggiunta di --force.
          _write = "w",
          _wq = "q",
          -- Does fugitive git grep work with vim regex syntax?
          -- _grep = [[\]],
          -- _lgrep = [[/]],


      -- Consider using :Git log --oneline instead.
      -- TODO: add visual mode mappings for log and blame and write?? help fugitive [range]... (maybe add key range = true?)
          -- _clog = "l",
          -- _llog = "l",

          -- diff = "d",
          blame = "a",

          -- :DiffGitCached <args>
          commit= "c",
          merge="m",
          -- pull = "y", --yank
          -- stash = 's',
          -- would be cool if difftool's quickfix list would remove entries that get committed...

          -- use universal argument for <space> populate?
       -- (nmap! :<Space>gr<Space> [:desc "[git] populate cmdline with `:Git rebase `"] ":<C-u>Git rebase ")
          -- rebase="r",

        -- { "<leader>gR", "<CMD>Git revert<CR>" },
        -- { "<leader>gv", "<CMD>Git revert<CR>" },

          -- revert="v",
          -- TODO: crea toy repo to practice
          push="p", --paste
          -- fetch="f",
      }

      local git_mappings = {}

      -- usa <localleader>? in effetti come gitsigns sono mapping locali al buffer git-tracked (non mi piace come idea xke <localleader> lo vorrei usare solo x filetype mappings)
      for subcommand, mapping in pairs(mappings) do
        -- TODO: vim.fn.exists()? also extract command in variable...
        if string.match(subcommand, '^%u') or vim.startswith(subcommand,'_') then
          subcommand = vim.fn.substitute(subcommand,'^_','','')
          -- How to fix? also how to use with subcommands (they have spaces...)
          -- require'noice'.setup({cmdline={format={[subcommand]={pattern = '^:%s*G' .. subcommand .. '%s*'}}}})
          table.insert(git_mappings, {
            { '<leader>g' .. mapping, '<CMD>G' .. subcommand .. "<CR>", desc = subcommand, buffer = true },
            { '<leader>g' .. string.upper(mapping), ':G' .. subcommand .. '<space>', desc = subcommand .. ' [args]', buffer = true },
          })
        else

          -- require'noice'.setup({cmdline={format={[subcommand]={pattern = '^:%s*Git ' .. subcommand .. '%s*'}}}})
          -- TODO: code duplication (<leader>g)-> maybe use prefix variable?
          table.insert(git_mappings, {
            { '<leader>g' .. mapping, '<CMD>Git ' .. subcommand .. "<CR>", desc = subcommand, buffer = true },
            { '<leader>g' .. string.upper(mapping), ':Git ' .. subcommand .. '<space>', desc = subcommand .. ' [args]', buffer = true },

            -- uso \ visto che il mapping per togglare (! è come un toggle)
            -- { [[\g]] .. mapping, '<CMD>Git! ' .. subcommand .. "<CR>", desc = subcommand, buffer = true },
            -- { [[\g]] .. string.upper(mapping), ':Git! ' .. subcommand .. '<space>', desc = subcommand .. ' [args]', buffer = true },

            -- TODO: not too sure about those...
            -- {"<localleader>g" .. mapping, "<CMD>Git --paginate " .. subcommand .. "<CR>", desc = subcommand, buffer = true},
            -- {"<localleader>g" .. string.upper(mapping), ":Git --paginate " .. subcommand .. "<space>", desc = subcommand .. " [args]", buffer = true},
          })
        end
      end

        -- add v:count?
          table.insert(git_mappings, {
            -- how to go to the last diff that modify the line?
            { '<leader>gd', '<CMD>Gvdiffsplit<CR>', desc = "Diffsplit", buffer = true },
            { '<space>u<leader>gd', ':Gvdiffsplit<space>', desc = "Diffsplit [args]", buffer = true },
            { '<f12>g', '<cmd>tab G<cr>', desc = "Git status", buffer = true },
            -- { [[\gd]], '<CMD>Git diff<CR>', desc = "Diff", buffer = true },
            -- { [[\gD]], ':Git diff<space>', desc = "Diff [args]", buffer = true },
            { mode="x",[[<leader>ga]], ':Git blame<cr>', desc = "Diff [args]", buffer = true },
            { mode="x",[[<leader>gA]], ':Git blame<space>', desc = "Diff [args]", buffer = true },
          })

      return vim.iter(vim.iter(git_mappings):flatten()):totable()

      -- return {
      --   -- TODO: search github for better description for these mappings
      --
      --   -- prendi spunto da vari alias che trovi online o da espanso per esempio (https://hub.espanso.org/git)
      --   -- non uso <silent> nelle mapping per impararle prima/ricordarle meglio
      --
      --   -- find where you find these mnemonics (for hydra maybe?)
      --   -- 'y' (yank) = git pull
      --   -- 's' (shove) = git push
      --   -- 'g' (give) = git commit -am x
      --   -- 'o' (open) = git checkout x
      --   -- 'p' (pick up) = git branch x
      --   -- 'l' (look at) = git status
      --
      --   -- nnoremap([[<Space>gg]], [[:Git<Space>]])
      --   -- nnoremap([[<Space>gG]], [[:Git --paginate<Space>]])
      --   -- :{range}Git! -p {args}  Run an arbitrary git command, and insert the output after {range} in the current buffer.
      --
      --   --  Come query puoi usare ^M per ottenere solo i file modificati
      --   --  nnoremap <leader>g? :GFiles?<cr>
      --   -- { '<leader>gs',     ':G<cr>',                  desc = "git status" },
      --   { "<leader>gs", toggle_fugitive_window, desc = "Status window" },
      --   -- Meaning of 0 here?
      --   { "<leader>gS", '<CMD>0Git<cr>', desc = "Status window" },
      --
      --
      --   -- ╭─────────────────────────────────────────────────────────╮
      --   -- │ diff                                                    │
      --   -- ╰─────────────────────────────────────────────────────────╯
      --   -- D = { "<cmd>silent Gvdiffsplit HEAD~<CR>", "Diff with previous commit" },
      --   -- documentation for this?
      --   -- fugitive: change ~ to !~ to diff against ancestor
      --   --  would be nice if you could do 2<leader>gd to execute :Gdiff HEAD~2 (generalize with n e use this for the other git commands in which it makes sense)
      --   --  nnoremap <leader>gd :<c-u>exe "Gdiff HEAD~" . v:count1<CR>
      --   -- would be cool if you could edit the git buffer 
      --   -- add PR to use v:count
      --   -- modo per ricordarsi dove appare old buffer: sta a sx (si scrive da sx (old) a dx (new))
      --   { "<leader>gd", "<CMD>Gdiffsplit<CR>", desc = "Diff" },
      --   -- would be cool if it showed the commit message when diffing against a commit hash
      --   { "<Leader>gD", ":Gdiffsplit<Space>", desc = "Diff [args]" },
      --   --  nnoremap <Leader>gQ :Git difftool --name-only<cr>
      --   { "<Leader>gtd", "<CMD>Git difftool<cr>", desc = "Difftool" },
      --   { "<Leader>gtD", ":Git difftool<space>" ,desc = "Diff [args]"},
      --   -- { "<leader>gv", "<CMD>Gvdiffsplit!<cr>", desc = "Vertical diff split of the current file" },
      --   -- { "<leader>gV", ":Gvdiffsplit<space>" },
      --
      --   -- ╭─────────────────────────────────────────────────────────╮
      --   -- │ Stash                                                   │
      --   -- ╰─────────────────────────────────────────────────────────╯
      --   -- { "<leader>g-", "<CMD>Git stash<CR><CMD>e<CR>", desc="Stash" },
      --   -- what about gz? like fugitive's doc mapping
      --   { "<leader>g-", "<CMD>Git stash<CR>", desc="Stash" },
      --   -- { "<leader>g-", "<CMD>Git stash push<CR>", desc="Stash" },
      --   { "<leader>g+", "<CMD>Git stash pop<CR>", desc="Stash pop" },
      --
      --
      --   -- like X mapping in status window
      --   -- { "<leader>gX", ":Git reset<space>" },
      --   -- (vim.cmd.Git "reset HEAD~"))))
      --   -- (nmap! [:desc "[git] unstage current file"] :<Space>gu
      --   --        (<Cmd> "silent Git reset HEAD %"))
      --   -- (nmap! [:desc "[git] unstage all files"] :<Space>gU
      --   --        (<Cmd> "silent Git reset HEAD"))
      --
      --   -- Use :Git! push to use Fugitive's own asynchronous execution, or retroactively make :Git push asynchronous by pressing CTRL-D.
      --   --  p e P secondo i mapping gp e gP di fugititive
      --
      --   -- magari usa <leader>gr for git remote or smth and use f,p,P (or j for pull and k for push (think of the motions))
      --   -- git tag, git fetch?
      --   -- { "<leader>gf", ":Git fetch<space>" },
      --   { "<leader>gf", "<CMD>Git fetch --all<CR>" },
      --   { "<leader>gF", "<CMD>Git fetch --unshallow<CR>" },
      --
      --   -- p and P for pull and push (first you push then pull [first lowercase, then lowercase]) inoltre analogia con vim: p pastes below (pull), P pastes above (push)
      --   -- maybe use p for paste here? and gP for [args]
      --   { "<leader>gp", "<CMD>Git! push -u<CR>", desc = "Push" },
      --   { "<leader>gP", ":Git push<space>", desc = "Push" },
      --   -- :Git pull –rebase origin
      --   -- :Git pull –ff-only origin
      --   -- maybe use gy here? for yank? and gY for [args]
      --   { "<leader>gy", "<CMD>Git pull<CR>", desc = "Pull" },
      --   { "<leader>gY", ":Git pull<space>", desc = "Pull [args]" },
      --   --  nnoremap <leader>gps :Dispatch! git push<CR>
      --   --  nnoremap <leader>gpl :Dispatch! git pull<CR>
      --
      --   --  a -> author
      --   -- https://github.com/search?q=map+%3AGit+blame%3Ccr%3E&type=code
      --   --  https://github.com/search?p=9&q=map+%3AGit+blame%3Ccr%3E&type=Code
      --   --  https://github.com/tommcdo/vim-fugitive-blame-ext
      --   -- would be cool to use just one mapping for this...
      --   { mode = { "n" }, "<leader>ga", "<CMD>Git blame<cr>", desc = "Git blame [allows moving around the jump list]" },
      --   { mode = { "x" }, "<leader>ga", "<ESC><CMD>Git blame<cr>", desc = " Git blame [allows moving around the jump list]"},
      --   { "<leader>gA", ":Git blame<space>", desc="Git blame [args]" },
      --
      --   -- ╭─────────────────────────────────────────────────────────╮
      --   -- │ Merge                                                   │
      --   -- ╰─────────────────────────────────────────────────────────╯
      --
      --   -- [n                      Go to the previous SCM conflict marker or diff/patch hunk.  Try d[n inside a conflict.
      --   -- ]n                      Go to the next SCM conflict marker or diff/patch hunk. Try d]n inside a conflict.
      --   -- X                         During a merge conflict, use 2X to call `checkout --ours` or 3X to call `checkout --theirs` .
      --   -- During a merge conflict, this is a three-way diff against the "ours" and theirs" ancestors.  Additional d2o and d3o maps are provided to obtain the hunk from the "ours" or theirs" ancestor, respectively.
      --   { "<leader>g2", "<cmd>diffget //2<Space>", desc = "Fetch hunk from target parent (on the left)" },
      --   { "<leader>g3", "<cmd>diffget //3<Space>", desc = "Fetch hunk from merge parent (on the right)" },
      --   -- { "<leader>gm", "<CMD>Git merge<CR>" },
      --   { "<leader>gm", "<CMD>Gdiffsplit!<CR>" },
      --   -- write git merge --continue after Gwrite after resolving conflict
      --   { "<Leader>gM", ":Git merge<space>" },
      --   { "<leader>gtm", "<CMD>Git mergetool<CR>" },
      --   { "<Leader>gtM", "<CMD>Git mergetool -y<cr>" },
      --
      -- }
    end,
    -- should I use init or config here?
    config = function()
          -- TODO: adds DOTS command (~/vimwiki/Personal/CS/OS/Linux/commands/Vim/Neovim/config/resources/git_repos/ibhagwan/nvim-lua/lua/plugins/fugitive.lua)

          -- vim.api.nvim_create_autocmd({'User'},{
          --   group = vim.api.nvim_create_augroup('FugitiveAutocmds', {clear= true}),
          --   pattern = 'FugitivePager',
          --   -- command = 'echo "git " .. FugitiveResult().args->join(" ")',
          --   -- command = 'call nvim_notify("git " .. FugitiveResult().args->join(" "),luaeval("vim.log").levels.INFO,{})',
          --   callback = function()
          --     -- vim.notify("git " .. vim.iter(vim.schedule(function() vim.api.nvim_call_function('FugitiveResult',{}).args end)):join(" ")))
          --     -- vim.notify("git " .. vim.iter(vim.schedule(function() vim.api.nvim_call_function('FugitiveResult',{}) end)):join(" "))
          --     -- vim.notify(vim.schedule(function() vim.api.nvim_call_function('FugitiveResult',{}) end))
          --     -- vim.notify("git " .. vim.fn.join(vim.schedule(function() vim.api.nvim_call_function('FugitiveResult',{}).args)," "))
          --     --   local fugitive_result = {}
          --     -- vim.schedule(function() fugitive_result = vim.api.nvim_call_function('FugitiveResult',{}) end)
          --     -- vim.print(fugitive_result)
          --     -- vim.notify("git" .. vim.fn.join(fugitive_result.args," "))
          --
          --   end
          --  })
    end
  }
--
--   -- command! -buffer GitBranchRename call <SID>GitBranchRename(expand('<cword>'), input("Enter new branch name: ", expand('<cword>'))) | call <SID>GitGraphView()
--
--   -- gitlinker
--   -- wk.register({ y = "Copy Link" }, { mode = "n", prefix = "<leader>g" })
--   -- wk.register({ g = { name = " Git", y = "Copy Link" } }, { mode = "v", prefix = "<leader>" })
--
--   -- B = {
--   --     function()
--   --         vim.ui.input({ prompt = "Branch Name: " }, function(input)
--   --             vim.cmd("!git checkout -b " .. input)
--   --         end)
--   --     end,
--   --     "Switch Branch",
--   -- },
--
--   --\gH   open line in Github
--   -- \gB  blame line in Github


-- return
--   {
--     -- magari lowercase neogit & relative uppercase->fugitive?
--     "tpope/vim-fugitive",
--     cmd = {
--       -- how to show tab completion for Git commands?
--       "G", "Git",
--     },
--     keys = {
--
--       -- {"<leader>gr","<CMD>GRemove<CR>", desc = "Remove"},
--       -- {"<leader>gr","<CMD>GDelete<CR>", desc = "Delete"},
--       -- {"<leader>gr","<CMD>GMove<CR>", desc = "Move"},
--       -- Convenzione: ... -> args
--       {"<leader>gn",":GRename<space>", desc = "Rename ..."}, -- make it support LSP
--       -- uppercase->progetto
--       {"<leader>gN",":GMove<space>", desc = "Move ..."}, -- make it support LSP
--       {"<leader>ge","<CMD>Gedit<CR>", desc = "Edit"},
--       {"<leader>gE",":Gedit<space>", desc = "Edit ..."},
--
--       {"<leader>g?","<CMD>Git blame<CR>", desc = "Blame"},
--       -- {"<leader>gA","<CMD>Git blame<CR>", desc = "Blame ..."},
--     }
--   }
  -- magari crea global mappings with prefix <leader>gg and local mappings with prefix <leader>g (for global and file mappings, like for committing)
