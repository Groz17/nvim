-- ○ neoscroll.nvim 
return {
  -- TODO: add ranges as well
  'nacro90/numb.nvim',
  -- doesn't work
  -- do I need to use ; or : if I mapped ; to :?
  -- keys = ':',
  event = 'CmdLineEnter',
  opts = {
    number_only = true,
  },
  config = function(_, opts)
    require('numb').setup(opts)
  end,
}
