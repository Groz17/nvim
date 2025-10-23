-- https://github.com/rdpopov/nvim-sak
-- https://github.com/vim-scripts/ReplaceWithRegister?tab=readme-ov-file (gr mapping)
  -- https://github.com/vim-scripts/ReplaceWithSameIndentRegister

-- vim.notify("Exchange doesn't works with blockwise selections (for the moment)", vim.log.levels.INFO, {})
-- https://github.com/eugen0329/vim-esearch
--
-- find inspiration for mappings
-- https://github.com/search?q=SubversiveSubstitute&type=code
return {

  {
    'MagicDuck/grug-far.nvim',
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
