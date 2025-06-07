return
  {
    -- convert quickfix to trouble and viceversa? trouble should just replace quickfix tbh
    'folke/trouble.nvim',
    -- https://github.com/folke/trouble.nvim/blob/main/docs/examples.md
    opts = {
      use_diagnostic_signs = true,
      modes = {
        diagnostics_buffer = {
          mode = 'diagnostics', -- inherit from diagnostics mode
          filter = { buf = 0 }, -- filter diagnostics to the current buffer
          preview = {
            type = 'split',
            relative = 'win',
            position = 'right',
            size = vim.api.nvim_win_get_width(0) / 2,
          },
        },
      },
    },
    cmd = 'Trouble',
    -- usa v:count?
    keys = {
      --         require("trouble").toggle({ mode = "diagnostics", focus = false, filter = { buf = 0 } })
      { '<leader>xX', function() require('trouble').toggle({ mode = 'diagnostics' }) end, desc = 'Diagnostics' },
      { '<leader>xx', function() require('trouble').toggle({ mode = 'diagnostics_buffer' }) end, desc = 'Buffer Diagnostics' },
      { '<leader>x?', function() vim.cmd.Trouble() end, desc = 'Trouble' },
      -- { "<leader>xr", function() require("trouble").refresh({auto = true, mode = "diagnostics"}) end, desc="Refresh the active list" },
      { '<leader>xs', function() require('trouble').toggle({ mode = 'symbols' }) end, desc = 'Symbols' },
      -- { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
      { '<leader>xL', function() require('trouble').toggle({ mode = 'lsp' }) end, desc = 'LSP' },
      -- { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)" },
      { '<leader>xl', function() require('trouble').toggle({ mode = 'loclist' }) end, desc = 'Loclist' },
      { '<leader>xq', function() require('trouble').toggle({ mode = 'quickfix' }) end, desc = 'Quickfix' },

      -- maybe <leader>lxr?
      { '<leader>xgr', function() require('trouble').open('lsp_references') end, desc = 'References' },
      { '<leader>xgd', function() require('trouble').open('lsp_definitions') end, desc = 'Definitions' },
      { '<leader>xgy', function() require('trouble').open('lsp_type_definitions') end, desc = 'Definitions' },

      -- Use <leader>{j,k,J,K} (same as lsp)
      -- TODO: usa n e N (better-n/demicolon)
      -- TODO: usa H e L (like file manager/vim-dadbod-ui mapping)
      { '<leader>j', function() require('trouble').next({ skip_groups = true, jump = true }) end, desc = 'Jump to the next item, skipping the groups', ft = 'Trouble' },
      { '<leader>k', function() require('trouble').previous({ skip_groups = true, jump = true }) end, desc = 'Jump to the previous item, skipping the groups', ft = 'Trouble' },
      { '<leader>J', function() require('trouble').last({ skip_groups = true, jump = true }) end, desc = 'Jump to the last item, skipping the groups', ft = 'Trouble' },
      { '<leader>K', function() require('trouble').first({ skip_groups = true, jump = true }) end, desc = 'Jump to the first item, skipping the groups', ft = 'Trouble' },
    },
  }
