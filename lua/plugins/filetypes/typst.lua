-- I’m using tinymist LSP to auto generate pdfs. and at times typst-preview as well.
return {
  {
    'chomosuke/typst-preview.nvim',
    ft = 'typst',
    version = '1.*',
    opts = { dependencies_bin = { ['tinymist'] = 'tinymist' } },
    keys = {
      { '<localleader>p', [[<CMD>TypstPreviewToggle<CR>]], desc = "Toggle the preview", buffer = true, ft = 'typst' },
      { '<localleader>P', [[<CMD>TypstPreviewToggle slide<CR>]], desc = "Toggle the preview (slide mode)", buffer = true, ft = 'typst' },
      { '<localleader>c', [[<CMD>lua require 'typst-preview'.set_follow_cursor(not init.get_follow_cursor())<CR>,]] , desc = "Toggle scroll preview as cursor moves.", buffer = true, ft = 'typst' },
      { '<localleader>s', [[<CMD>lua require 'typst-preview'.sync_with_cursor()<CR>]], desc = "Scroll preview to the current cursor position", buffer = true, ft = 'typst' },
    },
  },
  -- {"MrPicklePinosaur/typst-conceal.vim", ft = 'typst'},
  {
    'PartyWumpus/typst-concealer',
    ft = 'typst',
    opts = {}
  },
}
