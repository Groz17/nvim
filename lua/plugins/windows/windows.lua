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
}
-- TODO: https://github.com/nvim-focus/focus.nvim?tab=readme-ov-file
  -- https://github.com/anuvyklack/windows.nvim

