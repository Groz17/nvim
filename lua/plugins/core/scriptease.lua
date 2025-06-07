return
  -- Do not lazy load vim-scriptease, as it breaks :Breakadd/:Breakdel
  -- TODO: Check if lazy load works
  { "tpope/vim-scriptease",
    -- lazy = false,
    lazy = true,
    -- Verbose useless since you can do <c-cr>
    -- Use <C-D> or smth else in PP to cancel command?
    -- command history of repl? (PP)
    cmd = { "Breakadd", "Breakdel", "Disarm", "Messages", "PP", "PPmsg", "Runtime", "Scriptnames", "Verbose", "Vpedit", "Vsplit", "Vtabedit", "Vvsplit" },
    keys = {
      -- make it work with treesitter if working in buffer
      -- doesn't work?
    { 'zS', desc = "Show syntax highlighting groups" },
    -- { 'K' },
      -- doesn't work if lazy-loaded
    -- { 'g=', desc = "Call eval()" },
    -- { 'g!', desc = "Call eval()" }
    },
    config = function()
      -- vim.keymap.del('n','g=')
    end
  }
