-- You also have \\ at your disposal (maybe for mapping outside hydra? or most used hydra?)
-- u can also implement hydra with kanata: on enter press prefix, on exit release it

-- also use vim.g.hleader prefix for mappings that involve hydra-like experience like multi-cursors

-- require('hydra.keymap-util')
-- local cmd = require("hydra.keymap-util").cmd

return {
  'nvimtools/hydra.nvim',
  pin = true,
  -- dependencies = 'anuvyklack/keymap-layer.nvim',
  -- keys = {
  --   -- risolto il problema lazy-loading: usa un prefisso leader
  --   -- now they don't show in which-key though
  --   -- [[\]]
  --   -- Do I need really to waste a whole keybinding like \ for hydra? use <space><letter> or smth
  --   vim.g.hleader,
  --   -- [[\\]] to toggle hint?
  -- },
  lazy = true,
  opts = {
    hint = {
      float_opts = {
        style = 'minimal',
        -- FIX: border = "rounded",
      },
    },
  },
  config = function(_, opts)
    -- HACK: added pr to fix nightly bug (https://github.com/stevearc/overseer.nvim/blob/master/doc/components.md#dependencies)
    require('hydra').setup(opts)
  end,
}
