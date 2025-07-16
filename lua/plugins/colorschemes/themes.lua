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
  -- {
    -- https://github.com/folke/styler.nvim/issues/2
    --https://github.com/f-person/auto-dark-mode.nvim?tab=readme-ov-file
    -- You can disable auto-dark-mode.nvim at runtime via lua require('auto-dark-mode').disable().
    -- spero funga con styler, senno tabdo bufdo  vim.api.nvim_set_option("background", "light/dark") should work? not for the next buffers tho
    -- gsettings set org.gnome.desktop.interface color-scheme prefer-dark in crontab
    -- how to make it work w/ transparent.nvim?
    -- ghostty makes it useless?
  --   'f-person/auto-dark-mode.nvim',
  --   opts = {},
  -- },

  --         ╭──────────────────────────────────────────────────────────╮
  --         │                       COLORSCHEMES                       │
  --         ╰──────────────────────────────────────────────────────────╯
  -- Colorscheme plugins can be configured with `lazy=true`. The plugin will automagically load when doing `colorscheme foobar`.
  -- They won't show up in snacks colorscheme though
  {
    'thallada/farout.nvim',--[[  lazy = true ]]
  },
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
  {
    'numToStr/Sakura.nvim',--[[  lazy = true ]]
  },
  { 'projekt0n/github-nvim-theme', name = 'github-theme' },
  {
    'backdround/melting',
  -- priority = 1000, -- make sure to load this before all the other start plugins
    -- config = function() vim.cmd.colorscheme("melting") end,
  },
  {
    -- the colorscheme should be available when starting Neovim
    'ellisonleao/gruvbox.nvim',
    -- config = function() vim.cmd([[colorscheme gruvbox]]) end,
  },
  {'iruzo/matrix-nvim'},
  {'diegoulloao/neofusion.nvim'},
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
  "rebelot/kanagawa.nvim",
},
-- {
  -- "zenbones-theme/zenbones.nvim",
    -- dependencies = "rktjmp/lush.nvim",
        -- vim.g.zenbones_darken_comments = 45
-- },
  {
    'yassinebridi/vim-purpura', lazy = true
  },
  -- {
  --   "pineapplegiant/spaceduck",
  -- },

  {
    'wtfox/jellybeans.nvim',--[[  lazy = true ]] lazy = true, opts={},
  --   config = function()
  --     require('jellybeans').setup()
  --   end
  },

  {
    "xero/miasma.nvim",
    -- config = function() vim.cmd([[colorscheme miasma]) end,
  },
  {
    -- doesn't have light theme, sadly
    'oahlen/iceberg.nvim',--[[  lazy = true ]] lazy = true
  },
  {
    'lunarvim/synthwave84.nvim', lazy = true
  },
  -- keep this spec as the last one (first colorschemes, then plugins that work with colorscheme)
  {
    'sample-usr/rakis.nvim', lazy = true,
  },
  -- evergarden?
  {
  "vague2k/vague.nvim",
},
{
  "eldritch-theme/eldritch.nvim",
  lazy = true,
  -- name = "eldritch",
  opts = {
    -- contrast = 'hard',
      on_highlights = function(highlights, colors)
        -- highlights.String = { fg = colors.dark_cyan }
        -- i want 2 copy https://www.reddit.com/r/neovim/comments/1jozord/when_in_a_markdown_file_in_neovim_you_open_a_link/#lightbox
        highlights.String = { fg = "#00bfb0" }
        highlights.Function = { fg = colors.purple }
        highlights.Constant = { fg = "#007fbf" }
      end,
},
},

  -- works badly lualine (component separator)
    -- blink looks beatiful here
    -- 'crispybaccoon/evergarden',
    -- opts = {
    --   transparent_background = true, contrast_dark = 'medium', -- 'hard'|'medium'|'soft'
    --   overrides = {}, -- add custom overrides
    -- },

-- {"Scysta/pink-panic.nvim", lazy=true,dependencies="rktjmp/lush.nvim"}, 

  -- vim
  -- {
  --   -- 'joshdick/onedark.vim',
  --   'sainnhe/sonokai',
  --   'sainnhe/edge',
  --   'sainnhe/everforest',
  --   'sainnhe/gruvbox-material',
  -- },

  -- {
  --   'Mofiqul/dracula.nvim',
  --   config = function()
  --     require 'young.theme.dracula'
  --   end,
  -- },
  -- {
  --   'tanvirtin/monokai.nvim',
  --   config = function()
  --     require 'young.theme.monokai'
  --   end,
  -- },
  -- {
  --   'navarasu/onedark.nvim',
  --   config = function()
  --     require 'young.theme.onedark'
  --   end,
  -- },
  -- 'ellisonleao/gruvbox.nvim',
  -- 'daschw/leaf.nvim',
  -- 'projekt0n/github-nvim-theme',
  -- 'mvpopuk/inspired-github.vim',
  -- 'LunarVim/darkplus.nvim',
  -- 'Mofiqul/vscode.nvim',
  -- 'EdenEast/nightfox.nvim',
  -- 'rmehri01/onenord.nvim',
  -- {
  --   'shaunsingh/nord.nvim',
  --   setup = function()
  --     vim.g.nord_borders = true
  --   end,
  -- },
  -- {
  --   'marko-cerovac/material.nvim',
  --   setup = function()
  --     vim.g.material_style = 'palenight'
  --   end,
  -- },
  -- {
  --   'lunarvim/onedarker.nvim',
  --   disable = xy.colorscheme ~= 'onedarker',
  --   branch = 'freeze',
  --   config = function()
  --     require 'young.theme.onedarker'
  --   end,
  -- },

  -- https://github.com/vigoux/oak
  -- https://github.com/rebelot/kanagawa.nvim
  -- https://github.com/co1ncidence/bliss
  -- https://github.com/ulwlu/abyss.vim
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                           Vim                            │
  --  ╰──────────────────────────────────────────────────────────╯
  {
    'franbach/miramare',
    lazy = true,
  },
  {

    'Shadorain/shadotheme',
    lazy = true,
  },
  {
    'cocopon/iceberg.vim',
    cond = false,
  },

  {
  "thesimonho/kanagawa-paper.nvim",
},
  {
    'f4z3r/gruvbox-material.nvim', lazy = true
    -- config = function() vim.cmd([[colorscheme gruvbox-material]]) end,
  },
}
-- https://github.com/thesimonho/kanagawa-paper.nvim?tab=readme-ov-file
