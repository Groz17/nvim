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
    -- filter by open buffers (would be nice if you use % or ## in Path [total Vim integration...])
    --:lua require('grug-far').open({ prefills = { paths = vim.fn.expand("##") } })
    -- :lua require('grug-far').open({ prefills = { search = vim.fn.expand("<cword>") } })

    -- non funge bene con autochdir
    'MagicDuck/grug-far.nvim',
    keys = {
      -- nice idea because they don't conflict with vim if you use <leader> as prefix also <leader>{<[c,m]-.>} is very uncommon
      -- would be nice if you can gd on vim commands to go to their (plugin) definition
      -- also mappings for current cd and workspace? use consistent mappings for those
      -- think of <space><modifiers> like if <space> is universal argument in emacs, basically just a slightly different behaviour (uppercase version for project)
      {mode="x",'<space><m-c-s-5>',":GrugFarWithin ast-grep<cr>"},
      {mode="n",'<space><m-c-s-5>',"<cmd>GrugFar ast-grep<cr>"},
      {mode="x",'<m-c-s-5>',":GrugFarWithin ripgrep<cr>"},
      {mode="n",'<m-c-s-5>',"<cmd>GrugFar ripgrep<cr>"},
      {
        mode = { 'n', 'x' },
        '<c-s-/>',
        function()
          local search = vim.fn.getreg('/')
          if search and vim.startswith(search, '\\<') and vim.endswith(search, '\\>') then search = '\\b' .. search:sub(3, -3) .. '\\b' end
          require('grug-far').open({ prefills = { search = search } })
        end,
          { desc = 'grug-far: Search using @/ register value or visual selection' },
        }
    },
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
    -- you can always modify the argument list btw (replace w/ open buffers for ex...)
    -- keys = {{'<c-s-q>',function() require('grug-far').open({ prefills = { paths = vim.fn.expand("##") } }) end}},
    -- keys = {{mode={'n','x'},'<c-s>',function() require('grug-far').open({ prefills = { paths = vim.fn.expand("##") } }) end}},
    -- or you could write a function listing open buffers inside paths=...
    -- keys = {{
    --   mode={'n','x'},
    --   -- '<c-s-q>',
    --   '<c-s>',
    --   -- function() require('grug-far').open({ prefills = { paths = vim.fn.expand("##") } }) end,
    --   function() require('grug-far').open({}) end,
    -- }},
    --:lua 
    -- by default, in visual mode, the visual selection is used to prefill the search
  },
}
