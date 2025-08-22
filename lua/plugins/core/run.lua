-- usa M-: like in emacs?
-- <space><space> in visual mode to execute?
-- vim.keymap.set('x','<space><space>','<localleader>p', { remap = true, buffer = true })

-- Support shebang?

-- Neorg support

-- how to run when it needs to accept user input?
return {
  {
    -- Sniprun synergises exceptionnally well with plugins that help you creating print/debug statements, such as vim-printer.
    -- ╭─────────────────────────────────────────────────────────╮
    -- │ Code runner                                             │
    -- ╰─────────────────────────────────────────────────────────╯
    -- write pr to use <cmd> instead of : in mappings...
    -- Add preprocessor options, like using sass --scss and replace the buffer... (similar to vim-scriptease's g=)
    'michaelb/sniprun',
    cond=false,
    -- maybe use cond for filetypes like sql, etc... that have already an operator?
    build = 'bash install.sh',
    cmd = 'SnipRun',
    -- meglio non usare <cr> (è usata per molte cose, tipo quickfix window)

    -- https://github.com/search?q=%3CPlug%3ESnipRunOperator&type=repositories
    --  " ["."] = { cmd("SnipReset"), "Stop running" },

    opts = {
      --# you can combo different display modes as desired and with the 'Ok' or 'Err' suffix
      --# to filter only sucessful runs (or errored-out runs respectively)
      display = {
        -- "Classic",                    --# display results in the command-line  area
        -- "VirtualTextOk",              --# display ok results as virtual text (multiline is shortened)
        -- "VirtualTextErr",              --# display err results as virtual text (multiline is shortened)
        -- 'VirtualText', --# display results as virtual text
        -- "TempFloatingWindow",      --# display results in a floating window (how to console after changing text?)
        -- "LongTempFloatingWindow",  --# same as above, but only long results. To use with VirtualText[Ok/Err]
        'Terminal', --# display results in a vertical split
        -- 'VirtualLine', --# display results in a vertical split
        -- maybe use markdown as ft?
        -- "TerminalWithCode",        --# display results and code history in a vertical split
        -- TODO: 'NvimNotify', --# display with the nvim-notify plugin (usa snacks)
        -- 'NvimNotify', --# display with the nvim-notify plugin (usa snacks)
        -- "Api"                      --# return output to a programming interface
      },
      display_options = {
        terminal_scrollback = vim.o.scrollback, -- change terminal display scrollback lines
        terminal_line_number = false, -- whether show line number in terminal window
        terminal_signcolumn = false, -- whether show signcolumn in terminal window
        terminal_position = 'horizontal', --# or "horizontal", to open as horizontal split instead of vertical split
        terminal_width = 45, --# change the terminal display option width (if vertical)
        terminal_height = 10, --# change the terminal display option height (if horizontal)
      },
      -- Make it fire when you exit insertmode... (TextChanged)
      live_mode_toggle = 'enable',
      -- live_display = { "VirtualText", "TerminalOk"} --..or anything you want
      live_display = { 'NvimNotify' }, --..or anything you want
      interpreter_options = {
        Generic = {
          error_truncate = 'long', -- strongly recommended to figure out what's going on
          -- add REPL support...
          PerlConfig = {
            supported_filetypes = { 'perl' }, -- mandatory
            extension = '.pl', -- recommended, but not mandatory. Sniprun use this to create temporary files
            interpreter = 'perl', -- interpreter or compiler (+ options if any)
            compiler=''
          },
        },
        GFM_original = {
          use_on_filetypes = { 'markdown', 'vimwiki' },
        },
        -- pip install --user klepto
        -- it doesn't work
        -- repl_enable = {'Python3_original','Bash_original'}
      },
      -- sudo npm install -g ts-node typescript
    },

    keys = {
      -- what about jk?
      -- usa kanata mapping
      -- { 'gss', '<Plug>SnipRun', desc = 'Current Line' },
      { '<f12><c-e>', '<Plug>SnipRun', desc = 'Current Line' },
      -- { '<c-cr><cr>', '<Plug>SnipRun', desc = 'Current Line' },
      -- { 'gs', '<Plug>SnipRun', mode = { 'x' }, desc = 'Run Code' },
      { '<f12><c-e>', '<Plug>SnipRun', mode = { 'x' }, desc = 'Run Code' },
      -- { '<c-cr>', '<Plug>SnipRun', mode = { 'x' }, desc = 'Run Code' },
      -- { '<CR>', '<Plug>SnipRun', mode = { 'x' }, desc = 'Run Code' },
      -- { 'gs', '<Plug>SnipRunOperator', desc = 'Run Code' },
      -- { '<c-cr>', '<Plug>SnipRunOperator', desc = 'Run Code' },
      --  Every text-object will be rounded line-wise.
      -- { 'gS',  '<Plug>SnipRunOperator$'},
      -- { 'gS',  function() vim.ui.input({prompt_title="Insert arguments:"},function(input) if input then return ":%SnipRun " .. input end end) end,expr=true},
      -- {
      --   -- maybe use gs<letter for argument text object> to save a mapping (hopefully not a letter that is a motion)
      --   -- "gS",
      --   -- per il momento usiamo A...
      --   'gsA',
      --   function()
      --     vim.ui.input({
      --       prompt = 'Insert arguments: ',
      --     }, function(arguments)
      --       -- if arguments then vim.g.sniprun_cli_args = string(arguments) return ":%SnipRun " .. arguments end
      --       --   M.notify('run', range_begin, range_end, M.config_values, vim.g.sniprun_cli_args or "" )
      --       -- if arguments then require'sniprun'.run(opts...) end end) end},
      --       if arguments then
      --         vim.g.sniprun_cli_args = tostring(arguments)
      --         vim.b.caret = vim.fn.winsaveview()
      --         require('sniprun').run('w')
      --         vim.fn.winrestview(vim.b.caret)
      --         -- vim.g.sniprun_cli_args = ''
      --         -- Is there a native lua way to do this?
      --         vim.g.sniprun_cli_args = nil
      --       end
      --     end)
      --   end,
      --   desc = 'Run Code [With Arguments]',
      -- },

      -- it toggles it
      -- { 'gS',  '<Plug>SnipLive'},
      -- { "gX", "<Plug>SnipLive" ,desc="Run Code [Live Mode]"},
      -- { 'gsx', '<Plug>SnipLive', desc = 'Run Code [Live Mode]' },

      -- conflitto con vimwiki (go back link)
      -- nmap <bs><bs> <Plug>SnipClose

      -- let g:BASH_Ctrl_j = 'off'

      -- { '<c-cr>','<Plug>SnipRun', mode='i',desc = 'Run Code' },
      -- { '<c-cr>',[[<c-o><cmd>execute "normal \<Plug>SnipRun"<CR>]], mode='i',desc = 'Run Code' },
      -- { '<c-cr>',[[<c-o>:execute "normal \<Plug>SnipRun"<CR>]], mode='i',desc = 'Run Code' },
      -- { '<c-cr>',[[<cmd>execute "normal \<Plug>SnipRun"<CR>]], mode='i',desc = 'Run Code' },
      -- { '<c-cr>',[[<cmd>%SnipRun<CR><c-o><c-o>]], mode='i',desc = 'Run Code' },
      -- { '<c-cr>',[[<cmd>k'|%SnipRun|'`<CR>]], mode='i',desc = 'Run Code' },
      -- https://github.com/michaelb/sniprun/discussions/200
      -- { '<cr>', ":let b:caret=winsaveview()<CR>:%SnipRun <CR>:call winrestview(b:caret)<CR>",desc = 'Run Code on Buffer' },
      -- {
      --   '<c-cr>',
      --   '<c-o>:let b:caret=winsaveview()<CR><c-o>:%SnipRun <CR><c-o>:call winrestview(b:caret)<CR>',
      --   mode = 'i',
      --   desc = 'Run Code on Buffer',
      -- },
    },
  },
  -- nvim-playground
}
