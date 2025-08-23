-- Allows folding all unchanged text. Provides fold text showing whether folded lines have been changed. (https://github.com/airblade/vim-gitgutter)
-- è possibile reperire il prefisso which-key di Git così se devo cambiarlo lo cambio solo nella spec di which-key (stessa cosa per lsp) (concatena con le altre 2 lettere...)
-- if you edit a buffer created by :Gitsigns diffthis you can save/write it to stage changes; Fwiw fugitive allows you to do that too. (https://github.com/lewis6991/gitsigns.nvim/issues/421)
return {
  -- how to ignore whitespaces in git diff?

  -- how to sign warnings and gitsigns signs on the same line?
  -- https://github.com/chrisbra/changesPlugin
  -- :Git -> Gitsigns (:echo fullcommand('Git'))

  -- Integration with fugitive: When viewing revisions of a file (via :0Gclog for example), Gitsigns will attach to the fugitive buffer with the base set to the commit immediately before the commit of that revision. This means the signs placed in the buffer reflect the changes introduced by that revision of the file.
  -- Usa <leader>gs come mapping per gitsigns.nvim?
  -- TODO: fold like git gutter???
  -- make it work with diffview...
  'lewis6991/gitsigns.nvim',
  -- cond = function() vim.fn.system 'git rev-parse --is-inside-work-tree' if vim.v.shell_error == 0 then return true end return false end,
    -- Unfortunate that fugitive and gitsigns have the same command (would be nicer if gitsigns add like a :GS command or smth)
    -- vim.cmd.delcommand('Gitsigns')
  -- lazy = false,
  event = { 'BufReadPre', 'BufNewFile' },
  keys = function()
    local gitsigns = require('gitsigns')
    return {
      -- ╭─────────────────────────────────────────────────────────╮
      -- │ Navigation                                              │
      -- ╰─────────────────────────────────────────────────────────╯
      -- use demicolon.nvim
      -- TODO: go to next/previous file with unstaged changes with [G,]G???
      { "]g", function()gitsigns.nav_hunk('next')end, desc="Next Hunk", mode = {"n","x","o"}},
      { "]G", function()gitsigns.nav_hunk('last')end, desc="Last Hunk", mode = {"n","x","o"}},
      { "[g", function()gitsigns.nav_hunk('prev') end,  desc="Prev Hunk", mode = {"n","x","o"}},
      { "[G", function()gitsigns.nav_hunk('first')end,  desc="First Hunk", mode = {"n","x","o"}},

      -- ╭─────────────────────────────────────────────────────────╮
      -- │ Actions                                                 │
      -- ╰─────────────────────────────────────────────────────────╯
      -- Most actions can be repeated with `.` if you have |vim-repeat| installed.

      -- maybe use <leader>{h,H}?
      { '<leader>g', '<nop>', desc='Gitsigns' },

      -- would be cool if lazy's keys spec supported which-key's style
      -- { '<leader>gu', gitsigns.undo_stage_hunk, 'Undo Stage Hunk' } W Deprecated.(use |gitsigns.stage_hunk()| on staged signs)
      { '<leader>gs', gitsigns.stage_hunk, desc='Stage Hunk' },
      {mode='x', '<leader>gs', function() gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, desc='Stage Hunk'},
      { '<leader>gu', gitsigns.reset_hunk, desc='Unstage Hunk' },
      {mode='x', '<leader>gu', function() gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end,desc='Unstage Hunk'},

      { '<leader>gS', gitsigns.stage_buffer, desc='Stage Buffer' },
      { '<leader>gU', gitsigns.reset_buffer, desc='Reset Buffer' },
      -- gK for hover would have been nice as well
      { '<leader>gp', gitsigns.preview_hunk, desc='Preview Hunk' },
      -- { '<leader>gi',  function() require("gitsigns").preview_hunk_inline({ inline = true }) end }
      { '<leader>gP', function() gitsigns.preview_hunk_inline() end, desc='Preview Hunk Inline' },

      -- If already open, calling this will cause the window to get focus.
      { '<leader>gb', function() gitsigns.blame_line() end, desc='Blame Hunk' },
      { '<leader>gB', function() gitsigns.blame_line({ full = true, ignore_whitespace = true }) end, desc='Blame Hunk (full commit message + ignore whitespaces)' },

      { '<leader>gd', gitsigns.diffthis, desc='Diff This' },
      -- { '<leader>gD', function() gitsigns.diffthis('~') end, desc='Diff this against last commit' },
      -- { "<leader>gD", function() gitsigns.diffthis("~") end, "Diff this against parent" },

      -- will open Trouble
      -- how to do for all files? use uppercase
      { '<leader>gl', function() gitsigns.setloclist(0,0) end, desc='Populate the location list with hunks.' },
      { '<leader>gq', function() gitsigns.setqflist(0) end, desc='Populate the quickfix list with hunks.' },
      { '<leader>gL', function() gitsigns.setloclist(0,'all') end, desc='Populate the location list with all hunks.' },
      { '<leader>gQ', function() gitsigns.setqflist('all') end, desc='Populate the quickfix list with all hunks.' },

      -- ╭─────────────────────────────────────────────────────────╮
      -- │ Toggles                                                 │
      -- ╰─────────────────────────────────────────────────────────╯
      -- { '<leader>g', '<nop>', desc='Gitsigns' },
      { [[<f13>gb]], function() gitsigns.toggle_current_line_blame() end, desc='Current line blame' },
      { [[<f13>gl]], function() gitsigns.toggle_linehl() end, desc='Line highlight' },
      { [[<f13>gn]], function() gitsigns.toggle_numhl() end, desc='Number highlight' },
      { [[<f13>gs]], function() gitsigns.toggle_signs() end, desc='Sign column' },
      { [[<f13>gw]], function() gitsigns.toggle_word_diff() end, desc='Word diff' },

      -- ╭─────────────────────────────────────────────────────────╮
      -- │ Text object                                             │
      -- ╰─────────────────────────────────────────────────────────╯
      -- make gitgutter hunk text objects work with targets (move to them if you're not on it)
      -- https://github.com/chrisgrieser/.config/blob/71ce6da1e4ec9214662c74e12afd2125cbd91ba6/nvim/lua/config/textobject-keymaps.lua#L80
      -- uso g per git hunk e h per diff hunk, makes more sense
      -- so i can i use ih for orgmode header
      { mode = { 'o', 'x' }, 'ig', ':<C-U>Gitsigns select_hunk<CR>', desc='Git Hunk' },
      -- No distinction between ig and ag? maybe delete trailing whitespace with ig?
      { mode = { 'o', 'x' }, 'ag', ':<C-U>Gitsigns select_hunk<CR>', desc='Git Hunk' },
      -- integrate with mini.ai
      -- { mode = { 'o', 'x' }, 'gh', ':<C-U>Gitsigns select_hunk<CR>', desc='Git Hunk' },
    }
  end,
  opts = {
    trouble = false,
    signs = {
      -- add = { hl = "DiffAdd", text = "│", numhl = "GitSignsAddNr" },
      -- change = { hl = "DiffChange", text = "│", numhl = "GitSignsChangeNr" },
      -- -- Find configs that have this line, they must be good
      -- delete = { hl = "DiffDelete", text = "", numhl = "GitSignsDeleteNr" },
      -- topdelete = { hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr" },
      -- changedelete = { hl = "DiffChangeDelete", text = "⇋", numhl = "GitSignsChangeNr" },

      -- add = { hl = "DiffAdd", text = "│", numhl = "GitSignsAddNr" },
      -- change = { hl = "DiffChange", text = "│", numhl = "GitSignsChangeNr" },
      -- -- Find configs that have this line, they must be good
      -- delete = { hl = "DiffDelete", text = "", numhl = "GitSignsDeleteNr" },
      -- topdelete = { hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr" },
      -- changedelete = { hl = "DiffChangeDelete", text = "⇋", numhl = "GitSignsChangeNr" },
    },
    -- Information already coded in the line number (so LSP/todo-comments can work better)
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  },
}
