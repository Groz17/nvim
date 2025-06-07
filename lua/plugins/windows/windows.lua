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
    -- tmux/zellij?
    -- would be nice to close a window remotely... (maybe with flash)
    'mrjones2014/smart-splits.nvim',
    -- home row mods possono dare una mano mi sa
    keys = {
      --
      -- resizing splits
      -- resize keys also accept a range, e.e. pressing `5j` will resize down 5 times the default_amount
      --   - <<C-W><Space>>: Window Hydra Mode (which-key)
      { "<A-r>",   function() require("smart-splits").start_resize_mode() end },
      -- { "<c-w><space>",   function() require("smart-splits").start_resize_mode() end , desc="Resize"},
      -- these keymaps will also accept a range,
      -- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
      -- Use those for nvim-gomove
      -- { "<A-h>",   function() require("smart-splits").resize_left() end },
      -- { "<A-j>",   function() require("smart-splits").resize_down() end },
      -- { "<A-k>",   function() require("smart-splits").resize_up() end },
      -- { "<A-l>",   function() require("smart-splits").resize_right() end },
      -- moving between splits
      -- uso vim default mappings with kanata layer producing c-w
      -- per il momento usa questi, just too good
      -- { "<C-h>",   function() require("smart-splits").move_cursor_left() end },
      -- { "<C-j>",   function() require("smart-splits").move_cursor_down() end },
      -- { "<C-k>",   function() require("smart-splits").move_cursor_up() end },
      -- { "<C-l>",   function() require("smart-splits").move_cursor_right() end },
      -- { '<C-\\>',  function() require('smart-splits').move_cursor_previous() end},
      -- swapping buffers between windows
      -- would be nice to use flash or leap here
      -- { "<C-A-h>", function() require("smart-splits").swap_buf_left() end },
      -- { "<C-A-j>", function() require("smart-splits").swap_buf_down() end },
      -- { "<C-A-k>", function() require("smart-splits").swap_buf_up() end },
      -- { "<C-A-l>", function() require("smart-splits").swap_buf_right() end },
    }
  },
  -- would be cool to separate windows/buffers based on extension or even group them, like group them by Front End (HTML, CSS), etc...
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
    -- https://github.com/wellle/visual-split.vim/issues/14
    -- replace: you can use pedit
    -- :pedit +/fputc %
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
    -- can't use descriptions in cmd???
    -- cmd = {
    -- Resize split to show everything between marks `a` and `b` with `:'a,'bVSResize`
    -- Split out range between line above cursor containing `foo` and line below cursor containing `bar` with `:?foo?,/bar/VSSplit`
    -- { "VSResize",     desc = "resize split to range" },
    -- { "VSSplit",      desc = "split out range" },
    -- { "VSSplitAbove", desc = "split out range above" },
    -- { "VSSplitBelow", desc = "split out range below" },
    -- }
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

