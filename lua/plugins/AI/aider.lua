-- https://github.com/milanglacier/minuet-ai.nvim
-- https://www.reddit.com/r/neovim/comments/1gypmjt/from_emacs_to_nvimaider_my_first_lua_plugin/
-- https://github.com/Davidyz/VectorCode
return {
  "GeorgesAlkhouri/nvim-aider",
  -- HACK: path differs from bashrc
  init = function()
    vim.env.PATH = vim.env.PATH .. ':~/.local/bin/'
  end,
  cmd = "Aider",
  keys = {
    { "<leader>A/", "<cmd>Aider toggle<cr>",       desc = "Toggle Aider" },
    { "<leader>As", "<cmd>Aider send<cr>",         desc = "Send to Aider", mode = { "n", "x" } },
    { "<leader>Ac", "<cmd>Aider command<cr>",      desc = "Aider Commands" },
    { "<leader>Ab", "<cmd>Aider buffer<cr>",       desc = "Send Buffer" },
    { "<leader>A+", "<cmd>Aider add<cr>",          desc = "Add File" },
    { "<leader>A-", "<cmd>Aider drop<cr>",         desc = "Drop File" },
    { "<leader>Ar", "<cmd>Aider add readonly<cr>", desc = "Add Read-Only" },
    { "<leader>AR", "<cmd>Aider reset<cr>",        desc = "Reset Session" },
  },
  dependencies = {
    "folke/snacks.nvim",
  },
  opts = { auto_reload = false }
}
