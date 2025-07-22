-- Would be nice that you could modify the letters in the right column and change hex codes accordingly.
-- doesn't work with noice (msg_scroll_flush) (if started with -b, otherwise it works)
-- can't use DiffOrig here
return {
  {
    'RaafatTurki/hex.nvim',
    opts = {},
    cmd = {
      'HexDump',
      'HexAssemble',
      'HexToggle',
    },
    config = function(_, opts)
      require('hex').setup(opts)
      -- vim.o.nf = vim.o.nf .. 'hex'
    end,
  },
  {
    -- FIX: slow
    'glts/vim-radical',
    dependencies = {
      'glts/vim-magnum',
    },
    init = function()
      vim.g.radical_no_mappings = true
    end,
    keys = {
      -- { mode = { 'n', 'x' }, 'gA', '<Plug>RadicalView' },
      { 'gA', '<Plug>RadicalView', desc = 'Show number conversions under cursor' },
      { 'gA', '<Plug>RadicalView', mode = 'x', desc = 'Show number conversions under selection' },
      -- non devi essere necessariamente sul numero
      -- TODO: visual mode mappings?
      { --[[cR]]'>d', '<Plug>RadicalCoerceToDecimal', desc = 'Convert Number to [D]ecimal' },
      { --[[cR]]'>x', '<Plug>RadicalCoerceToHex', desc = 'Convert Number to [H]ex' },
      { --[[cR]]'>o', '<Plug>RadicalCoerceToOctal', desc = 'Convert Number to [O]ctal' },
      { --[[cR]]'>b', '<Plug>RadicalCoerceToBinary', desc = 'Convert Number to [B]inary' },
    },
  },
}
