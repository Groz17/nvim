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
    -- nnoremap <Leader>idf :DiffviewFileHistory %<CR>
    init = function() vim.opt.fillchars:append({ diff = '╱' }) end,
    keys = {
      { '<f14>=', '<cmd>DiffviewOpen -- %<cr>', desc = 'Open Diffview' },
      { '<f14>D', '<cmd>DiffviewOpen<cr>', desc = 'Open Diffview' },

      -- { '<f14>=', '<cmd>DiffviewFileHistory %<cr>', desc = 'Git log' },
      -- { '<f14>D', '<cmd>DiffviewFileHistory<cr>', desc = 'Git log (args)' },
      { '<leader>dl', ':DiffviewFileHistory<CR>', mode="x", desc = 'Git log' },

      { 'q', '<cmd>DiffviewClose<cr>', ft = {"DiffviewFiles", "DiffviewFileHistory"}, desc = 'Close Diffview' },

      -- { '<leader>dd', '<cmd>DiffviewToggleFiles<cr>', desc = 'Toggle file panel' },
      -- { '<leader>dd', '<cmd>DiffviewFocusFiles<cr>', desc = 'Focus file panel' },
      -- { '<leader>dr', '<cmd>DiffviewRefresh<cr>', desc = 'Refresh file list' },
      -- { '<leader>dd', '<cmd>DiffviewLog<cr>', desc = 'Debug log' },
    },
    -- keys = {
    --   { '<Leader>ds', '<Cmd>DiffviewOpen --staged<CR>', desc = 'Open staged' },
    --
    --   { '<Leader>da', ':DiffviewFileHistory % --author=', desc = 'File commits (author)' },
    --   { '<Leader>dm', ':DiffviewFileHistory % --grep=', desc = 'File commits (log message)' },
    --   { '<Leader>dl', '<Cmd>DiffviewFileHistory % --base=LOCAL<CR>', desc = 'File commits (compare to local)' },
    --   { '<Leader>dr', ':DiffviewFileHistory -L,:<Left><Left>', desc = 'File commits (range)' },
    --   -- { '<Leader>df', ':DiffviewFileHistory -L::<Left>', desc='File commits (func)' },
    --
    --   -- { '<leader>gf', '<cmd>DiffviewFileHistory --follow %<cr>', desc = 'Open File history' },
    --   -- { '<leader>gf', "<Esc><Cmd>'<,'>DiffviewFileHistory --follow<CR>", desc = 'Range history', mode = 'v' },
    --   -- { '<leader>gF', '<Cmd>.DiffviewFileHistory --follow<CR>', desc = 'Line history' },
    --
    --   { '<Leader>dA', ':DiffviewFileHistory --author=', desc = 'All commits (author)' },
    --   { '<Leader>dM', ':DiffviewFileHistory --grep=', desc = 'All commits (log message)' },
    --   { '<Leader>dL', '<Cmd>DiffviewFileHistory --base=LOCAL<CR>', desc = 'All commits (compare to local)' },
    --   { '<Leader>dY', '<Cmd>DiffviewFileHistory --merges<CR>', desc = 'All commits (merge)' },
    --   { '<Leader>dy', '<Cmd>DiffviewFileHistory --no-merges<CR>', desc = 'All commits (no merge)' },
    -- },
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
