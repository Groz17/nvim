-- https://github.com/milanglacier/minuet-ai.nvim
-- https://www.reddit.com/r/neovim/comments/1gypmjt/from_emacs_to_nvimaider_my_first_lua_plugin/
-- https://github.com/Davidyz/VectorCode
return {
  'GeorgesAlkhouri/nvim-aider',
  cmd = { 'AiderTerminalToggle', 'AiderHealth' },
  keys = {
    { '<leader>A/', '<cmd>AiderTerminalToggle<cr>',    desc = 'Open Aider' },
    { '<leader>As', '<cmd>AiderTerminalSend<cr>',      desc = 'Send to Aider', mode = { 'n', 'x' } },
    { '<leader>Ac', '<cmd>AiderQuickSendCommand<cr>',  desc = 'Send Command To Aider' },
    { '<leader>Ab', '<cmd>AiderQuickSendBuffer<cr>',   desc = 'Send Buffer To Aider' },
    { '<leader>A+', '<cmd>AiderQuickAddFile<cr>',      desc = 'Add File to Aider' },
    { '<leader>A-', '<cmd>AiderQuickDropFile<cr>',     desc = 'Drop File from Aider' },
    { '<leader>Ar', '<cmd>AiderQuickReadOnlyFile<cr>', desc = 'Add File as Read-Only' },
    -- Example nvim-tree.lua integration if needed
    -- { "<leader>a+", "<cmd>AiderTreeAddFile<cr>",    desc = "Add File from Tree to Aider", ft = "NvimTree" },
    -- { "<leader>a-", "<cmd>AiderTreeDropFile<cr>",   desc = "Drop File from Tree from Aider", ft = "NvimTree" },
  },
  dependencies = {
    'folke/snacks.nvim',
    --- The below dependencies are optional
    -- mini.files???
  },
  config = true,
}
