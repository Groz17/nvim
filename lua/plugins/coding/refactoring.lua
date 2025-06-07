-- gn?
return {
  -- TODO: make it work with dot-repeat
  'ThePrimeagen/refactoring.nvim',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-treesitter/nvim-treesitter' },
  },
  cmd = 'Refactor',
  keys = {
    -- create better mappings (kanata)
    {mode= {"n", "x"}, "<leader>rr", function() return require('refactoring').select_refactor() end, desc='Prompt for a refactor to apply '},
    -- where are operator mappings
    {mode= {"n", "x"}, '<leader>rf', function() return require('refactoring').refactor('Extract Function') end, expr = true, desc = 'Extract Function' },
    {mode= {"n", "x"}, '<leader>rF', function() return require('refactoring').refactor('Extract Function To File') end, expr = true, desc = 'Extract Function To File' },
    {mode= {"n", "x"}, '<leader>rv', function() return require('refactoring').refactor('Extract Variable') end, expr = true, desc = 'Extract Variable' },
    {mode= {"n", "x"}, '<leader>rb', function() return require('refactoring').refactor('Extract Block') end, expr = true, desc = 'Extract Block' },
    {mode= {"n", "x"}, '<leader>rB', function() return require('refactoring').refactor('Extract Block To File') end, expr = true, desc = 'Extract Block To File' },

    {mode = { 'n', 'x' },  '<leader>rI', function() return require('refactoring').refactor('Inline Function') end, expr = true, desc = 'Inline Function' },
    -- how to inline only in region?
    {mode = { 'n', 'x' },  '<leader>ri', function() return require('refactoring').refactor('Inline Variable') end, expr = true, desc = 'Inline Variable' },

    -- { '<leader>rr', function() require('telescope').extensions.refactoring.refactors() end, mode = { 'n', 'x' }, desc = 'View refactors' },

    { '<leader>rj', function() require('refactoring').debug.printf() end, desc = 'Debug line below' },
    { '<leader>rk', function() require('refactoring').debug.printf({ below = false }) end, desc = 'Debug line above' },
    -- simile ai comandi p, P
    -- doesn't work with multiple variables... (same print or multiple print)
    { '<leader>rp', function() require('refactoring').debug.print_var() end, mode = { 'x', 'n' },desc = 'Debug variable below' },
    { '<leader>rP', function() require('refactoring').debug.print_var({ below = false }) end, mode = { 'x', 'n' },desc = 'Debug variable below' },
    -- { '<leader>rp', function() require('refactoring').debug.print_var({ normal = true }) end, desc = 'Debug variable below' },
    -- { '<leader>rp', function() require('refactoring').debug.print_var() end, mode = { 'x' }, desc = 'Debug variable above' },
    { '<leader>rd', function() require('refactoring').debug.cleanup() end, mode = { 'n', 'x' }, desc = 'Cleanup debug prints' },
  },
  opts = {
    -- prompt for return type
    prompt_func_return_type = {
        go = true,
        cpp = true,
        c = true,
        java = true,
    },
    -- prompt for function parameters
    prompt_func_param_type = {
        go = true,
        cpp = true,
        c = true,
        java = true,
    },
  },
  -- config = function(_, opts)
  --   require('refactoring').setup(opts)
  --   -- require('telescope').load_extension('refactoring')
  --   -- vim.o.operatorfunc = "v:lua.require'refactoring'.debug.print_var_operatorfunc"
  -- end,
}
