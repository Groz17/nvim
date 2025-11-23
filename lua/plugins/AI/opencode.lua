return {
  'sudo-tee/opencode.nvim',
  keys = {
    {'<leader>og'},
    {'<leader>oi'},
    {'<leader>oI'},
  },
  opts = {
    keymap = {
      input_window = {
        ['<c-p>'] = { 'prev_prompt_history', mode = { 'i' } }, -- Navigate to previous prompt in history
        ['<c-n>'] = { 'next_prompt_history', mode = { 'i' } }, -- Navigate to next prompt in history
        ['<tab>'] = { 'switch_mode', mode = { 'n', 'i' } }, -- Switch between modes (build/plan)
        ['<c-s-v>'] = { 'paste_image', mode = { 'n', 'i' } }, -- Paste image from the clipboard
      },
    },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'saghen/blink.cmp',
    'folke/snacks.nvim',
  },
}
