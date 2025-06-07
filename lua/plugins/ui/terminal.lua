return {
  {
    -- nvim * doesn't work
    'willothy/flatten.nvim',
    opts = {
      -- Allow a nested session to open if Neovim is opened without arguments
      nest_if_no_args = false,
    },
    -- Ensure that it runs first to minimize delay when opening file from terminal
    lazy = false,
    priority = 1001,
  },
  {
    -- https://github.com/nikvdp/neomux
  },
  -- {
  --   -- https://www.youtube.com/watch?v=9TINe0J9rNg
  --   'mikesmithgh/kitty-scrollback.nvim',
  --   enabled = true,
  --   lazy = true,
  --   cmd = { 'KittyScrollbackGenerateKittens', 'KittyScrollbackCheckHealth' },
  --   event = { 'User KittyScrollbackLaunch' },
  --   -- version = '*', -- latest stable version, may have breaking changes if major version changed
  --   -- version = '^3.0.0', -- pin major version, include fixes and features that do not have breaking changes
  --   config = function()
  --     require('kitty-scrollback').setup()
  --     -- paste_window.yank_register = '+'
  --   end,
  -- }
}



-- -- pick a hidden term
-- ["<leader>pt"] = { "<cmd> Telescope terms <CR>", "pick hidden term" },
--

-- use mappings consistent with i3/wm
-- -- new
--
-- ["<leader>h"] = {
--   function()
--     require("nvterm.terminal").new "horizontal"
--   end,
--   "new horizontal term",
-- },
--
-- ["<leader>v"] = {
--   function()
--     require("nvterm.terminal").new "vertical"
--   end,
--   "new vertical term",
