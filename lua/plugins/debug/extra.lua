--         ╭──────────────────────────────────────────────────────────╮
--         │                         NICETIES                         │
--         ╰──────────────────────────────────────────────────────────╯
return
{
  'ofirgall/goto-breakpoints.nvim',
  lazy = true,
  -- cond = false,
  -- TODO: cambia mapping (possono essere usati al di fuori di una sessione di debugging e quindi di hydra...)
  -- config = function()
  --   vim.keymap.set('n', ']v', require('goto-breakpoints').next, {})
  --   vim.keymap.set('n', '[v', require('goto-breakpoints').prev, {})
  --   vim.keymap.set('n', ']S', require('goto-breakpoints').stopped, {})
  -- end
}
