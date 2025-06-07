-- https://github.com/kana/vim-gf-diff
-- https://gitlab.com/mcepl/vim-diff_navigator
-- http://www.vim.org/scripts/script.php?script_id=2361

-- magari mettila nella setup?
local dirs = {}
return {
  {
    -- would be cool to use a preprocess command, like gcc -E
    'will133/vim-dirdiff',
    cmd = 'DirDiff',
    keys = {
      -- d.. no option (full stop); d.x -> option mapping, like d.w -> don't consider whitespace
      { 'd.', ':DirDiff<space>' },
      -- m for mark
      {
        'dm',
        function()
          table.insert(dirs, vim.fn.expand('%:p:h'))
          if #dirs == 2 then
            vim.cmd('DirDiff', dirs)
            dirs = {}
          end
        end,
      },
    },
  },
  {
    -- use in combination with diff -r or git diff --no-index
    'junkblocker/patchreview-vim',
    -- cond = false,
    init = function()
      vim.g.patchreview_disable_syntax = 0
      -- vim.g.patchreview_patch = '/usr/bin/wiggle'
    end,
    -- keys = {
    --   { '<leader>pr', '<cmd>PatchReview %', desc = 'Perform a patch review in the current directory' },
    --   { '<leader>pR', '<cmd>ReversePatchReview %', desc = 'Perform a reverse patch review of an already applied patch in the current directory' },
    -- },
    cmd = {
      --             T = {":DiffReview git staged --no-color -U5<CR>", "git: Review staged changes in tabs"},
      'DiffReview',
      'PatchReview',
      'ReversePatchReview',
    },
  },
  {
    -- https://github.com/search?q=%3CPlug%3E%28textobj-diff-file-n%29&type=code
    "kana/vim-textobj-diff",
    dependencies = "kana/vim-textobj-user",
    init = function()
      vim.g.textobj_diff_no_default_key_mappings = 1
    end,
    -- ft = 'diff',
    keys = {
      -- have to use it on all mappings (FIX: )
      -- ft = {'git','diff'}, ??? global ft plxxx
      -- {],[}{d,D} have to with macros, so we can disable them in diff filetypes. nevermind, extend unimpaired mappings
      -- It kinda works also with ft=git for Git ++curwin diff or git -p diff (fugitive)
      { mode = { 'n', 'x', 'o' }, ']d', '<Plug>(textobj-diff-file-n)', ft = { 'git', 'diff' }, desc = 'Move to the beginning of the next header of files' },
      { mode = { 'n', 'x', 'o' }, '[d', '<Plug>(textobj-diff-file-p)', ft = { 'git', 'diff' }, desc = 'Move to the beginning of the previous header of files' },
      { mode = { 'n', 'x', 'o' }, ']D', '<Plug>(textobj-diff-file-N)', ft = { 'git', 'diff' }, desc = 'Move to the end of the next header of files' },
      { mode = { 'n', 'x', 'o' }, '[D', '<Plug>(textobj-diff-file-P)', ft = { 'git', 'diff' }, desc = 'Move to the end of the previous header of files' },
      { mode = { 'n', 'x', 'o' }, ']h', '<Plug>(textobj-diff-hunk-n)', ft = { 'git', 'diff' }, desc = 'Move to the beginning of the next hunk' },
      { mode = { 'n', 'x', 'o' }, '[h', '<Plug>(textobj-diff-hunk-p)', ft = { 'git', 'diff' }, desc = 'Move to the beginning of the previous hunk' },
      { mode = { 'n', 'x', 'o' }, ']H', '<Plug>(textobj-diff-hunk-N)', ft = { 'git', 'diff' }, desc = 'Move to the end of the next hunk' },
      { mode = { 'n', 'x', 'o' }, '[H', '<Plug>(textobj-diff-hunk-P)', ft = { 'git', 'diff' }, desc = 'Move to the end of the previous hunk' },
      -- no diagnostic/@conditional here :p
      -- make these work with mini.ai (mini.ai should have an api for external text objects) for next/last
      { mode = { 'x', 'o' }, 'ad', '<Plug>(textobj-diff-file)', ft = { 'git', 'diff' }, desc = 'Select all hunks and the header of the next/previous files' },
      { mode = { 'x', 'o' }, 'id', '<Plug>(textobj-diff-file)', ft = { 'git', 'diff' }, desc = 'Select all hunks and the header of the next/previous files' },
      -- would be cool if this ignored the initial header (should start from @@ line) (to include them use ad and id to exclude trailing whitespace)
      { mode = { 'x', 'o' }, 'ah', '<Plug>(textobj-diff-file)', ft = { 'git', 'diff' }, desc = 'Select all hunks and the header of the next/previous files' },
      { mode = { 'x', 'o' }, 'ih', '<Plug>(textobj-diff-hunk)', ft = { 'git', 'diff' }, desc = 'Select the next/previous hunk' },
    },
  },

}

-- install patch text object + motion go to next patch
-- usa iH e aH che mirrorano quelli di gitsigns (h sta per hunk)
--
--https://github.com/rickhowe/spotdiff.vim
--https://github.com/rickhowe/diffchar.vim
