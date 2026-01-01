-- dispatch(s) mappings?
return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",  -- required
    -- TODO: "sindrets/diffview.nvim", -- optional - Diff integration

    "folke/snacks.nvim",      -- optional
  },
  cmd = { 'Neogit' },
  keys = {
    { '<f12>g', '<CMD>Neogit<CR>' },
  },
  opts = {},
}
