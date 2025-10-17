return {
  'sudo-tee/opencode.nvim',
  opts = {
    keymap = {
      input_window = {
        ['<c-p>'] = { 'prev_prompt_history', mode = { 'i' } }, -- Navigate to previous prompt in history
        ['<c-n>'] = { 'next_prompt_history', mode = { 'i' } }, --
      },
    },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'saghen/blink.cmp',
    'folke/snacks.nvim',
  },
}
