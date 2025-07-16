-- https://github.com/vim-scripts/dbext.vim
-- dbext ties into Vim dictionary feature. You can complete table names, procedure names and view names using the i_CTRL-X_CTRL-K feature. https://github.com/vim-scripts/dbext.vim
-- would be nice if it completed .schema and such (and also exclude those errors from lsp? use sqlite as &ft?)
-- would be nice being able to use \d table in psql (like .tables works in sqlite)
-- use more specific filetype? like postgresql, etc... (also to make it work with formatters)
return {
  {
    -- would be nice to use sessions here
    -- would be nice to show notification with nvim-notify (actually just split)
    -- but here completion setup (blink) (filetype-access only)
    -- add icons (postgres, jq, etc... or tags???)
    -- refresh view after drop table for ex?
    -- how to not make it open whole window when opening db but just split
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      {
        'tpope/vim-dadbod',
        -- pin = true,
        cmd = { 'DB' },
        dependencies = 'tpope/vim-dispatch' -- for interactive session... really shouldn't need this
      },
      {
        'napisani/nvim-dadbod-bg',
        cond = false,
        lazy = true,
        build = './install.sh',
        -- (optional) the default port is 4546
        -- (optional) the log file will be created in the system's temp directory 
        config = function()
          vim.cmd([[
          let g:nvim_dadbod_bg_port = '4546'
          let g:nvim_dadbod_bg_log_file = '/tmp/nvim-dadbod-bg.log'
          ]])
        end
      },
      {

        -- Also knows to read aliases (select * from mytable tbl where tbl.id = 1)
        -- If you want, you can also add b:db_table to limit autocompletions to that table only.
        'kristijanhusak/vim-dadbod-completion',
        ft = { 'sql', 'mysql', 'plsql' },
        lazy = true,
        -- ft = vim.fn.getcompletion('sql', 'filetype'),
        -- FIXA
        cmd = 'DBCompletionClearCache',
        -- dependencies = { 'hrsh7th/nvim-cmp' },
        -- how use regex like /sql$/
        -- echo getcompletion('','filetype')->filter('v:val=~"sql"')
        -- ft = { 'sql', 'mysql', 'plsql' },
        -- TODO: https://github.com/kristijanhusak/vim-dadbod-completion/issues/75#issuecomment-2408694229 finche non c'e blink.buffer usa autocmd...
      },

        -- unkown other sources??? se uso init funge though
        -- init = function()
  },

    cmd = {
      'DBUI',
      'DBUIToggle',
    },
    init = function()
      vim.g.db_ui_disable_info_notifications= 1
      vim.g.db_ui_save_location = vim.fn.stdpath('data') .. '/db_ui'
      -- vim.keymap.set('n', '<leader>ec', [[<CMD>tab drop ]] .. vim.g.db_ui_save_location .. [[/connections.json<cr>]], { desc = 'Database connections' })
      vim.g.Db_ui_table_name_sorter = function(tables) return vim.fn.sort(tables)  end

      vim.g.db_ui_tmp_query_location = vim.fn.stdpath('data')
        .. '/db_ui/queries'
      -- with this you can use <space><space>
      vim.g.db_ui_execute_on_save = true

      vim.g.db_ui_auto_execute_table_helpers = 1
      vim.g.db_ui_use_nerd_fonts = 1
      -- weird using l here
      -- vim.g.db_ui_win_position = 'right'
      -- not sure what this does
      -- vim.g.db_ui_show_database_icon = 1
      vim.g.db_ui_use_nvim_notify = 1

    end,
    -- { "dc", "<CMD>tab DBUI<CR>", desc = "Open drawer with available connections" },
    -- { "do", "<cmd>DBUIToggle<cr>",        desc = "Toggle UI" },
    -- { "df", "<cmd>DBUIFindBuffer<cr>",    desc = "Find Buffer" },
    -- { "dr", "<cmd>DBUIRenameBuffer<cr>",  desc = "Rename Buffer" },
    -- { "dq", "<cmd>DBUILastQueryInfo<cr>", desc = "Last Query Info" },

    keys = {
      -- q di query (https://github.com/pratiktri/dotfiles/blob/6085a0cffc5f21974f17bd1bd1f165ca327805cf/common/.config/nvim/lua/plugins/code-db.lua#L39)
      -- { '<leader>mD', '<cmd>tabnew|DBUIToggle<cr>', desc = 'Toggle DBUI' },
      -- { '<space>D', '<cmd>tabnew|DBUIToggle<cr>', desc = 'Toggle DBUI' },
      -- use s/l (f12) for emacs-inspired mappings and use c/m (f15) for one shot mappings (no groups)
      { '<c-c>D', '<cmd>tabnew|DBUIToggle<cr>', desc = 'Toggle DBUI' },
      -- { '<localleader>qu', '<cmd>tabnew|DBUIToggle<cr>', desc = 'Toggle UI' }, -- https://github.com/Melting-Face/mynvim/blob/907d469f1abfa812aea2a5dd3d8efd8bcaba66c7/lua/plugins.lua#L313
      -- TODO: better aesthetically
      -- {
      --   '<leader>uD',
      --   ':DBUIToggle<left><left><left><left><left><left><left><left><left><left><space><left>',
      --   desc = 'Toggle UI interactively',
      -- },
      -- TODO: use vim.ui.select
      { '<localleader>f', '<cmd>DBUIFindBuffer<cr>', buffer = true, ft = 'sql',desc = 'Find Buffer' },
    },
    config = function()
      -- vim.keymap.set('n','<C-Q>', vim.fn["db#op_exec"]())
      -- usa stesso mapping di sniprun (se necessario disable sql filetype in sniprun) {lazy api to get sniprun's keys?}
      vim.api.nvim_create_autocmd('Filetype', {
        -- pattern = "sql",
        -- how to put filetypes supported by a plugin/dadbod?
        pattern = { 'sql', 'mysql', 'plsql', 'jq' },
        callback = function(ev)
          -- TODO: find better mapping
          vim.api.nvim_buf_set_keymap(ev.buf, 'n', 'gs', vim.fn['db#op_exec'](), { noremap = true, desc = 'Run SQL' })
          vim.api.nvim_buf_set_keymap(ev.buf, 'x', 'gs', vim.fn['db#op_exec'](), { noremap = true, desc = 'Run SQL' })
          -- It's superior to mapping to :DB directly because it uses the exact selection rather than just line numbers (https://github.com/tpope/vim-dadbod/issues/33)
          -- how to make these dot-repeatable?
          vim.api.nvim_buf_set_keymap(ev.buf, 'n', 'gS', vim.fn['db#op_exec']() .. '$', { noremap = true, desc = 'Run SQL (EOL)' })
          vim.api.nvim_buf_set_keymap(ev.buf, 'n', 'gss', vim.fn['db#op_exec']() .. '_', { noremap = true, desc = 'Run SQL (linewise)' })

          -- vim.api.nvim_buf_set_keymap(ev.buf, 'n', 'K', '<CMD>DB SELECT*FROM ' .. vim.fn.expand('<CWORD>') .. ' LIMIT 20', { noremap = true, desc = 'Show table from cursor' })
          -- it would be better to just hover? first: scheme, second: first 3 rows or smth
          vim.keymap.set('n', 'K', function() return vim.list_contains(vim.treesitter.get_captures_at_cursor(),'keyword') and
            '<CMD>Man ' .. vim.fn.expand('<cWORD>') .. '<CR>' or
            -- TODO: use floating window? how to store DB output? execute doesn't work sadly
            '<CMD>DB SELECT*FROM ' .. vim.fn.substitute(vim.fn.expand('<cWORD>'),[[\W]],'','g') .. ' LIMIT 20<CR>' end, { expr = true,  buffer = ev.buf, desc = 'Show docs or table from cursor' })

            vim.keymap.set('n', '<localleader>a', '<cmd>DBUIAddConnection<cr>',{ buffer = ev.buf, desc = 'Add Connection' })
            -- magari alcune di queste 2 in setup e non in keys?
            vim.keymap.set('n', '<localleader>r', '<cmd>DBUIRenameBuffer<cr>',{ buffer = ev.buf, desc = 'Rename Buffer' })
            vim.keymap.set('n', '<localleader>q', '<cmd>DBUILastQueryInfo<cr>',{ buffer = ev.buf, desc = 'Last Query Info' })

        end,
        -- group = vim.api.nvim_create_augroup("DBExe", {})
        group = vim.api.nvim_create_augroup('DBUISetup', {}),
      })
      vim.api.nvim_create_autocmd('Filetype', {
        pattern = 'dbui',
        group = vim.api.nvim_create_augroup('DisableQuitMapping', {}),
        callback = function()
          -- vim.keymap.set('n', 'o', '<Plug>(DBUI_SelectLine)', { buffer = true })
          -- NOTE: you may want to use l for motion purposes
          vim.keymap.set('n', 'l', '<Plug>(DBUI_SelectLine)', { buffer = true })
          -- basically collapse
          vim.keymap.set('n', 'h', '<Plug>(DBUI_GotoFirstSibling)k<Plug>(DBUI_SelectLine)', { buffer = true })
          vim.keymap.set('n', 'L', '<Plug>(DBUI_GotoLastSibling)', { buffer = true })
          vim.keymap.set('n', 'H', '<Plug>(DBUI_GotoFirstSibling)', { buffer = true })
          vim.keymap.set('n', 'i', '<Plug>(DBUI_ToggleDetails)', { buffer = true })
          vim.keymap.set('n', 'g?', '?', {remap=true}) --how to make this work?
          -- vim.keymap.del('n', '?', { buffer = true })
          vim.defer_fn(function() vim.keymap.del('n', '?', { buffer = true }) end,1000)
          vim.keymap.del('n', 'q', { buffer = true })
          vim.keymap.del('n', '<c-j>', { buffer = true })
          vim.keymap.del('n', '<c-k>', { buffer = true })
        end,
      })

    end,
},
{
  -- visual mode? also use v:register
  'davesavic/dadbod-ui-yank',
  dependencies = { 'kristijanhusak/vim-dadbod-ui' },
  opts = {},
  keys = {
    {"yC", "<CMD>DBUIYankAsCSV<CR>" , ft = 'dbout', buffer = true, desc = "Yank query results in CSV format"} ,
    {"yJ", "<CMD>DBUIYankAsJSON<CR>", ft = 'dbout', buffer = true, desc = "Yank query results in JSON format"},
    {"yX", "<CMD>DBUIYankAsXML<CR>" , ft = 'dbout', buffer = true, desc = "Yank query results in XML format"} ,
  }
},

  {
    -- usa InsertCharPre per rendere uppercase SQL keywords (con tree-sitter)
    -- Mock:
    -- au InsertCharPre <buffer> let v:char=v:char->toupper()

    -- maybe replace with treesitter @statement?
    'jsborjesson/vim-uppercase-sql',
    -- ft = { 'sql' },
    ft = vim.fn.getcompletion('sql', 'filetype'),
  },
}
-- " sql.vim is for sqlite
-- "autocmd BufEnter sql source ~/.vim/syntax/sqlite.vim

--
-- " " autocmd BufEnter db_ui* nnoremap <buffer> <leader>f :%!sqlformat -r -k upper -<cr>
-- " autocmd BufEnter db_ui* nnoremap <buffer> <leader>ff :%!sqlformat -r -k upper -<cr>
--
-- " autocmd BufEnter dbui nmap <buffer> l <Plug>(DBUI_SelectLine)
-- augroup db_ui
-- au!
--      \ exe "nmap <buffer> l <Plug>(DBUI_SelectLine)" |
--      \ exe "nnoremap <buffer> <leader>ff :%!sqlformat -r -k upper -<cr>"
