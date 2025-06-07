-- doesn' seem to accept v:count??
-- usa <s-a-i> to split e <c-a-i> to vertical split (mappings inspired by vimwiki) (mnemonic: shift for split, which by default is horizontal), another: <c-s-i> to new tab
return {
  "kwkarlwang/bufjump.nvim",
  -- impara a usare ctrl-^
  cond=false,
  keys = {

    { "<M-o>",        [[<CMD>lua require('bufjump').backward()<cr>]] },
    { "<M-i>",        [[<CMD>lua require('bufjump').forward()<cr>]] },
    -- Horizontal split
    { "<s-M-o>",      [[<CMD>sp +lua\ require('bufjump').backward()<cr>]] },
    { "<s-M-i>",      [[<CMD>sp +lua\ require('bufjump').forward()<cr>]] },
    -- Vertical split
    { "<c-M-o>",      [[<CMD>vert sp +lua\ require('bufjump').backward()<cr>]] },
    { "<c-M-i>",      [[<CMD>vert sp +lua\ require('bufjump').forward()<cr>]] },
    -- New Tab
    -- Doesn't seem to work, but who cares
    -- { "<c-s-M-o>", [[<CMD>tab sp +lua\ require('bufjump').backward()<cr>]] },
    -- { "<c-s-M-i>", [[<CMD>tab sp +lua\ require('bufjump').forward()<cr>]] },
    -- This works
    { "<c-s-o>",      [[<CMD>tab sp +lua\ require('bufjump').backward()<cr>]] },
    { "<c-s-i>",      [[<CMD>tab sp +lua\ require('bufjump').forward()<cr>]] },
  },
  config = function()
    -- https://github.com/lambdalisue/vim-fern/issues/510
    -- vim.bo.bufhidden = 'hide'
    require("bufjump").setup({
      forward_key = "<a-i>",
      -- <c-i>?
      -- TODO: also add function for same_buf
      -- forward_same_buf_key = "<a-i>",
      backward_key = "<a-o>",
      -- backward_same_buf_key = "<a-o>",
      on_success = function()
        vim.cmd.norm('g`zz')
      end,
    })
  end,
}
