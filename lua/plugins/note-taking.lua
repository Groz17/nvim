return {
  -- metti in preview.lua?
  'jbyuki/nabla.nvim',
  cond = false,

  ft = {
    'tex',
    'markdown',
    'vimwiki',
    'pandoc',
    'org',
    'norg',
    'quarto',
    'latex',
    'rmd',
  },
    --stylua: ignore
    keys = {
      { "K", function() require("nabla").popup() end, desc = "Notation", },
    },
  config = function() require('nabla').enable_virt() end,
}
-- norg/obsidian ...
