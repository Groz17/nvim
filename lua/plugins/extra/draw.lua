-- https://www.reddit.com/r/neovim/comments/1jwkew4/how_to_make_neovim_always_show_nonexsitent_lines/
return {
  -- how to insert down arrow on first line when there are no more lines?
  'jbyuki/venn.nvim',
  -- keys = [[\a]],
  keys = {{ [[<C-c>v]], desc="Ascii drawing" }}, -- a di ascii
  -- FIX: code duplication...
  -- keys = { vim.g.hleader .. 'a' },
  config = function()
    -- https://github.com/jbyuki/venn.nvim/wiki/Draw-diagrams
    local venn_hint_ascii = [[
      Arrow^^^^^^   Select region with <C-v> 
      ^ ^ _K_ ^ ^   _f_: surround it with box
      _H_ ^ ^ _L_
      ^ ^ _J_ ^ ^                      _<Esc>_
      ]]
    -- _F_: surround^^   _f_: surround     ^^ ^
    -- + corners ^  ^^   overwritten corners
    require('hydra')({
      name = 'Draw Ascii Diagram',
      hint = venn_hint_ascii,
      config = {
        color = 'pink',
        invoke_on_body = true,
        on_enter = function() vim.wo.virtualedit = 'all' end,
      },
      mode = 'n',
      body = '<C-c>v',
      heads = {
        { 'H', '<C-v>h<esc><cmd>VBox<CR>' },
        { 'J', '<C-v>j<esc><cmd>VBox<CR>' },
        { 'K', '<C-v>k<esc><cmd>VBox<CR>' },
        { 'L', '<C-v>l<esc><cmd>VBox<CR>' },
        { "n", "<ESC><CMD>VBoxO<CR>",  { mode = "x" } },
        { "b", "<ESC><CMD>VBoxHO<CR>", { mode = "x" } },
        { "d", "<ESC><CMD>VBoxDO<CR>", { mode = "x" } },
        { "f", "<ESC><CMD>VFill<CR>",  { mode = "x" } },
        { '<Esc>', nil, { exit = true } },
      },
    })
  end,
}
