--include frecency for pickers
--https://iwe.md/docs/nested-doucments/
--https://www.reddit.com/r/neovim/comments/1iffwwg/neovim_as_advanced_markdown_personal_knowledge/
-- crea mapping to send in current dir...
-- cream mapping p per non pastare newline se ce gia in file todo.txt
-- crea mapping che passi da Vim/Neovim/plugins a Vim/plugins (generico ovviamente)
-- TODO: make order of words irrelevant when searching: MediaWiki and WikiMedia should return the same dataset (make it work with all naming cases like snake_case, etc...)
local wikipath = vim.fn.expand'~/vimwiki/'
-- magari crea kanata layer with v...

local files = {
  data = 'y',
  todo = 'd',
  resources = 'r',
  basics = 'b',
  index = 'm',
}

-- TODO: create better mappings (ispirati a emacs)
-- magari usa v come prefisso/leader in kanata
local actions = {
  -- ['goto'] = 'v',
  go_to = 'v',
  -- TODO: trova mapping migliore
  -- send_clipboard = vim.g.tleader .. 'w',
  -- send_clipboard = 'vq',
  -- crea opearatore send_clipboard (è un'azione che usi molto)
  -- check if clipboard already sent (at least check first line...)
  -- send_text = '<space>V',
  send_clipboard = '<S-space>',
  search = 'vs',
  -- input = '<space>?',
}

-- TODO: fzf-opts per non fare vedere il filename
return {
  'vimwiki/vimwiki',
  -- event = 'BufEnter ' .. vim.fn.expand('~') .. '/vimwiki/**',
  event = 'BufRead ' .. vim.fn.expand('~') .. '/vimwiki/**',
  keys = function()
    -- make these priority frequency + recency (frecency) of selected files
    local mappings = {}
    table.insert(mappings, '<leader>w')
    -- table.insert(mappings, '<leader>V')
    table.insert(mappings, '<space><space>')
    table.insert(mappings, '<space>?')
    table.insert(mappings, '<leader>Qd')
    table.insert(mappings, '<leader>Qy')
    table.insert(mappings, 'vs')

    for _, mnemoaction in pairs(actions) do
      for _, mnemofile in pairs(files) do
        table.insert(mappings, mnemoaction .. mnemofile)
        table.insert(mappings, mnemoaction .. mnemoaction:sub(-1))
      end
    end

    return mappings
  end,

  init = function()
    vim.g.vimwiki_global_ext = 0
    -- vim.g.vimwiki_folding = 'expr:quick'
    vim.g.vimwiki_folding = 'custom'
    vim.g.vimwiki_list = {
      -- how to set filetype markdown?
      { path = '~/vimwiki/Personal/', syntax = 'markdown', ext = '.md', links_space_char = '-' },
      { path = '~/vimwiki/Work/', syntax = 'markdown', ext = '.md', links_space_char = '-' },
      { path = '~/vimwiki/Education/', syntax = 'markdown', ext = '.md', links_space_char = '-' },
    }
    vim.g.vimwiki_key_mappings = { --[[headers = 0,]] lists = 0 }
    -- vim.keymap.set('n', '<F13>', '<Plug>VimwikiNextLink')
    vim.keymap.set('n', '<F23>', '<Plug>VimwikiNextLink')
    vim.keymap.set('n', '<F14>', '<Plug>VimwikiPrevLink')
    -- vim.keymap.set('n', '<F15>',  '<Plug>VimwikiAddHeaderLevel')
    vim.keymap.set('n', '<F16>', '<Plug>VimwikiGoToParentHeader')

    --  ╭──────────────────────────────────────────────────────────╮
    --  │                    filetype mappings                     │
    --  ╰──────────────────────────────────────────────────────────╯

    -- maybe add option/mapping not to postprocess
    -- local function post(path) (più generico)
    local function post_todo(path)
      -- vim.cmd("e +$" .. vim.fn.fnameescape(destination) .. "/" .. vimwiki_files[mnem])
      -- vim.cmd("e +keepjump\\ $" .. vim.fn.fnameescape(destination) .. "/" .. vimwiki_files[mnem])
      if vim.fn.getfsize(path) > 0 then
        -- vim.cmd([[keepjump $ ]])
        vim.cmd([[keepjump $]])
        vim.cmd('set nofen')
        vim.cmd([[exe "norm 2o\<esc>"]])
        vim.cmd([[exe "norm zz"]])
      end
      -- non sono sicuro di questo, magari crea ulteriore mapping??? (magari version uppercase usa startinsert e sostituisci gH con 1gh???)
      -- vim.cmd([[startinsert]])
    end

    -- TODO: you can actually use .git and dirname(path) = vimwiki like vim-rooter vim.fs function (check if neovim api can help)
    local function check_inside_vimwiki(path)
      -- Dunno how to make this work with vim.fn
      -- if vim.fn["vimwiki#base#find_wiki(vim.fn.expand('%:p'))"]() ~= -1 then return true end
      if
        vim.api.nvim_call_function('vimwiki#base#find_wiki', { path }) ~= -1
      then
        return true
      end
      vim.notify("Can't go outside vimwiki!", vim.log.levels.ERROR)
      return false
    end

    local function jump(path)
      if path:match('/todo$') or path:match('/resources$') then path = path .. '.txt' else path = path .. '.md' end
      -- if path == vim.fn.expand('%:p') then return end
      if path == vim.fn.expand('%:p') then vim.cmd('$') return end
      if check_inside_vimwiki(path) then
        -- vai alla fine del file se si tratta di un todo
        vim.cmd('e ' .. path)
      end

      if path:find('/todo.txt$') then post_todo(path) end
    end

    -- Go to topic by word/visual selection under cursor
    -- vim.keymap.set({ 'x', 'n' }, 'g.', function()

    --   -- if vim.fn.mode == "n" then
    --   local topic = vim.fn.expand('<cword>')
    --   -- else
    --   --   local topic = sub("%s","_")
    --   -- end

    --     local index = '/index.md'
    --     -- Uso -td per velocizzare il comando
    --   local topics = vim.fn.systemlist('fd -i -td ' .. topic .. ' ~/vimwiki')

    --   if #topics == 0 then
    --       return
    --     elseif #topics == 1 then
    --     vim.cmd.e(table.concat(topics) .. index)
    --   else

    --     vim.ui.select(topics, { prompt = 'Select topic:' }, function(choice)
    --       if vim.fn.filereadable(table.concat(topics) .. index) then vim.cmd.e(table.concat(topics) ..index) end
    --     end)
    --   end
    -- end)

    -- vim.api.nvim_create_autocmd("FileType", { pattern = "vimwiki", group = vim.api.nvim_create_augroup("Vimwiki_Mappings", { clear = true }),
    -- TODO: add newline and center view?
    vim.api.nvim_create_autocmd('BufEnter', {
      pattern = vim.fn.expand('~') .. '/vimwiki/**/*.{md,txt}',
      group = vim.api.nvim_create_augroup('Vimwiki_Mappings', { clear = true }),
      callback = function(ev)
        for file, mnemonic in pairs(files) do
          -- go to non interactively ...
          vim.keymap.set('n', 'g' .. mnemonic, function() jump(vim.fn.fnameescape(vim.fn.expand('%:p:h')) .. '/' .. file) end, { buffer = ev.buf, desc = 'Go to ' .. file})
          vim.keymap.set('n', 'g' .. vim.fn.toupper(mnemonic), function() jump(vim.fn.expand('%:p:h' .. vim.fn['repeat'](':h', vim.api.nvim_get_vvar('count1'))) .. '/' .. file) end, { buffer = ev.buf, desc = 'Go to .../' .. file})
          -- altri mappings...
          -- "\ exe 'nnoremap <buffer><silent> go :<c-u>if filereadable(expand("%:s/_.*//:r")."_old".(v:count1).".md") <bar> e <c-r>=fnameescape(expand("%:s/_.*//:r"))."_old".(v:count1).".md"<cr> <bar> else <bar> echoerr "File doesn''t exists" <bar> endif<cr>' |
        end

        -- d sta per directory
        -- se lo fai su una word che contiene - questo si trasforma in spazio (FIX)
        -- fixa VimwikiFollowLink
        -- fallo fungere su <CWORD>...
        vim.keymap.set('n', 'd<cr>', [[<CMD>exe "VimwikiFollowLink"|s/.*\zs\ze)/\/index.md/e<cr>]], { buffer = ev.buf })
        -- xnoremap q<cr> :<c-u>exe "norm \<lt>cr>$i\<lt>bs>\<lt>bs>\<lt>bs>/index.md\<lt>esc>"<cr>

        -- (crea mapping) che fa il check se l'item è già stato scaricato
        -- # check url: repo (github), gist ... link (sito)
        -- highlight [... il sito]
        -- raggruppa queste cose in augroup...

        vim.keymap.set({ 'x', 'n' }, '<localleader>s', "<CMD>call setline('.', getline('.') .. ' [scarica il sito]')<cr>", { buffer = ev.buf, silent = true })
        vim.keymap.set({ 'x', 'n' }, '<localleader>S', "<CMD>call setline('.', getline('.') .. ' [già scaricato il sito]')<cr>", { buffer = ev.buf, silent = true })

        vim.keymap.set({ 'x', 'n' }, '<localleader>j', "o<esc>p", { buffer = ev.buf, silent = true })
        vim.keymap.set({ 'x', 'n' }, '<localleader>k', "O<esc>p", { buffer = ev.buf, silent = true })

        -- vim.keymap.set('n', '<leader>o', 'o<esc>o', { buffer = ev.buf, desc = 'Add newline below and start insert', nowait=true })
        -- maybe make these mappings global?
        vim.keymap.set('n', '<leader>o', function() if vim.fn.getline('.'):match('^$') then return '<esc>o' else return
          'o<esc>o'end end, { buffer = ev.buf, desc = 'Add newline below and start insert', nowait=true, expr = true })
        -- vim.keymap.set('n', '<leader>O', 'O<esc>O', { buffer = ev.buf, desc = 'Add newline above and start insert', nowait=true })
        vim.keymap.set('n', '<leader>O', function() if vim.fn.getline('.'):match('^$') then return '<esc>O' else return
          'O<esc>O'end end, { buffer = ev.buf, desc = 'Add newline above and start insert', nowait=true, expr = true })

        vim.keymap.set('n', '<leader>k', 'O<esc>Vp', { buffer = ev.buf, desc = 'Paste above', nowait=true })
        vim.keymap.set('n', '<leader>j', 'o<esc>Vp', { buffer = ev.buf, desc = 'Paste below', nowait=true })
        vim.keymap.set('n', '<leader>K', '2O<esc>Vp', { buffer = ev.buf, desc = 'Paste above', nowait=true })
        vim.keymap.set('n', '<leader>J', '2o<esc>Vp', { buffer = ev.buf, desc = 'Paste below', nowait=true })

        -- make these work with dot repeat (repeatable)
        -- maybe add mapping to paste with THIS prepended?
        -- > perchè THIS ->>>
        -- fix mapping THIS ->>> (piu comodo)
        -- magari usa <leader>1, <leader>2, etc...

        -- crea mapping per andare da xxx/songs a Songs (fallo per formats, etc...)
        -- u di uppercase
        vim.keymap.set('n', '<localleader>u', function()
          -- local dir = vim.fn.shellescape(vim.fn.substitute(vim.fn.expand('%:p:h:t'),[[^\l]],[[\u\0]],''))
          local dir =
          vim.fn.substitute(vim.fn.expand('%:p:h:t'), [[^\l]], [[\u\0]], '')
          local file = vim.fn.expand('%:p:t')
          -- vim.cmd('e',vim.system({'git','ls-files', ':/*/' .. dir .. '/' .. file}, { text = true }):wait().stdout)
          -- vim.cmd.e(vim.fn.systemlist({'git','ls-files', ':/*/' .. vim.fn.shellescape(dir .. '/' .. file)}))
          vim.cmd.e(
            vim.fn.systemlist({ 'git', 'ls-files', ':/*/' .. dir .. '/' .. file })
          )
          -- vim.cmd.e(vim.fn.systemlist({'git','ls-files', vim.fn.shellescape(':/*/' .. dir .. '/' .. file)}))
        end, { buffer = ev.buf })


       -- TODO: usa importance string come variable e preserva cursore...
        vim.keymap.set('n','<localleader>h',[[<CMD>call setline('.', substitute(getline('.'),repeat("THIS ->>> ",v:count1),'',''))<CR>]], {desc = "Remove importance", buffer = ev.buf})
        -- change to better mapping, maybe startin with v.
        vim.keymap.set('n', '<localleader>l', function()
          -- make these variable global
          local importance_string = 'THIS ->>> '
          local importance_value = vim.v.count1
          -- magari solo se la linea non è vuota?
          local space, notspace = vim.fn.getline('.'):match('^(%s*)(%S.*)')
          -- if !notspace return 0

          -- local _,count = string.gsub(vim.fn.substitute(notspace,string.format([[^\(%s\%%(%s\)*\).*$]],importance_string,importance_string),[[\1]],''),importance_string,"")

          local _, count = vim.fn
            .substitute(notspace, string.format([[^\(%s\%%(%s\)*\).*$]], importance_string, importance_string), [[\1]], '')
            :gsub(importance_string:gsub('([^%w])', '%%%1'), '')

          -- maybe convert to 5 if >=5
          -- fai anche controllo se ci saranno piü di 5 THIS ->>> se ci sono già (fai somma <=5)
          -- if vim.fn.assert_inrange(1, 5, importance_value) == 1 then vim.notify('You can only specify importance from 1 to 5', vim.log.levels.ERROR) return end
          -- if vim.fn.assert_inrange(0, 5-count, importance_value) == 1 then vim.notify('You can only specify importance from 1 to 5', vim.log.levels.ERROR) return end
          if vim.fn.assert_inrange(1, 5 - count, importance_value) == 1 then
            vim.notify(
              'You can only specify importance from 1 to 5',
              vim.log.levels.ERROR
            )
            return
          end

          -- vim.fn.setline(vim.fn.line('.'), string.rep(importance_string, importance_value) .. vim.fn.getline('.'))
          vim.fn.setline(
            vim.fn.line('.'),
            space .. string.rep(importance_string, importance_value) .. notspace
          )
        end, { desc = 'Add importance', buffer = ev.buf })
        -- check if clibpoard is multiline and if yes enclose in this ->>>↓
        -- v:count1 deve essere compresa tra 1 e 5 inclusi
        -- come fare il mapping in lua per curiosità?

        -- usa norm g> in visual mode if you don't want to group todo lines...
        -- autocmd BufEnter ~/vimwiki/**/*.md xnoremap <buffer> g> :<c-u>call <SID>Importance()<CR>

        -- come fare il mapping in lua (per curiosità)?
        vim.cmd([[
                    xnoremap <buffer> <localleader>l :<c-u>call Importance()<CR>
                    fun! Importance() abort
                    let l:count=v:count1
                    '<
                    " norm O=repeat("THIS ->>↓ ",s:count)<bs>
                    exe "norm O\<c-r>=repeat('THIS ->>↓ ',l:count)\<cr>\<bs>"
                    '>
                    " norm o=repeat("THIS ->>↑ ",s:count)<bs>
                    exe "norm o\<c-r>=repeat('THIS ->>↑ ',l:count)\<cr>\<bs>"
                    endfun
                    ]])
      end,
    })
  end,
  config = function()

    vim.treesitter.language.register('markdown', 'vimwiki')

    -- go_to = function(f)
      -- TODO: how to prioritize txt instead of md?
    local go_to = function(f)
      Snacks.picker.files({
        -- formatter = '',
        title = 'Go to '..f,
        cwd = wikipath,
        -- cmd = 'fd -tf --strip-cwd-prefix ^' .. f .. [[\(\\.md\|\\.txt\)$]],
        -- cmd = 'fd -tf --strip-cwd-prefix ^' .. f .. [[(\.md|\.txt)$]],
        cmd = 'fd',
        args = { "--type", "f", "--strip-cwd-prefix", '^' .. f .. [[(\.md|\.txt)$]], }
        -- file_icons = false,
      })
      -- vim.schedule(function() vim.cmd([[exe "norm Gzz"]])end)
    end

    local search = function(f)
      Snacks.picker.grep({
        title = 'Search in '..f,
        cwd = wikipath,
        -- cmd = [[rg -g ]] .. f .. '.md' .. ' -g ' .. f .. '.txt --',
        cmd = 'rg',
        args = {"-g", f .. '.md' , '-g' ,f .. '.txt'},
      })
    end

    local send_clipboard = function(--[[space, importanceopts]]f)
      local clipboard = vim.fn.getreg(vim.v.register, 1, true)
      if vim.tbl_isempty(clipboard) then
        vim.notify('Empty clipboard, aborting...', vim.log.levels.ERROR)
        return
      end
      -- local save_cursor = vim.fn.getcurpos()
      local importance = vim.v.count
      -- TODO: fixa, e metti importance_string global (local ma a inizio file)
      if vim.fn.assert_inrange(0, 5, importance) == 0 and importance ~= 0 then

        for k,v in ipairs(clipboard) do
          clipboard[k] = string.rep('THIS ->>> ', importance) .. v
        end
      end

      -- HACK: uso file_icons=false xke in selected compare l'icona
      -- in ogni caso visto che i file sono tutti markdown ha anche senso
      -- TODO: trova metodo migliore per distinguere resources.{txt,md}
     Snacks.picker.--[[git]]files ({
        -- Snacks.picker.files({
          -- formatter = '',
          cwd = wikipath,
          title = "Send clipboard to "..f,
        cmd = 'fd',
        args = { "--type", "f", '-E', 'resources.md',"--strip-cwd-prefix", '^' .. f .. [[(\.md|\.txt)$]], },
        -- file_icons = false,
        confirm = function(picker, item)
            picker:close()
            -- TODO: use for loop for multiple selected items
            local path = wikipath .. item.file
            -- does it abort if selected[1] == nil?
            -- if space == false or vim.tbl_isempty(vim.fn.readfile(path)) or (vim.fn.readfile(path, '', -1)[1]):match('^$') then
            --   vim.fn.writefile(clipboard, path, "a")
            -- else
            vim.fn.writefile(vim.list_extend({ '' }, clipboard), path, 'a')
            -- end
            -- TODO: don't use markdown for notifications (snacks.nvim?) or maybe just for the title...
            vim.notify(
              -- TODO: don't send first empty lines
              -- TODO: use highlighting?
              'Sent clipboard to ' .. vim.fn.fnamemodify(path,[[:~:s?\~/vimwiki/??]]) .. '\n' .. vim.trim(clipboard[1]),
              vim.log.levels.INFO
            )
          end,
       })

    end

    -- local input = function(f)
    --   -- Snacks.picker.files({ cwd = wikipath, cmd = 'fd --strip-cwd-prefix ^' .. f  .. [[\\.md$]], file_icons=false})
    --   vim.fn.setreg(vim.v.register,vim.fn.input('String to send' ))
    --   send_clipboard(f)
    -- end


    local send_outside = function(--[[space, importanceopts]]f)
      local clipboard = vim.fn.getreg("+", 1, true)
      if vim.tbl_isempty(clipboard) then
        vim.notify('Empty clipboard, aborting...', vim.log.levels.ERROR)
        return
      end
      -- local importance = vim.v.count
      -- if vim.fn.assert_inrange(0, 5, importance) == 0 and importance ~= 0 then
      --   for k,v in ipairs(clipboard) do
      --     clipboard[k] = string.rep('THIS ->>> ', importance) .. v
      --   end
      -- end
     Snacks.picker.--[[git]]files ({
          cwd = wikipath,
          layout = { fullscreen = true,preview=false },
          -- preview = function()return false end,
          title = "Send clipboard to "..f,
        cmd = 'fd',
        args = { "--type", "f", '-E', 'resources.md',"--strip-cwd-prefix", '^' .. f .. [[(\.md|\.txt)$]], },
        on_close = function() vim.schedule(function()
            -- vim.fn.system('dunstify "Sent clipboard to "' .. wikipath ..  '"\n"' .. vim.trim(clipboard[1]))
          vim.cmd'q'
        end) end,
        -- dunno why it's needed
        on_show = function() vim.cmd'startinsert' end,
        -- on_close = function() vim.defer_fn(function()vim.cmd'q' end,100) end,
        confirm = function(picker, item)
            local path = wikipath .. item.file
            vim.fn.writefile(vim.list_extend({ '' }, clipboard), path, 'a')
            vim.fn.system('notify-send "Sent clipboard to "' .. vim.fn.shellescape(vim.fn.fnamemodify(path,[[:~:s?\~/vimwiki/??]])) .. '"\n"' .. vim.fn.shellescape(clipboard[1]))
            picker:close()
          end,
          -- 
       })
       -- vim.api.nvim_exec2([[
       -- defer execute('q')
       -- ]],{})
    end

    function _G.__sendtextop(type)
      if type == 'char' then
        -- TODO: yanking not strictly necessary
        vim.cmd.normal({'`[v`]y', bang = true})
      elseif type == 'v' then
        vim.cmd.normal({'`<v`>y', bang = true})
      else return
      end
      -- vim.cmd([[call feedkeys('g@')]])
      -- return 'g@'
      -- alla fine mando la maggior parte a todo...
      -- vim.print("ciao")
      send_clipboard('todo')
    end

    -- local send_text = function(f)
    -- vim.cmd([[set operatorfunc=v:lua.__sendtextop]])
    -- vim.cmd([[call feedkeys('g@')]])
    -- vim.schedule(function() send_clipboard(f) end)
    -- -- send_clipboard(f)
    -- end


    -- FIX: usa loadstring?
    local processor = function(f, a)
      if a == 'go_to' then
        go_to(f)
      elseif a == 'search' then
        search(f)
      elseif a == 'input' then
        input(f)
      elseif a == 'send_clipboard' then
        -- send_clipboard(--[[ space,importance,opts, ]]f)
        send_clipboard(f)
      -- elseif a == 'send_text' then
      --   send_text(f)
        -- vim.schedule(function() send_clipboard(f) end)
        -- send_clipboard(f)
      end
    end

      -- for file, mnemofile in pairs(files) do
        -- vim.keymap.set('<leader>V'..mnemofile,'<CMD>set operatorfunc=v:lua.__sendtextop<CR>g@')
      -- end
      -- TODO: use getregion(getpos("'<"),getpos("'>"))
    -- vim.keymap.set('n','<leader>V','<CMD>set operatorfunc=v:lua.__sendtextop<CR>g@')

    for action, mnemoaction in pairs(actions) do
      for file, mnemofile in pairs(files) do
        -- vim.keymap.set('n', mnemoaction .. mnemofile, function() processor(file, action) end, { desc = actions[mnemoaction] .. ' ' .. files[mnemofile]:sub(1, 4) })
        vim.keymap.set('n', mnemoaction .. mnemofile, function() processor(file, action) end)
        -- vim.keymap.set('n', mnemoaction .. mnemofile, function() action(file) end)
        -- vim.keymap.set('n', mnemoaction .. mnemofile, function() assert(loadstring(action.."("..file..")"))() end)
        -- vim.keymap.set('n', mnemoaction .. mnemofile, function() loadstring("go_to(todo)") end)
        -- vim.keymap.set('n', mnemoaction .. mnemofile, function() loadstring("action(file)") end)

        -- print('n'.. mnemoaction .. mnemofile.. action..file)
      end
    end

    vim.keymap.set('n', '<space><space>', function() send_clipboard('todo') end, { desc = "Go to Wiki file" })
    vim.keymap.set('n', '<leader>Qd', function() send_outside('todo') end, { desc = "Go to Wiki file" })
    vim.keymap.set('n', '<leader>Qy', function() send_outside('data') end, { desc = "Go to Wiki file" })
    vim.keymap.set('n', '<leader>?', function()vim.fn.setreg(vim.v.register,vim.fn.input('String to send' )) send_clipboard('todo') end, { desc = "Go to Wiki file" })
    vim.keymap.set('n', 'vv', function() Snacks.picker.files { cwd = "~/vimwiki"} end, { desc = "Go to Wiki file" })
    -- vim.keymap.set('n', ',ww', function() send_clipboard(true, vim.v.count, static_telescope_options_global) end)
    -- vim.keymap.set('n', ',wW', function() send_clipboard(false, vim.v.count, static_telescope_options_global) end)

    -- maybe pass -F (exact flag) for urls?
    -- how to toggle -F?
    -- vim.keymap.set('n', 'vss', function() require("telescope.builtin").live_grep { cwd = "~/vimwiki", additional_args = { '-F' } } end, { desc = "Search in Wiki" })
    -- Snacks native(max perf?)
    vim.keymap.set('n', 'vss', function() Snacks.picker.grep{ cwd = "~/vimwiki"} end, { desc = "Search in Wiki" })
    vim.keymap.set({'n'--[[,'x']]}, 'vsw', function() Snacks.picker.grep_word { cwd = "~/vimwiki", regex = false } end, { desc = "Search word in Wiki" })
    -- only_sort_text
    vim.keymap.set('n', 'vsu', function() Snacks.picker.grep { cwd = "~/vimwiki", search = vim.fn.getline('.'):match( 'http%S+'),regex = false } end, { desc = "Search URL in Wiki" })
    -- maybe go directly to first match or send them all to quickfix bypassing telescope buffer? is it possible?
    -- what about visual selection?
    -- usa vim.v.register?
    -- TODO: notify if no string in vimwiki (without opening fzf)
    -- TODO: fixa?
    -- BUG: when searching '-S, --show-error' no search is done (what if clipboard contains $(rm tilde))
    -- should you escape???
    -- vim.keymap.set('n', 'vsc', function()Snacks.picker.grep {cwd = "~/vimwiki", search = vim.fn.trim(vim.fn.getreg('"')), args = {'-F'}} end, { desc = "Search clipboard in Wiki" })
    vim.keymap.set('n', 'vsc', function()Snacks.picker.grep {cwd = "~/vimwiki", search = vim.fn.trim(vim.fn.getreg('"')), regex = false} end, { desc = "Search clipboard in Wiki" })
    -- vim.keymap.set('n', 'vsy', function() require("telescope.builtin").live_grep { cwd = "~/vimwiki", default_text = '^# .*', glob_pattern = { 'data*.md' } } end, { desc = "Search in Data" })
    vim.keymap.set('n', 'vsh', function() Snacks.picker.grep { cwd = "~/vimwiki", search = '^# .*', glob = { 'data*.md' } } end, { desc = "Search Headers in Data" })
    -- TODO: cerca solo in file todo? bad idea
    vim.keymap.set('n', 'vst', function() Snacks.picker.grep { cwd = "~/vimwiki", search = string.rep("THIS ->>> ", vim.v.count1)} end, { desc = "Search TODO in Wiki" })
    -- TODO: doesn't work
    -- vim.keymap.set('n', 'vst', function() require("fzf-lua").grep { cwd = "~/vimwiki", search = "THIS ->>> " .. "{"..vim.v.count1.."}"} end, { desc = "Search clipboard in Wiki" })
  end,
}
