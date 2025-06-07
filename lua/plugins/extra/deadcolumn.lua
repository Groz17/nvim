return
  {
    "Bekaboo/deadcolumn.nvim",
    cond = false,
    event = { "VeryLazy" },
    init = function()
      -- NOTE: Monitor this
      vim.opt.textwidth = 80
      vim.opt.colorcolumn = "+2"
    end,
  }
