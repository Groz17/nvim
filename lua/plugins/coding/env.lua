-- https://github.com/philosofonusus/ecolog.nvim/issues/36
-- https://github.com/philosofonusus/ecolog.nvim/issues/12
-- https://github.com/philosofonusus/ecolog.nvim?tab=readme-ov-file
---@type LazySpec
-- how to use w/ http rest file/plugin?
return {
  'philosofonusus/ecolog.nvim',
  cond=false,
  dependencies = {
    'saghen/blink.cmp', -- Optional: for autocompletion support (recommended)
  },
  -- cmd = { 'EcologFzf' },
  -- Optional: you can add some keybindings
  -- (I personally use lspsaga so check out lspsaga integration or lsp integration for a smoother experience without separate keybindings)
  keys = {
    { '<leader>$g', '<cmd>EcologGoto<cr>', desc = 'Go to env file' },
    { '<leader>$p', '<cmd>EcologPeek<cr>', desc = 'Ecolog peek variable' },
    { '<leader>$s', '<cmd>EcologSelect<cr>', desc = 'Switch env file' },
    { '<leader>$f', '<CMD>EcologSnacks<CR>', desc = 'Open Snacks picker' },
  },
  -- Lazy loading is done internally
  lazy = false,
  opts = {
    integrations = {
      -- WARNING: for both cmp integrations see readme section below
      nvim_cmp = false, -- If you dont plan to use nvim_cmp set to false, enabled by default
      -- If you are planning to use blink cmp uncomment this line
      blink_cmp = true,
      lsp = true,
      snacks = true,
    },
    -- vim_env = true,
    -- Enables shelter mode for sensitive values
    shelter = {
      configuration = {
        partial_mode = false, -- false by default, disables partial mode, for more control check out shelter partial mode
        mask_char = '*', -- Character used for masking
      },
      modules = {
        cmp = true, -- Mask values in completion
        peek = false, -- Mask values in peek view
        files = false, -- Mask values in files
        telescope = false, -- Mask values in telescope
      },
    },
    -- true by default, enables built-in types (database_url, url, etc.)
    types = true,
    path = vim.fn.getcwd(), -- Path to search for .env files
    preferred_environment = 'development', -- Optional: prioritize specific env files
  },
}
