-- maybe remove for context treesitter-like plugin?
return {
  {
    -- how to automatically indent in insert mode?
    'nmac427/guess-indent.nvim',
    opts = {
      buftype_exclude = {  -- A list of buffer types for which the auto command gets disabled
        "text"
      },
    },
  },
}
