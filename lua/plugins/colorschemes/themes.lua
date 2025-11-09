-- https://github.com/Erl-koenig/theme-hub.nvim
-- https://github.com/miikanissi/modus-themes.nvim
return {
  {
    'oonamo/ef-themes.nvim',
    lazy = false,
    priority = 1000,
    opts = {
    transparent = true,
      -- would be cool w/ transition
      light = "ef-summer",
      dark = "ef-owl"
    },
    config = function(_, opts)
      require("ef-themes").setup(opts)
      vim.cmd [[colorscheme ef-theme]]
    end,
  },

}
