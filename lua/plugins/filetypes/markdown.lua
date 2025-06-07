return {
  'OXY2DEV/markview.nvim',
  ft = { 'markdown', 'latex', 'typst', 'html', 'yaml' },
  opts = {
    preview = {
      icon_provider = 'mini',
    },
  },
  config = function(_, opts)
    require('markview').setup(opts)
    require('markview.extras.checkboxes').setup()
    vim.keymap.set('n','<localleader>c','<cmd>Checkbox interactive<cr>', {desc = "Change the checkbox state"})
  end,
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'echasnovski/mini.icons',
  },
}
