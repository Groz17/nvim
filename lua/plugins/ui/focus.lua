return {
  -- {
  --   -- sarebbe bello se zen avesse le stesse features di nrrwrgn
  --
  --   -- maybe show file manager on the side and minimap on the other?
  --   -- how to enable only if there's only one buffer?
  --   'folke/zen-mode.nvim',
  --   opts = {
  --     plugins = {
  --       -- to make this work, you need to set the following kitty options:
  --       -- - allow_remote_control socket-only
  --       -- - listen_on unix:/tmp/kitty
  --       kitty = {
  --         enabled = true,
  --         font = '+20',
  --       },
  --       -- tmux = { enabled = vim.env.TMUX ~= nil },
  --     },
  --     on_close = function()
  --       -- vim.cmd([[
  --       -- bufname('')=~'^NrrwRgn' (from the plugin's source code)
  --       --   if bufname('')=~'^NrrwRgn_diff_\d\+$' | quit | endif
  --       -- ]])
  --       -- vim.cmd 'q'
  --     end,
  --   },
  --   cmd = 'ZenMode',
  --   keys = {
  --     { 'ZM', '<CMD>ZenMode<CR>', desc = 'Zen Mode' },
  --     { '<c-w>O', '<CMD>ZenMode<CR>', desc = 'Zen Mode' },
  --   },
  -- },
  -- {
  --   -- does this work with treesitter?
  --   'folke/twilight.nvim',
  --   opts = {},
  --   keys = {
  --     { '<leader><c-l>', '<CMD>Twilight<cr>', desc = 'Dim Inactive Code' },
  --   },
  -- },
  {
    -- " usa VMRegionsToBuffer (vim-visual-multi) al posto di questo plugin
    -- Implementa comando linediff (https://github.com/AndrewRadev/linediff.vim)
    -- Puoi usare folke/zen-mode.nvim dopo aver scelto la regione
    'chrisbra/NrrwRgn',
    init = function()
      vim.g.nrrw_rgn_vert = 1
      vim.g.nrrw_rgn_wdth = 107
      vim.g.nrrw_topbot_leftright = 'botright'
      -- Use several independent narrowed regions of the same buffer that you want to write at the same time. This can be useful if you diff different regions of the same file, and want to be able to put back the changes at different positions.
      vim.g.nrrw_rgn_protect = 'n'
      -- FIX: Doesn't work in Neovim :(
      vim.g.nrrw_rgn_update_orig_win = 1
      vim.g.nrrw_rgn_nomap_nr = 1
      vim.g.nrrw_rgn_nomap_Nr = 1

      -- vim.g.nrrw_custom_options={}
      -- vim.g.nrrw_custom_options['filetype'] = vim.fn.getbufvar('#', '&filetype')
      -- vim.b.nrrw_aucmd_create = "let &filetype=getbufvar('#', '&filetype')"

      -- vim.g.nrrw_rgn_hl = 'MultiCursor'

      -- doesn't work well with diff command/mapping
      -- vim.cmd [[
      --   augroup nrrw_rgn_init
      --   autocmd!
      --   autocmd FileType * let b:nrrw_aucmd_create = "ZenMode"
      --   augroup end
      --   ]]
    end,
    -- would be nice to give description to those and when you type them in the command-line a popup would show up with it
    config = function()
      -- This lets you select a region, call :NN sql and the selected region will get the sql filetype set. (maybe use treesitter filetype function?)
      vim.cmd([[
        command! -nargs=* -bang -range -complete=filetype NN
        \ :<line1>,<line2> call nrrwrgn#NrrwRgn('',<q-bang>)
        \ | set filetype=<args>
        ]])
    end,
    cmd = {
      'NN', -- Have the filetype in the narrowed window set
      'NR', -- Open the selected region in a new narrowed window
      'NW', -- Open the current visual window in a new narrowed window
      'WR', -- (In the narrowed window) write the changes back to the original buffer.
      'NRV', -- Open the narrowed window for the region that was last visually selected.
      'NUD', -- (In a unified diff) open the selected diff in 2 Narrowed windows
      'NRP', -- Mark a region for a Multi narrowed window
      'NRM', -- Create a new Multi narrowed window (after 'NRP') - experimental!
      'NRS', -- Enable Syncing the buffer content back (default on)
      'NRN', -- Disable Syncing the buffer content back
      'NRL', -- Reselect the last selected region and open it again in a narrowed window
    },
    keys = {
      { mode = { 'x' }, '<f12>nn', '<Plug>NrrwrgnDo', desc = 'Narrowed Window' },
      { mode = { 'x', 'n' }, 'gz', '<Plug>NrrwrgnDo', desc = 'Narrowed Window' },
      { mode = 'n', 'gzz', '<Plug>NrrwrgnDo_', desc = 'Current line' },
      -- FIX: doesn't work
      { mode = { 'n', 'x' }, 'gZ', '<Plug>NrrwrgnBangDo', desc = 'Narrowed Window (Full Screen)' },
      { mode = 'x', 'Z', '<Plug>NrrwrgnBangDo', desc = 'Narrowed Window (Full Screen)' },
      -- what about eol motion? vim's native gu, gU can't do this (for ex guU), so don't bother
      { 'gZZ', '<Plug>NrrwrgnBangDo_' },
      { 'gzv', '<CMD>NRV<CR>', desc = 'Last selected region' },
      -- if the filetype is not of type diff, assume to create a diff for merge conflicts
      -- NUD can run on vim's fugitive diff
      -- In the window that contains the unified buffer, you can move to a different chunk, run |:NUD| and the 2 Narrowed Windows in diff mode will update.
      -- FIX: add git filetype to check in the plugin's source code
      -- NOTE: fai set ft=diff prima (magari hai &ft=git)... (guarda definizione funzione...)
      { 'gzd', '<CMD>NUD<CR>', --[[ft = { 'git', 'diff' }]] desc = 'View the current chunk in diff-mode' },
      -- Make this for operator as well
      -- s stands for filetype
      -- { "gzs", ":NN<space>", mode={"x"},desc = "Current chunk" },
    },
  },
  {
    -- https://github.com/AndrewRadev/linediff.vim/pull/27
    'AndrewRadev/linediff.vim',
    -- support in-line diffs? like a word in a line?
    cmd = { 'Linediff', 'LinediffReset' },
    keys = {
      -- create operator
      -- dr stands for diff region
      {
        mode = { 'n',--[[ ,"x" ]] }, 'dr', '<Plug>(linediff-operator)',
      },
      -- seems to support dot-repeat
      { mode = { 'n' }, 'drr', '<Plug>(linediff-operator)_' },

      -- diff plus
      -- {
      --   mode = {
      --     'n',--[[ ,"x" ]]
      --   },
      --   'dp',
      --   '<Plug>(linediff-add-operator)',
      -- },
      -- { mode = { 'n' }, 'dpp', '<Plug>(linediff-add-operator)_' },
      --
      -- { mode = { 'n',--[[ ,"x" ]] }, 'dP', '<Plug>(linediff-last-operator)', },
      -- { mode = { 'n' }, 'dPp', '<Plug>(linediff-last-operator)_' },
      -- { mode = { 'n' }, 'dPP', '<Plug>(linediff-last-operator)_' },

      { 'dR', '<CMD>LinediffReset<CR>' },
    },
  },

}
