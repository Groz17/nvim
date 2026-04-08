return {
  'sudo-tee/opencode.nvim',
  init = function()
    require('which-key').add({
      mode = { 'n', 'x' },
      '<leader>o',
      group = 'Opencode 🤖'
    })
  end,
  keys = {
    { '<leader>og', desc = 'Toggle Opencode window' },
    { '<leader>oi', desc = 'Open input window' },
    { '<leader>oI', desc = 'Open input (new session)' },
    { '<leader>oh', desc = 'Select from history' },
    { '<leader>oo', desc = 'Open output window' },
    { '<leader>ot', desc = 'Toggle focus' },
    { '<leader>oT', desc = 'Session timeline' },
    { '<leader>oq', desc = 'Close Opencode window' },
    { '<leader>os', desc = 'Select session' },
    { '<leader>oR', desc = 'Rename session' },
    { '<leader>op', desc = 'Configure provider' },
    { '<leader>oV', desc = 'Configure model variant' },
    { '<leader>oy', mode = { 'x' }, desc = 'Add visual selection to context' },
    { '<leader>oY', mode = { 'x' }, desc = 'Insert visual selection inline into input' },
    { '<leader>oz', desc = 'Toggle zoom' },
    { '<leader>ov', desc = 'Paste image from clipboard' },
    { '<leader>od', desc = 'Open diff view' },
    { '<leader>o]', desc = 'Next diff' },
    { '<leader>o[', desc = 'Previous diff' },
    { '<leader>oc', desc = 'Close diff view' },
    { '<leader>ora', desc = 'Revert all (last prompt)' },
    { '<leader>ort', desc = 'Revert this (last prompt)' },
    { '<leader>orA', desc = 'Revert all changes' },
    { '<leader>orT', desc = 'Revert this change' },
    { '<leader>orr', desc = 'Restore file snapshot' },
    { '<leader>orR', desc = 'Restore all snapshots' },
    { '<leader>ox', desc = 'Swap window position' },
    { '<leader>otr', desc = 'Toggle reasoning output' },
    { '<leader>ott', desc = 'Toggle tool output' },
    { '<leader>o/', mode = { 'n', 'x' }, desc = 'Quick chat with current context' },
  },
  opts = {
    keymap = {
      input_window = {
        ['<c-p>'] = { 'prev_prompt_history', mode = { 'i' } }, -- Navigate to previous prompt in history
        ['<c-n>'] = { 'next_prompt_history', mode = { 'i' } }, -- Navigate to next prompt in history
        ['<tab>'] = { 'switch_mode', mode = { 'n', 'i' } }, -- Switch between modes (build/plan)
      },
    },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'saghen/blink.cmp',
    'folke/snacks.nvim',
  },
}
