-- https://github.com/sindrets/winshift.nvim
-- TODO: edgy.nvim (folke...)

-- crea plugin che usa motion to exit from windows, like <c-w>Ql to delete current and windows to the right, etc...
-- https://github.com/kwkarlwang/bufresize.nvim
return {

-- how to restrict jumps to same file?
-- vim.keymap.set('n',[[<c-s-o>]],[[:sp<CR><c-o>]])
-- vim.keymap.set('n',[[<c-s-i>]],[[:sp<CR><c-o>]])
-- vim.keymap.set('n',[[<c-s-o>]],[[:vert sp<CR><c-o>]])
-- vim.keymap.set('n',[[<c-s-i>]],[[:vert sp<CR><c-o>]])
  {
    "nvim-zh/colorful-winsep.nvim",
    event = { "WinLeave" },
    -- config = true,
    opts = {
      symbols = { "─", "│", "┌", "┐", "└", "┘" },
      -- HACK: uso vim al posti di getcmdwintype() = ":" (non funge con la command-line window)
      no_exec_files = { "packer", "TelescopePrompt", "mason", "CompetiTest", "NvimTree", "vim" },
      },
    },
  {
  "wellle/visual-split.vim",
    -- Metti i comandi nelle config lazy, non potresti usarli prima di attivare il plugin con un mapping
    cmd = {
      "VSResize",
      -- bello usarli con global command
      "VSSplit", "VSSplitAbove", "VSSplitBelow"
    },
    keys = {
      { mode = { 'n', 'x' }, '<C-W>gr',  desc = "Resize split to visual selection" },
      { mode = { 'n', 'x' }, '<C-W>gss', desc = "Split out visual selection" },
      { mode = { 'n', 'x' }, '<C-W>gsa', desc = "Split out visual selection above" },
      { mode = { 'n', 'x' }, '<C-W>gsb', desc = "Split out visual selection below" },
    },
  },
  {
    "AndrewRadev/undoquit.vim",
    keys = {
      -- does this work with ZQ? doesn't seem like it...
      -- https://github.com/AndrewRadev/undoquit.vim/issues/10
      { "<c-w>u", desc = "Restore closed window" },
      { "<c-w>U", desc = "Restore all the windows of a full tab" },
      { "<c-w>t", "UndoableTabclose", desc = ":tabclose replacement" },
    },
  },
  {
    'sindrets/winshift.nvim',
    keys = {
      -- Start Win-Move mode:'},
      {'<C-W><C-M>', '<Cmd>WinShift<CR>'},
      {'<C-W>m', '<Cmd>WinShift<CR>'},

      -- Swap two windows:'},
      {'<C-W>X', '<Cmd>WinShift swap<CR>'},

      -- If you don't want to use Win-Move mode you can create mappings for calling the'},
      -- move commands directly:'},
      -- {'<C-M-H>', '<Cmd>WinShift left<CR>'},
      -- {'<C-M-J>', '<Cmd>WinShift down<CR>'},
      -- {'<C-M-K>', '<Cmd>WinShift up<CR>'},
      -- {'<C-M-L>', '<Cmd>WinShift right<CR>'},
    }
  }
}
-- TODO: https://github.com/nvim-focus/focus.nvim?tab=readme-ov-file
  -- https://github.com/anuvyklack/windows.nvim

