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
    -- { "<leader><cr>", function() Snacks.terminal(nil,{win={position='right'}}) end, desc = 'Toggle Terminal (Root)' },
    -- TODO: check if normal file, like not fugitive or healthcheck file
    { "<leader><cr>", function() Snacks.terminal(nil, { cwd = vim.fn.expand('%:p:h'), win = { position = 'right' } }) end, desc = 'Terminal (cwd)' },
    { "<leader><s-cr>", function() Snacks.terminal(nil, { cwd = vim.fn.expand('%:p:h'), win = { position = 'bottom' } }) end, desc = 'Terminal (cwd)' },
    { "<f12>ps",      function() Snacks.terminal(nil, { cwd = Snacks.git.get_root(), win = { position = 'right' } }) end, desc = 'Terminal (Root)' },
    -- TODO: usa nlua (neovim repl?)
    { "<f12>pe",      function() Snacks.terminal({ cmd = "lua" }, { cwd = Snacks.git.get_root(), win = { position = 'right' } }) end, desc = 'Terminal (Root)' }, -- lua=elisp (concettualmente)

    -- like ansi escape codes
    -- { '<space><esc>', function() Snacks.terminal.colorize() end, desc = 'Colorize the current buffer' },
    -- { '<space><c-[>', function() Snacks.terminal.colorize() end, desc = 'Colorize the current buffer' },
    { '<space>[', function() Snacks.terminal.colorize() end, desc = 'Colorize the current buffer' },
    -- { '<f15><c-[>', function() Snacks.terminal.colorize() end, desc = 'Colorize the current buffer' },
    {
      '<space>/',
      function()
        Snacks.terminal.toggle(nil,
          {
            cwd = vim.fn.expand('%:p:h'),
            win = { position = 'float', border = 'rounded', height = 0.7, width = 0.7 },
          })
      end,
      desc = 'Toggle Floating Terminal',
      mode = { 'n' --[[, "t"]], },   -- Aktiviert die Tastenkombination im Normal- und Terminalmodus
    },
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
