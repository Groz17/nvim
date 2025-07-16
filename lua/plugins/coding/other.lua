-- Switching between source and header file
-- nnoremap <silent> <A-o> :FSHere<cr>
return {
  'rgroli/other.nvim',
  cond=false,
  main = 'other-nvim',
  keys = {
    -- <s-bs>?
    { '<bs>', '<cmd>Other<CR>' },
    { '<leader>ltn', '<cmd>OtherTabNew<CR>' },
    { '<leader>lp', '<cmd>OtherSplit<CR>' },
    { '<s-bs>', '<cmd>OtherVSplit<CR>' },
    { '<leader>lc', '<cmd>OtherClear<CR>' },
    -- Context specific bindings (use localleader?)
    -- { '<leader>lt', '<cmd>Other test<CR>' },
    -- { '<leader>ls', '<cmd>Other scss<CR>' },
  },
  opts = {
    mappings = {
      'angular',
      'c',
      'rails',
      'golang',
      'laravel',
      'livewire',
      'python',
      'react',
      'rust',
      'elixir'
    },
  },
}
