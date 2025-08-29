-- https://github.com/DanielMSussman/motleyLatex.nvim/
return{
  -- https://github.com/mistricky/codesnap.nvim?tab=readme-ov-file#specify-language-extension->it should use &ft right?
  "mistricky/codesnap.nvim",
  init = function()
    -- TODO: maybe use absolute path?
  -- vim.keymap.set('n', '<leader>cp', [[<CMD>TOhtml | execute '!wkhtmltopdf ' . expand('%:S') . ' ' . expand('#:r:S') . '.pdf' | bwipeout!<CR>]], { desc = 'Buffer to pdf' })
  end,
  build='make',
  -- build = "make build_generator",
  keys = {
    -- add pr to use v:register (add option use_clipboard = true, or smth to set it as default)
    { "<leader>cc", "<esc><cmd>CodeSnap<CR>", mode = "x", desc = "Clipboard" },
    -- TODO: how to reference opts.save_path here?
    -- { "<leader>cs", function() require("codesnap").save_snapshot() end , mode = "x", desc = "Save selected code snapshot in ~/Pictures/Code" },
    { "<leader>cC", "<esc><cmd>CodeSnapSave<CR>", mode = "x", desc = "Disk" },
    -- add pr to use v:register (add option use_clipboard or smth to set it as default)
    -- provide save option as well? (magari in different dir...)
    { "<leader>ca", "<esc><cmd>CodeSnapASCII<CR>", mode = "x", desc = "ASCII - clipboard" },
    -- TODO: how to customize highlighting???
    -- only works linewise 😥
    { "<leader>ch", "<esc><cmd>CodeSnapHighlight<CR>", mode = "x", desc = "Highlight - clipboard" },
    { "<leader>cH", "<esc><cmd>CodeSnapSaveHighlight<CR>", mode = "x", desc = "Highlight - disk" },
    {mode="x","<leader>cl",":CodeSnap<space>",desc='Language extension - clipboard '},
    {mode="x","<leader>cL",":CodeSnapSave<space>", desc = "Language extension - disk "}
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
