--https://github.com/folke/snacks.nvim/issues/759
-- lua= Snacks.terminal.list()
return {
  'snacks.nvim',
  -- magari usa % e " come in tmux?
  keys = {

    -- non devi premere <CR> dopo <C-D>!
    -- TODO: vertical terminal?
    -- realdine non funge, like <alt-number> to insert number volte lo stesso char
    -- bottom split perche voglio usarlo tante volte (non one shot)->pipeline
    -- { '<c-|>', function() Snacks.terminal(nil, { cwd = vim.fn.expand('%:p:h') }) end, desc = 'Toggle Terminal' },
    -- { [[<c-s-\>]], function() Snacks.terminal(nil, { cwd = vim.fn.expand('%:p:h') }) end, desc = 'Toggle Terminal' },
    -- { '<leader>"', function() Snacks.terminal() end, desc = 'Toggle Terminal (Root)' },
    -- { '<leader><s-cr>', function() Snacks.terminal() end, desc = 'Toggle Terminal (Root)' },
    -- { "<leader>%", function() Snacks.terminal(nil,{win={position='right'}}) end, desc = 'Toggle Terminal (Root)' },
    -- { "<leader><cr>", function() Snacks.terminal(nil,{win={position='right'}}) end, desc = 'Toggle Terminal (Root)' },
    { "<leader><cr>", function() Snacks.terminal(nil,{cwd = vim.fn.expand('%:p:h'),win={position='right'}}) end, desc = 'Toggle Terminal (Root)' },
    -- { "<leader><a-cr>", function() Snacks.terminal(nil,{cwd = vim.fn.expand('%:p:h'),win={position='right'}}) end, desc = 'Toggle Terminal (Root)' },

    -- usa stessi binding di termina/ghostty?
    -- { "<space>v", function() Snacks.terminal(nil,{cwd = vim.fn.expand('%:p:h'),win={position='right'}}) end, desc = 'Toggle Terminal (Root)' },
    -- { '<space>V', function() Snacks.terminal(nil,{win={position='right'}}) end, desc = 'Toggle Terminal (Root)' },
    -- { "<space>s", function() Snacks.terminal(nil,{cwd = vim.fn.expand('%:p:h')}) end, desc = 'Toggle Terminal (Root)' },
    -- { '<space>S', function() Snacks.terminal() end, desc = 'Toggle Terminal (Root)' },

    -- maybe add <c-;> for bottom/left or smth?
    -- {
      --   '<c-_>',
      --   function() Snacks.terminal() end,
      --   desc = 'which_key_ignore',
      -- },
      -- TermHl?
      -- { '<c-*>', function() Snacks.terminal.colorize() end, desc = 'Colorize the current buffer' },
      -- like ansi escape codes
      -- { '<space><esc>', function() Snacks.terminal.colorize() end, desc = 'Colorize the current buffer' },
      { '<space><c-[>', function() Snacks.terminal.colorize() end, desc = 'Colorize the current buffer' },
      {
        '<space>/',
        function() Snacks.terminal.toggle(nil, { cwd = vim.fn.expand('%:p:h'), win = { position = 'float', border = 'rounded', height = 0.7,  width = 0.7 }, })
        end,
        desc = 'Toggle Floating Terminal',
        mode = { 'n' --[[, "t"]], }, -- Aktiviert die Tastenkombination im Normal- und Terminalmodus
      },
      -- {
      --   '<C-s-/>',
      --   function()
      --     Snacks.terminal.toggle(nil, { win = { position = 'float', border = 'rounded' ,height = 0.6,  width = 0.5  } }) end,
      --     desc = 'Toggle Floating Terminal (Root)',
      --     mode = { 'n' --[[, "t"]], }, -- Aktiviert die Tastenkombination im Normal- und Terminalmodus },
      --   },
      },
      opts = {
        terminal = {
          win = {
            wo = {
              winbar = '',
            },
          },
        },
      },
    }
