-- fai filter delle colorscheme (punteggio media pesata) e elimina salvando la lista qll con punteggio basso (no treesitter support, etc...)
-- TODO: https://www.reddit.com/r/neovim/comments/1em9qkl/tired_of_seeing_catppuccin_everywhere_meet_the/

-- would be cool if colorscheme plugins defined the same interface/function to get colors so it's easier to change stuff

-- Djancyp/custom-theme.nvim
-- https://github.com/tjdevries/colorbuddy.nvim
-- https://github.com/ThemerCorp/themer.lua -> nice export functions
-- https://github.com/ray-x/starry.nvim
--https://github.com/AbdelrahmanDwedar/awesome-nvim-colorschemes
--https://github.com/flazz/vim-colorschemes

-- would be cool to theme buffers based on extension or even group them, like group them by Front End (HTML, CSS), etc...
return {
  --         ╭──────────────────────────────────────────────────────────╮
  --         │                     MAIN COLORSCHEME                     │
  --         ╰──────────────────────────────────────────────────────────╯
  {
    "rose-pine/neovim", name = "rose-pine",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd[[colorscheme rose-pine|hi Normal guibg=#0a0a0a]]
      -- vim.api.nvim_set_hl(0, "Normal", { fg = "#0a0a0a" })
    end,
},
  --         ╭──────────────────────────────────────────────────────────╮
  --         │              COLORSCHEME-AFFECTING PLUGINS               │
  --         ╰──────────────────────────────────────────────────────────╯
-- https://github.com/skywind3000/vim-color-patch
  {
    "xiyaowong/transparent.nvim",
    -- doesn't work
    cond = false,
    cmd = {'TransparentToggle','TransparentEnable','TransparentDisable'},
    keys = {{'<f13>0','<cmd>TransparentToggle<cr>'},},
    opts = {
      extra_groups = {
        "NormalFloat", -- plugins which have float panel such as Lazy, Mason, LspInfo
        "NvimTreeNormal", -- NvimTree
      },
      -- lualine_style = "default",
      -- lualine_style = "stealth",
    },
    config = function()
      local transparent = require("transparent")
      -- transparent.clear_prefix("lualine")
      -- transparent.clear_prefix("Bufferline")
      -- if config.transparent then
        -- vim.cmd("TransparentEnable")
      -- end
    end,
  },

  --         ╭──────────────────────────────────────────────────────────╮
  --         │                       COLORSCHEMES                       │
  --         ╰──────────────────────────────────────────────────────────╯
{
    "water-sucks/darkrose.nvim",
},
-- {
--     "comfysage/cuddlefish.nvim",
--     lazy = false,
--     priority = 1000,
--     config = function()
--         vim.cmd.colorscheme('cuddlefish')
--     end
-- },
  { 'projekt0n/github-nvim-theme', name = 'github-theme' },
  {
    'backdround/melting',
  },
  -- {
  --
  --   'rjshkhr/shadow.nvim',
  --   config = function()
  --     vim.cmd[[colorscheme shadow]]
  --     vim.api.nvim_set_hl(0, "String", { fg = "#f8a3ab" })
  --     -- vim.api.nvim_set_hl(0, "String", { fg = "#4b2a5e" })
  --     -- vim.api.nvim_set_hl(0, "Identifier", { fg = "#d35dae" })
  --   end,
  -- },
  {
    -- doesn't work?
    'Shadorain/shadotheme', lazy = true
  },
  {
    "nyoom-engineering/oxocarbon.nvim", lazy = true
  },

  {
    'wtfox/jellybeans.nvim',--[[  lazy = true ]] lazy = true, opts={},
  --   config = function()
  --     require('jellybeans').setup()
  --   end
  },

-- {"Scysta/pink-panic.nvim", lazy=true,dependencies="rktjmp/lush.nvim"}, 


  -- https://github.com/vigoux/oak
  -- https://github.com/rebelot/kanagawa.nvim
  -- https://github.com/co1ncidence/bliss
  -- https://github.com/ulwlu/abyss.vim
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                           Vim                            │
  --  ╰──────────────────────────────────────────────────────────╯
  {

    'Shadorain/shadotheme',
    lazy = true,
  },
{ "oonamo/ef-themes.nvim" },
  {
  "thesimonho/kanagawa-paper.nvim",
}
}
-- https://github.com/thesimonho/kanagawa-paper.nvim?tab=readme-ov-file
