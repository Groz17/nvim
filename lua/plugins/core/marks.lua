-- https://github.com/EvWilson/spelunk.nvim
-- https://www.reddit.com/r/neovim/comments/1hbflzy/spelunknvim_stackbased_bookmark_manager_seeking/
--https://github.com/LeonHeidelbach/trailblazer.nvim
return {
  -- it removes the signcolum for lsp tho... FIX:?
  -- take inspiration for mappings: https://github.com/kshenoy/vim-signature https://github.com/MattesGroeger/vim-bookmarks
  'chentoast/marks.nvim',
  cond = false,
  keys = {
    keys = { 'm', '<Plug>(Marks-set)', '<Plug>(Marks-toggle)' },
    -- { 'm', 'dm' },
  },
  opts = {
    builtin_marks = { ".", "<", ">", "^" },

    excluded_filetypes = { "NeogitStatus", "NeogitCommitMessage", "toggleterm" },
    mappings = {
      annotate = 'm?'
      -- annotate = 'm@'
    },

        bookmark_1 = {
          sign = "", -- bookmark
          virt_text = "",
          annotate = false
        },
        bookmark_2 = {
          sign = "", -- heart
          virt_text = "",
          annotate = false
        },
  },
  config = function(_,opts)
    require'marks'.setup(opts)
    vim.keymap.set('n', 'm/', '<cmd>MarksListAll<CR>')
  end
}
