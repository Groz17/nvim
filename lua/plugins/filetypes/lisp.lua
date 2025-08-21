-- https://github.com/eraserhd/parinfer-rust (https://github.com/clojure-vim/nvim-parinfer.js?tab=readme-ov-file)
local lisp_ft = { 'clojure', 'scheme', 'lisp', 'timl', 'racket', 'hy', 'fennel', 'janet', 'carp', 'wast', 'yuck' }
return {

  -- maybe disable autopairs here?
  {
    'gpanders/nvim-parinfer',
    -- ft = vim.api.nvim_eval([[getcompletion('','filetype')->filter('v:val=~"lisp"')]]),
    ft = lisp_ft,
    cond=false,
  },

  {
    -- cool that you can use shift to press ( and )
    -- TODO: add next, last for these text-objects...
    'tpope/vim-sexp-mappings-for-regular-people',
    dependencies = {
      'guns/vim-sexp',
      cond=false,
      init = function()
        -- Toggle this for vim-sexp to not go into insert mode after wrapping something
        vim.g.sexp_insert_after_wrap = 0
        -- Toggle this to disable automatically creating closing brackets and quotes
        vim.g.sexp_enable_insert_mode_mappings = 1
      end,
    },
    ft = lisp_ft,
    -- ft = 'lisp',
  },
}
