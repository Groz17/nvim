-- https://github.com/igorlfs/nvim-dap-view
return {
  'rcarriga/nvim-dap-ui',
  -- lazy = true,
  -- init = function()
  --   -- TODO: mettin function in keys (complete though?)
  --   -- https://github.com/mfussenegger/nvim-dap/wiki/Cookbook#detailed-description
  --   vim.api.nvim_create_user_command("RunScriptWithArgs", function(t)
  --     -- :help nvim_create_user_command
  --     args = vim.split(vim.fn.expand(t.args), '\n')
  --     approval = vim.fn.confirm(
  --       "Will try to run:\n    " ..
  --       vim.bo.filetype .. " " ..
  --       vim.fn.expand('%') .. " " ..
  --       t.args .. "\n\n" ..
  --       "Do you approve? ",
  --       "&Yes\n&No", 1
  --     )
  --     if approval == 1 then
  --       dap.run({
  --         type = vim.bo.filetype,
  --         request = 'launch',
  --         name = 'Launch file with custom arguments (adhoc)',
  --         program = '${file}',
  --         args = args,
  --       })
  --     end
  --   end, {
  --   complete = 'file',
  --   nargs = '*'
  -- })
  -- end,
  -- keys = {vim.g.hleader .. 'd'},
  -- keys = '<F5>',
  -- loading Dap and Dap-Ui after setting a breakpoint
  ---@see https://www.reddit.com/r/neovim/comments/1gkac88/comment/lvko4tq/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
  -- keys = {{ "dd", function() require'dap'.set_breakpoint() end, desc = "ﴫ Set Breakpoint", }},
  keys = {
    -- {'<f15>d', desc = "Debug"},
    -- like for macro debugging in emacs
    {'<f15>>', desc = "Debug"},
    -- { 'dU', ':RunScriptWithArgs ', desc = "Debug (args)" }
 },
  dependencies = { 'mfussenegger/nvim-dap' },
  opts = {
    -- magari crea window per tenere hint della hydra?
    layouts = {
      {
        elements = {
          -- Elements can be strings or table with id and size keys.
          { id = 'scopes', size = 0.25 },
          'breakpoints',
          'stacks',
          'watches',
        },
        size = 40, -- default length by columns
        position = 'right',
      },
      {
        elements = {
          -- "repl",
          'console',
        },
        size = 0.25, -- 25% of total vertical lines
        position = 'bottom',
      },
    },
  },
  config = function(_, opts)
    local dap = require('dap')
    local dapui = require('dapui')
    dapui.setup(opts)
    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open({})
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close({})
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close({})
    end

    -- TODO: sposta hydra in file a parte...
    -- ╭─────────────────────────────────────────────────────────╮
    -- │ hydra                                                   │
    -- ╰─────────────────────────────────────────────────────────╯
    local dap_widgets = require('dap.ui.widgets')
    local dap_virtual_text = require('nvim-dap-virtual-text')
    -- TODO: do with snacks?
    -- local fzf_lua = require('fzf-lua')
    local goto_breakpoints = require('goto-breakpoints')

    require('hydra')({
      name = 'Debug',
      -- is it possible to specify where to put the description?
      -- would be nice to have mapping that toggles hint
      -- Would be cool if it behaved like which-key (for mappings with more than 2 keys)
      hint = [[
  BREAKPOINT:
  _dd_: Toggle breakpoint _dc_: Breakpoint condition

  RUN:
  _c_: Continue _._: Run to Cursor

  GO:
  _gl_: Go to line (no execute)

  STEP:
^^     back     ^^  
^      _k_       ^  
out _h_   _l_ into  
^      _j_       ^  
^^     over     ^^  

  OTHERS:
  _p_: Pause _r_: Toggle REPL _s_: session _<c-c>_: terminate
  ]],
      hint = false,
      config = {
        color = 'pink',
        -- unfortunately if you go into subclass buffer=true makes mappings not work anymore
        buffer = false,
        invoke_on_body = true,
        hint = {
          -- position = "top",
          position = 'bottom-left',
        },
        -- Show line number
        on_enter = function() vim.wo.number = true end,
        -- ha senso?
        on_exit = function()
          -- require'dap'.clear_breakpoints() -- sholdn't be necessary tbf
          dap.terminate()
        end,
      },

      mode = 'n',
      -- TODO: usa lazy's keys spec
      body = '<f15>>',
      -- body = '<space>d',
  -- stylua: ignore
  -- maybe make this buffer = true mappings? so you can use default mappings in the elements
  -- consider using space or localleader as well
  -- these mappings should work only on the debuggee and dap elements, not elsewhere... (buffer=true in mappings doesn't seem to work, you gotta put in at config level)
  -- automatically generate hint from heads??? yq lua
  heads = {
    -- Try to use vim mappings that change text and not motions

    --  ╭──────────────────────────────────────────────────────────╮
    --  │                   Start/Pause/Continue                   │
    --  ╰──────────────────────────────────────────────────────────╯
    -- Crea mapping condizionale: se esiste sessione è continue, altrimenti start
    -- { "c", function() dap.continue() end, desc = " Continue", },
    { "c", function() dap.continue() end, desc = " Start", },
    -- So I can use h,j,k and l instead of the uppercase versions 
    -- { "c", function() dap.continue() vim.system({'xdotool', 'key', 'Caps_Lock'}) end, desc = " Start", },
    -- . signifies current line in Vim (it also changes text)
    -- { ".", function() dap.run_to_cursor() end, desc = "省 Run to Cursor", },
    { "R", function() dap.run_last() end, desc = " Run Last" },
    -- { "g", function() dap.goto_() end, desc = "Jump to line", },
    -- { "gl", function() dap.goto_() end, desc = "Jump to line", },
    { "gl", function() dap.goto_(vim.fn.input "[Line] > ") end, desc = "Jump to line", },
    -- { "go", function() dap.goto_(vim.fn.input "[Line] > ") end, desc = "Jump to line", },

    -- { "r", function() dap.restart() end, { silent = true } },
    { "R", function() dap.restart() end },
    -- { "p", function() dap.pause() end, desc = "懶 Pause", },
    -- optional parameter -> v:count?
    { "p", function() dap.pause() end, desc = "懶 Pause", },

    --  ╭──────────────────────────────────────────────────────────╮
    --  │                Breakpoints and Exceptions                │
    --  ╰──────────────────────────────────────────────────────────╯
    -- per stare nella home row
    -- would be nice to toggle breakpoint with global command, even nicer would be to have a function that give the rhs from the lhs,
    -- like g/.../func(a) to execute dap.toggle_breakpoint (maparg() doesn't work with lua I guess)
    -- would be cool to use these in visual mode
    -- can you execute code character-wise so you can use dv0, D (for reverse execution), etc... for breakpoints?
    -- for the love of god, make this support dot-repeat (dmacro.nvim is fine actually)
    -- visual mode breakpoint mappings? v:count?
    -- how to make these show in which-key?
    { "dd", function() dap.toggle_breakpoint() end, desc = "ﴫ Toggle Breakpoint", },
    { "dc", function() dap.set_breakpoint(vim.fn.input "[Condition] > ") end, desc = " Conditional breakpoint", },
    { "dl", function() dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end, { desc = " Log Breakpoint" } },
    { "dh", function() dap.set_breakpoint(nil, vim.fn.input('Hit count: ')) end, desc = " Hit Breakpoint"},
    { "dE", function() dap.set_exception_breakpoints() end, desc="Ask exception breakpoints" },
    -- { "de", function() dap.set_exception_breakpoints('default', { breakMode = 'userUnhandled' }) end, desc="Default exception breakpoints" },
    { "de", function() dap.set_exception_breakpoints('default') end, desc="Default exception breakpoints" },
    -- opzione che non apre la quickfix window?
    -- { "dl", function() dap.list_breakpoints({open=false}) end, desc = "List breakpoints", },
    { "dl", function() dap.list_breakpoints() end, desc = "List breakpoints", },
    { "dr", function() dap.clear_breakpoints() end, desc = "Remove all Breakpoints", },

    -- do they support v:count?
    -- dJ and dK for last and first?
    -- use demicolon ( and )
    { "dj", function() goto_breakpoints.next() end, desc = "Goto next breakpoint" },
    { "dk", function() goto_breakpoints.prev() end, desc = "Goto prev breakpoint" },
    { "D",  function() goto_breakpoints.stopped() end, desc = "Goto DAP stopped location" },

    -- ['['] = { lua "require('persistent-breakpoints.api').load_breakpoints()", 'Load breakpoints' },
    -- [']'] = { lua "require('persistent-breakpoints.api').store_breakpoints()", 'Store breakpoints' },

    --  ╭──────────────────────────────────────────────────────────╮
    --  │                         Snacks                           │
    --  ╰──────────────────────────────────────────────────────────╯
    -- ibhagwan/nvim-lua/lua/plugins/dap/init.lua
    -- magari sposta?
    -- {"d?", function() fzf_lua.dap_commands() end, desc = "fzf nvim-dap builtin commands" , mode = {"n","x"}},
    -- {"dx", function() fzf_lua.dap_configurations() end, desc = "fzf list/run debugger configurations" , mode = {"n","x"}},
    -- {"db", function() fzf_lua.dap_breakpoints() end, desc = "fzf list/delete breakpoints" , mode = {"n","x"}},
    -- {"dv", function() fzf_lua.dap_variables() end, desc = "fzf variables" , mode = {"n","x"}},
    -- {"df", function() fzf_lua.dap_frames() end, desc = "fzf frames" , mode = {"n","x"}},

    --  ╭──────────────────────────────────────────────────────────╮
    --  │                         Session                          │
    --  ╰──────────────────────────────────────────────────────────╯
    { "s", function() vim.print(dap.session()) end, desc = "Print session" },
    { "S", function() vim.print(dap.sessions()) end, desc = "Print sessions" },

    --  ╭──────────────────────────────────────────────────────────╮
    --  │                           REPL                           │
    --  ╰──────────────────────────────────────────────────────────╯
    -- omnifunc/custom_commands
    { "r", function() dap.repl.toggle() end, desc = " Toggle repl", },
    -- R = { lua "require'dap'.toggle()", 'Toggle Repl' },

    --  ╭──────────────────────────────────────────────────────────╮
    --  │                         Stepping                         │
    --  ╰──────────────────────────────────────────────────────────╯
    -- https://inlehmansterms.net/2014/10/31/debugging-vim/ step/next (like Gdbbash vim plugin) -> s,S/n,N or i,I/o,O (maybe a somewhere?)
    -- { "n", function() dap.step_over() end, desc = " Step over", },
    -- { "s", function() dap.step_into() end, desc = " Step into", }, -- what about i for into?
    -- { "J", function() dap.step_into{ askForTargets = true } end, desc = " Step into", },
    -- { "o", function() dap.step_out() end, desc = " Step out", },
    -- step back is the opposite of step into right?
    -- { "S", function() dap.step_back() end, desc = "Step Back", },
    -- would be pretty useful to have caps lock here...
    -- They support vim.v.count 
    -- dilemma: uppercase o lowercase? -- fai in modo che quando metti breakpoint j e k siano quelli di vim (ha senso come cosa dal POV di debugging?)
    -- usa gli stessi simboli di REPL window?
    -- { "h", function() dap.step_back() end, desc = "Step Back", },
    -- use other motions to replace h,j,kl (maybe wasd or similar?) (usa <c-e> e <c-y> nella fase di debugging, ti saranno molto utili)
    -- or maybe create another submode in this hydra for motions only? would be cool
    -- maybe don't define them in the buffer with code but in another? like repl??? maybe hydra hint? (how to identify it? maybe just to copy...)
    -- miniicons step???
    -- also you've got home row mods now
    -- magari questa riga mettila a se stante/on_enter?
    { "h", function() return not vim.startswith(vim.bo.filetype,'dapui_') and  dap.status() ~= '' and dap.step_back() or vim.cmd.norm { "h", bang = true } end, desc = "Step Back", expr=true },
    -- { "j", function()
    --   if dap.status() ~= '' then
    --     dap.step_into()
    --   else vim.cmd.norm { "j", bang = true }
    --   end end, desc = " Step into", },

    { "j", function()
      return not vim.startswith(vim.bo.filetype,'dapui_') and dap.status() ~= '' and
      -- vim.v.count == 1 and dap.step_into({ steppingGranularity='statement' }) or vim.v.count == 2 and
      -- dap.step_into({ steppingGranularity='line' }) or dap.step_into({ steppingGranularity='instruction' })
      dap.step_into()
      or vim.cmd.norm { "j", bang = true }
    end, desc = " Step into", expr=true },

      -- se usi lowercase: { "gj", function() dap.step_into{ askForTargets = true } end, desc = " Step into", },
      -- { "gJ", function() dap.step_into{ askForTargets = true } end, desc = " Step into", },
      -- { "gj", function() dap.step_into{ askForTargets = true } end, desc = "", },
      -- { "w", function() -- w is rot13 of j
      { "J", function() -- w is rot13 of j
        if dap.status() ~= '' then
          dap.step_into{ askForTargets = true }
        -- else vim.cmd.norm { "w", bang = true }
        else vim.cmd.norm { "J", bang = true }
      end end, desc = " Step into", },

    { "k", function() return not vim.startswith(vim.bo.filetype,'dapui_') and  dap.status() ~= '' and dap.step_out() or vim.cmd.norm { "k", bang = true } end, desc = " Step out", expr=true },
    { "l", function() return not vim.startswith(vim.bo.filetype,'dapui_') and  dap.status() ~= '' and dap.step_over() or vim.cmd.norm { "l", bang = true } end, desc = " Step over", expr=true },
    -- { "l", function() vim.notify(tostring(not vim.startswith(vim.bo.filetype,'dapui_') and  dap.status() ~= ''))
      -- return not vim.startswith(vim.bo.filetype,'dapui_') and  dap.status() ~= '' and dap.step_over() or vim.cmd.norm { "l", bang = true } end, desc = " Step over", expr=true },

    { "H", function() dap.reverse_continue() end, desc = 'Reverse Continue' },
    -- u come undo
    -- { "u", function() dap.reverse_continue() end, desc = 'Reverse Continue' },

    -- { "n", function() dap.down() end, desc = "Stacktrace down" },
    -- { "p", function() dap.up() end, desc = "Stacktrace up" },
    -- { "s", function() dap.down() end, desc = "Stacktrace down" },
    -- { "S", function() dap.up() end, desc = "Stacktrace up" },
    { "<", function() dap.up() end, { silent = true } },
    { ">", function() dap.down() end, { silent = true } },
    { ".", function() dap.focus_frame() end, { silent = true } }, --current line? ('.' in vim=current line mnemonic)


    --  ╭──────────────────────────────────────────────────────────╮
    --  │             Widgets (all uppercase mappings)             │
    --  ╰──────────────────────────────────────────────────────────╯
    -- Maybe use prefix for widgets... (_w_: widgets) (w no perchè motion) (magari u for ui (usa uppercase letters per centered_float?))
    -- https://github.com/mfussenegger/nvim-dap/pull/621
    { "K", function() dap_widgets.hover() end, mode = {"n", "x"}, desc = "Hover Variables", },
    { "P", function() dap_widgets.preview() end, desc = "Preview Variables", },
    -- { "S", function() dap_widgets.scopes() end, desc = "Scopes", },
    { "S", function() dap_widgets.centered_float(dap_widgets.scopes) end, desc = "Scopes", },
    -- Use same mapping as treesitter's text-object
    { "F", function() dap_widgets.centered_float(dap_widgets.frames) end, desc = "Frames", },

    -- s = { cmd 'DapScopesFloat', 'Scopes float' },
    -- f = { cmd 'DapFramesFloat', 'Frames Float' },
    -- e = { cmd 'DapExpressionFloat', 'Expression float' },
    -- t = { cmd 'DapThreadsFloat', 'Threads float' },

    --  ╭──────────────────────────────────────────────────────────╮
    --  │                       Virtual text                       │
    --  ╰──────────────────────────────────────────────────────────╯
    -- { "v", function() dap_virtual_text.toggle() end, desc = "Toggle Virtual Text", },

    -- dap-ui
    -- h = { lua "require'dapui'.eval(nil, { enter = true })", 'Hover' },
    -- K like in termdebug?
    { "x", function() dapui.eval() end, mode = {"n", "x"}, desc = "Evaluate", },
    { "X", function() dapui.eval(vim.fn.input "[Expression] > ") end, desc = "Evaluate Input", },
    -- { "U", function() dapui.toggle() end, desc = "Toggle UI", },
    { "U", function() dapui.toggle() end, desc = " Toggle UI", },

    -- ╭─────────────────────────────────────────────────────────╮
    -- │ Stopping, quitting and just exiting                     │
    -- ╰─────────────────────────────────────────────────────────╯
    { "Q", function() dap.close() end, desc = "Quit", },
    -- use this for macros
    -- { "q", function() dap.disconnect() end, desc = "Disconnect", },
    { "<c-g>", function() dap.terminate() end, desc = "Terminate", },
    -- Lo posso comunque usare in visual mode (e anche negli elements possibilmente)
    -- put terminate here insteaf on on_exit? is there difference?
    -- { "<esc>", nil, { exit = true, nowait = true, desc = "Exit" } },
    { "<c-g>", nil, { exit = true, nowait = true, desc = "Exit" } },
  },
    })
  end,
}
