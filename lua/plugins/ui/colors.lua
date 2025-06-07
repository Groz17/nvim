-- https://www.reddit.com/r/neovim/comments/1jihmwd/palettenvim_make_your_own_colorscheme/
-- uga-rosa/ccc.nvim (crea unico file colors.lua e mettici colorswatch)
return {
{
  "nvzone/minty",
  cmd = { "Shades", "Huefy" },
  dependencies = { "nvzone/volt"},
},
  {
    -- what about blink?
    'brenoprata10/nvim-highlight-colors',
    event = 'BufEnter', -- event = { "BufReadPre *.html,*.conf,*.lua,*.css", "BufWritePost", "BufNewFile" },
    opts = {
      -- render = 'foreground',
      -- render = 'virtual',
      render = 'background',
      enable_tailwind = true,
      -- maybe also octo...
      -- also ignore if part of url...
      exclude_buffer = function(bufnr) return
        -- vim.bo[bufnr].filetype == 'bigfile' or vim.bo[bufnr].filetype=='lazy'
        vim.tbl_contains({'bigfile','lazy','xxd'},vim.bo[bufnr].filetype)
      end
    },
  },
}

-- {
--   "uga-rosa/ccc.nvim",
--   opts = function()
--     local RgbHslCmykInput = require("plugins.configs.editor.ccc")
--     return {
--       highlighter = {
--         auto_enable = false,
--         lsp = true,
--       },
--       inputs = {
--         RgbHslCmykInput,
--       },
--     }
--   end,
--   cmd = { "CccPick", "CccConvert", "CccHighlighterEnable", "CccHighlighterDisable", "CccHighlighterToggle" },
--   keys = {
--     { "<leader>zp", "<cmd>CccPick<cr>", desc = "Pick" },
--     { "<leader>zc", "<cmd>CccConvert<cr>", desc = "Convert" },
--     { "<leader>zh", "<cmd>CccHighlighterToggle<cr>", desc = "Toggle Highlighter" },
--   },
-- },
