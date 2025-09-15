-- https://github.com/Erl-koenig/theme-hub.nvim
return {
  {
    'oonamo/ef-themes.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      -- vim.cmd [[colorscheme ef-summer]]
      vim.cmd [[colorscheme ef-dark]]
    end,
  },
  --         ╭──────────────────────────────────────────────────────────╮
  --         │              COLORSCHEME-AFFECTING PLUGINS               │
  --         ╰──────────────────────────────────────────────────────────╯
  -- https://github.com/skywind3000/vim-color-patch
  {
    "xiyaowong/transparent.nvim",
    cmd = { 'TransparentToggle', 'TransparentEnable', 'TransparentDisable' },
    keys = { { '<f13>0', '<cmd>TransparentToggle<cr>' }, },
    opts = {
      extra_groups = {
        "NormalFloat",    -- plugins which have float panel such as Lazy, Mason, LspInfo
        "NvimTreeNormal", -- NvimTree
      },
      -- lualine_style = "default",
      -- lualine_style = "stealth",
    },
    config = function()
      local transparent = require("transparent")
      transparent.clear_prefix("lualine")
      -- if config.transparent then
      -- vim.cmd("TransparentEnable")
      -- end
    end,
  },



}
