-- https://github.com/rdpopov/nvim-sak
-- https://github.com/vim-scripts/ReplaceWithRegister?tab=readme-ov-file (gr mapping)
  -- https://github.com/vim-scripts/ReplaceWithSameIndentRegister

-- vim.notify("Exchange doesn't works with blockwise selections (for the moment)", vim.log.levels.INFO, {})
-- https://github.com/eugen0329/vim-esearch
--
-- find inspiration for mappings
-- https://github.com/search?q=SubversiveSubstitute&type=code

-- local sub_prefix = 'g<space>'

-- usa S per questi plugin di sostituzione...
return {
  {
    -- https://github.com/AckslD/muren.nvim/issues/26
    'AckslD/muren.nvim',
    cmd = { "MurenToggle", "MurenOpen", "MurenUnique" },
    keys = {
      -- {mode={"n","x"},"Sr", [[<Cmd>MurenToggle<CR>]]},
      -- {mode={"n","x"},"Sf", [[<Cmd>MurenFresh<CR>]]},
      -- {mode={"n","x"},"Su", [[<Cmd>MurenUnique<CR>]]},
      -- {"cu", function() vim.fn.setreg('/', vim.fn.expand('<cword>')) require'muren.api'.open_unique_ui({ }) end, desc = "MurenWord" },
      -- {"cU", function() require'muren.api'.open_unique_ui({ }) end, desc = "MurenWord" },
    },
    config = true,
    cond=false,
  },

  {

    'MagicDuck/grug-far.nvim',
    -- keys = {
    --   {
    --     mode = { 'n', 'x' }, '<c-s-/>',
    --     function()
    --       local search = vim.fn.getreg('/')
    --       if search and vim.startswith(search, '\\<') and vim.endswith(search, '\\>') then search = '\\b' .. search:sub(3, -3) .. '\\b' end
    --       require('grug-far').open({ prefills = { search = search } })
    --     end,
    --       { desc = 'grug-far: Search using @/ register value or visual selection' },
    --     }
    -- },
    -- TODO: turn quickfix into grug-far buffer?
    opts = {
      headerMaxWidth = 80,
      -- BUG: using tabnew rarely opens files (all of the in floatin windows btw)
      -- windowCreationCommand = 'tabnew',
      -- windowCreationCommand = 'rightbelow 120vnew',
      windowCreationCommand = "topleft vsplit",
      startInInsertMode = false,
      transient = true,
      resultLocation={
        -- numberLabelPosition = 'eol',
        numberLabelPosition = 'inline',
    },
    helpLine = { enabled = false },

    -- max number of parallel replacements tasks
    -- NOTE: not sure if it's a good idea
    -- maxWorkers = vim.uv.available_parallelism(),
    keymaps = {
      -- don't add if already present?
      -- historyOpen      = { n = '<localleader>h' },
      -- openNextLocation = { n = '<localleader>j' },
      -- openPrevLocation = { n = '<localleader>k' },
    },
  },
    cmd = 'GrugFar',
  },
}
