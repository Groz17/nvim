return {
  'Zeioth/compiler.nvim',
  cmd = { 'CompilerOpen', 'CompilerToggleResults', 'CompilerRedo' },
  dependencies = {
    'stevearc/overseer.nvim',
  },
  opts = {},
  keys = {
    {
      '<c-c><c-c>',
      function()
        require('compiler.utils')
          .require_language(vim.bo.filetype)
          .action('option' .. vim.v.count1)
      end,
      desc = 'Open compiler',
      ft = { 'asm', 'c', 'cpp', 'cs', 'dart', 'elixir', 'fortran', 'fsharp', 'gleam', 'go', 'java', 'javascript', 'kotlin', 'lua', 'make', 'perl', 'python', 'r', 'ruby', 'rust', 'sh', 'swift', 'typescript', 'vb', 'zig' },
    },
  },
}
