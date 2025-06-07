return {
  'miroshQa/debugmaster.nvim',
  cond=false,
  dependencies = { 'mfussenegger/nvim-dap' },
  config = function()
    local dm = require('debugmaster')
    -- make sure you don't have any other keymaps that starts with "<leader>d" to avoid delay
    vim.keymap.set({ 'n' }, '<f12>m', dm.mode.toggle, { nowait = true })
    -- If you want to disable debug mode in addition to leader+d using the Escape key:
    vim.keymap.set('n', '<Esc>', dm.mode.disable)
    -- This might be unwanted if you already use Esc for ":noh"
    vim.keymap.set('t', '<C-/>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
  end,
}
