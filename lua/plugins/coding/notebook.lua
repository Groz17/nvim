-- FIX: doesn't work...
return {
  {
    -- TODO: https://github.com/GCBallesteros/NotebookNavigator.nvim/issues?q=is%3Aopen+is%3Aissue hydra hint border fix
    'GCBallesteros/NotebookNavigator.nvim',
    cond = false,
    ---@type LazyKeysSpec[]
    keys = {
      { ']h', function() require('notebook-navigator').move_cell('d') end },
      { '[h', function() require('notebook-navigator').move_cell('u') end },
      { '<leader>X', "<cmd>lua require('notebook-navigator').run_cell()<cr>" },
      { '<leader>x', "<cmd>lua require('notebook-navigator').run_and_move()<cr>" },
    },
    dependencies = {
      -- "echasnovski/mini.comment", -- using native commentstring
      -- "hkupty/iron.nvim", -- repl provider
      -- "akinsho/toggleterm.nvim", -- alternative repl provider
      'benlubas/molten-nvim', -- alternative repl provider
      -- "nvimtools/hydra.nvim",
      -- "echasnovski/mini.hipatterns",
    },
    event = 'VeryLazy',
    config = function()
      local nn = require('notebook-navigator')
      nn.setup({ activate_hydra_keys = vim.g.hleader .. 'h' })

      -- require('mini.hipatterns').setup({
      --   highlighters = { cells = nn.minihipatterns_spec },
      -- })
      -- c = cell
      require('mini.ai').setup({ custom_textobjects = { c = nn.miniai_spec } })
    end,
  },
}
