return {
  'Zeioth/compiler.nvim',
  cmd = { 'CompilerOpen', 'CompilerToggleResults', 'CompilerRedo' },
  dependencies = {
    'stevearc/overseer.nvim',
  },
  opts = {},
  keys = {
    {
      mode = { "i", "n" },
      '<f15><c-e>', -- slime?
      function()
        if vim.bo.filetype == "" then
          vim.notify("Buffer has no filetype", vim.log.levels.ERROR)
          return
        end
        if not Snacks.git.get_root() then vim.cmd.lcd(vim.fn.expand("%:h")) end
        require('compiler.utils').require_language(vim.bo.filetype).action('option' .. vim.v.count1)
      end,
      desc = 'Open compiler',
    },
  },
}
