return {
  'snacks.nvim',
  -- i think the mappings clash with mini's?
  -- opts = {
  --   scope = {}
  -- },
  keys = {
    ---@see https://www.reddit.com/r/neovim/comments/1i8eyyq/remove_outer_indentation_with_miniindentscope/
    -- simile a deleft.vim (create opposite mapping?)
    -- would be nice to use cH and create multicursor for the opposite ends
    {
      'h',
      mode = 'o',
      desc = 'Move outer indentation',
      function()
        local operator = vim.v.operator
        if operator == 'd' then
          local scope = require('snacks').scope.get()
          local top = scope.from
          local bottom = scope.to
          local row, col = unpack(vim.api.nvim_win_get_cursor(0))
          local move = ''
          if row == bottom then
            move = 'k'
          elseif row == top then
            move = 'j'
          end
          local ns = vim.api.nvim_create_namespace('border')
          vim.api.nvim_buf_add_highlight(0, ns, 'Substitute', top - 1, 0, -1)
          vim.api.nvim_buf_add_highlight(0, ns, 'Substitute', bottom - 1, 0, -1)
          vim.defer_fn(function()
            vim.api.nvim_buf_set_text(0, top - 1, 0, top - 1, -1, {})
            vim.api.nvim_buf_set_text(0, bottom - 1, 0, bottom - 1, -1, {})
            vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
          end, 150)
          return '<esc>' .. move
        else
          return 'o'
        end
      end,
      { expr = true },
    },
  },
}
