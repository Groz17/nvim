return
  {
    -- x = { '<cmd>DiffviewOpen --base=LOCAL<cr>', 'Open diffview against local changes' },
    -- f = { '<cmd>DiffviewFileHistory --base=LOCAL %<cr>', 'Get see history of current file' },
    -- c = { '<cmd>DiffviewOpen <C-r><C-w><cr>', 'Open diff between HEAD and commit under cursor' },

    -- https://github.com/sindrets/diffview.nvim/issues/286
    -- can it diff branches?
    -- create command alias d?
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles', 'DiffviewRefresh', 'DiffviewLog' },

    -- nnoremap <Leader>idd :<C-u>call feedkeys(':DiffviewOpen<Space><Tab>','t')<CR>
    init = function() vim.opt.fillchars:append({ diff = '╱' }) end,
    -- t stands for difftool
    keys = {
      -- { '<leader>gt', '<cmd>DiffviewOpen -- %<cr>', desc = 'Open Diffview' },
      -- { '<leader>gT', '<cmd>DiffviewOpen<cr>', desc = 'Open Diffview' },
      { '<leader>gD', '<cmd>DiffviewOpen<cr>', desc = 'Open Diffview' },

      { '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', desc = 'Git log' },
      { '<leader>gH', '<cmd>DiffviewFileHistory<cr>', desc = 'Git log (args)' },
      { '<leader>gh', ':DiffviewFileHistory<CR>', mode="x", desc = 'Git log' },

      { 'q', '<cmd>DiffviewClose<cr>', ft = {"DiffviewFiles", "DiffviewFileHistory"}, desc = 'Close Diffview' },

      -- { '<leader>dd', '<cmd>DiffviewToggleFiles<cr>', desc = 'Toggle file panel' },
      -- { '<leader>dd', '<cmd>DiffviewFocusFiles<cr>', desc = 'Focus file panel' },
      -- { '<leader>dr', '<cmd>DiffviewRefresh<cr>', desc = 'Refresh file list' },
      -- { '<leader>dd', '<cmd>DiffviewLog<cr>', desc = 'Debug log' },
    },
    opts = function()
      -- local action = require 'diffview.actions'
      local actions = require('diffview.config').actions
      return {
        enhanced_diff_hl = true, -- See ':h diffview-config-enhanced_diff_hl'
        -- default_args = {
        --     DiffviewOpen = { "--imply-local" },
        -- },
      use_icons = true,
      view = {
        default = {
          layout = 'diff2_horizontal',
        },},
        keymaps = {
          -- https://github.com/MagicDuck/dotfiles/blob/f3d1faa4e0956d40c8494946b114687793364c85/.config/nvim/lua/my/plugins/git.lua
          file_panel = {
            -- ['k'] = action.next_entry,
            -- ['i'] = action.prev_entry,
            ['<leader><leader>'] = actions.listing_style,
            ['<C-j>'] = actions.select_next_entry,
            ['<C-k>'] = actions.select_prev_entry,
            ['[x'] = actions.prev_conflict,
            [']x'] = actions.next_conflict,
            -- TODO: normal! ]cdo will put the next diff in the index buffer. Then use write! to write it out
          },
          view = {
            -- The `view` bindings are active in the diff buffers, only when the current
            -- tabpage is a Diffview.
            ['<C-j>'] = actions.select_next_entry, -- Open the diff for the next file
            ['<C-k>'] = actions.select_prev_entry, -- Open the diff for the previous file
          },
          file_history_panel = {
            ['<C-j>'] = actions.select_next_entry,
            ['<C-k>'] = actions.select_prev_entry,
          },
        },
      }
    end,
  }
