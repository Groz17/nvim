-- Packer
return {
  -- useful for leetcode (competitive programming)
  -- would be cool to use j and k to up and down and h and l to switch to seconds/minutes
  {
    'nvzone/timerly',
    cmd = 'TimerlyToggle',
    dependencies = { 'nvzone/volt' },
    opts = {
      position = 'top-right', -- top-left, top-right, bottom-left, bottom-right
    },
    config = function()
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('SanerMappings', { clear = true }),
        callback = function()
          local myapi = require('timerly.api')
          vim.keymap.set('n', 'k', myapi.increment, { buffer = true })
          vim.keymap.set('n', 'j', myapi.decrement, { buffer = true })
          vim.keymap.set('n', 'r', myapi.reset, { buffer = true })
        end,
      })
    end,
  },
}
