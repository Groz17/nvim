-- stable version
return {
  "OlegGulevskyy/better-ts-errors.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  ft = {'typescript','typescriptreact'},
  config = {
    keymaps = {
      toggle = '<localleader>d', -- Toggling keymap
      go_to_definition = 'gd' -- Go to problematic type from popup window
    }
  },
  {
    -- check if you have to disable lsp
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  ft = {'typescript','typescriptreact'},
    opts = {},
  }
}
        -- require("lazyvim.util").lsp.on_attach(function(_, buffer)
        --   -- stylua: ignore
        --   vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
        --   vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
