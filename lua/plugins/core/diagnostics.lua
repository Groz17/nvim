-- crea mappigs/snippets/etc... for diagnostics? like disable
return {
  -- 'Kasama/nvim-custom-diagnostic-highlight',
  -- config = function()
  --   require('nvim-custom-diagnostic-highlight').setup {}
  -- end

  {
    'onsails/diaglist.nvim',
    cond = false,
    keys = {
      { '<space>dw', function() require('diaglist').open_all_diagnostics() end },
      { '<space>d0', function() require('diaglist').open_buffer_diagnostics() end },
    },
  },
}
