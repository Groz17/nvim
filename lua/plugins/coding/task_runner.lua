return {
  {
    'stevearc/overseer.nvim',
    cond = false,
    opts = {
      task_list = {
        direction = 'left',
        bindings = {
          ['<C-h>'] = false,
          ['<C-j>'] = false,
          ['<C-k>'] = false,
          ['<C-l>'] = false,
          ['L'] = 'IncreaseDetail',
          ['H'] = 'DecreaseDetail',
          ['<PageUp>'] = 'ScrollOutputUp',
          ['<PageDown>'] = 'ScrollOutputDown',
        },
      },
    },
    keys = {
      -- <c-c><c-c> to run?
      {"<leader>o",'<nop>',desc="Overseer"},
      {
        '<leader>ot',
        '<cmd>OverseerToggle<CR>',
        desc = 'Toggle Overseer Task List',
      },
      { '<leader>or', '<cmd>OverseerRun<CR>', desc = 'Run Overseer Task' },
      {
        '<leader>ol',
        '<cmd>OverseerRunCmd<CR>',
        desc = 'Run Command in Overseer',
      },
      {
        '<leader>oq',
        '<cmd>OverseerQuickAction<CR>',
        desc = 'Quick Action for Overseer Task',
      },
      {
        '<leader>oa',
        '<cmd>OverseerTaskAction<CR>',
        desc = 'Select and Act on Overseer Task',
      },
      {
        '<leader>oc',
        '<cmd>OverseerClearCache<CR>',
        desc = 'Clear Overseer Task Cache',
      },
      {
        '<leader>os',
        '<cmd>OverseerSaveBundle<CR>',
        desc = 'Save Overseer Task Bundle',
      },
      {
        '<leader>ob',
        '<cmd>OverseerLoadBundle<CR>',
        desc = 'Load Overseer Task Bundle',
      },
    },
config = function(_, opts)
  require('overseer').setup(opts)
  local lualine = require'lualine'
  local lualine_config = lualine.get_config()
  -- doesn't work w/ everforest :d
  -- you can have multiple tasks at the same time right (winbar), while for example only a macro (tabline)
  -- what if lualine_a is nil/empty? or {} trick doesn't work
  -- table.insert(lualine_config.winbar.lualine_a, 1, { 'overseer' })
  -- seems like statusline plugin adds tasks...
  table.insert(lualine_config.tabline.lualine_a, 1, { 'overseer' })
  lualine.setup(lualine_config)
end
  },
}
