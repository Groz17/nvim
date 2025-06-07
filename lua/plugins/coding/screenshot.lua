-- https://github.com/DanielMSussman/motleyLatex.nvim/
return{
  -- https://github.com/mistricky/codesnap.nvim?tab=readme-ov-file#specify-language-extension->it should use &ft right?
  "mistricky/codesnap.nvim",
  init = function()
    -- TODO: maybe use absolute path?
  vim.keymap.set('n', '<leader>cp', [[<CMD>TOhtml | execute '!wkhtmltopdf ' . expand('%:S') . ' ' . expand('#:r:S') . '.pdf' | bwipeout!<CR>]], { desc = 'Buffer to pdf' })
  end,
  build='make',
  -- build = "make build_generator",
  keys = {
    -- add pr to use v:register (add option use_clipboard = true, or smth to set it as default)
    { "<leader>cc", "<esc><cmd>CodeSnap<CR>", mode = "x", desc = "Save selected code snapshot into clipboard" },
    -- TODO: how to reference opts.save_path here?
    -- { "<leader>cs", function() require("codesnap").save_snapshot() end , mode = "x", desc = "Save selected code snapshot in ~/Pictures/Code" },
    { "<leader>cC", "<esc><cmd>CodeSnapSave<CR>", mode = "x", desc = "Save selected code snapshot on the disk" },
    -- add pr to use v:register (add option use_clipboard or smth to set it as default)
    -- provide save option as well? (magari in different dir...)
    { "<leader>ca", "<esc><cmd>CodeSnapASCII<CR>", mode = "x", desc = "Take a code snapshot in ASCII format" },
    -- TODO: how to customize highlighting???
    { "<leader>ch", "<esc><cmd>CodeSnapHighlight<CR>", mode = "x", desc = "Take highlighted code blocks into clipboard" },
    { "<leader>cH", "<esc><cmd>CodeSnapSaveHighlight<CR>", mode = "x", desc = "Save highlighted code blocks on the disk" },
    {mode="x","<leader>cl",":CodeSnap<space>",desc='Copy to clipboard specifying language extension'},
    {mode="x","<leader>cL",":CodeSnapSave<space>", desc = "Save to disk specifying language extension"}
  },
  opts = {
    save_path = "~/Pictures/Code",
    watermark = "",
    has_breadcrumbs = false,
    -- does it mean directory here?
       show_workspace = false,
    -- use neovim colorscheme???
    bg_theme = "bamboo",
  },
}
