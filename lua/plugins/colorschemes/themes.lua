return {
  {
    'oonamo/ef-themes.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd [[colorscheme ef-summer]]
    end,
  },
  --         ╭──────────────────────────────────────────────────────────╮
  --         │              COLORSCHEME-AFFECTING PLUGINS               │
  --         ╰──────────────────────────────────────────────────────────╯
  -- https://github.com/skywind3000/vim-color-patch
  {
    "xiyaowong/transparent.nvim",
    cmd = { 'TransparentToggle', 'TransparentEnable', 'TransparentDisable' },
    keys = { { '<f13>0', '<cmd>TransparentToggle<cr>' }, },
    opts = {
      extra_groups = {
        "NormalFloat",    -- plugins which have float panel such as Lazy, Mason, LspInfo
        "NvimTreeNormal", -- NvimTree
      },
      -- lualine_style = "default",
      -- lualine_style = "stealth",
    },
    config = function()
      local transparent = require("transparent")
      transparent.clear_prefix("lualine")
      -- if config.transparent then
      -- vim.cmd("TransparentEnable")
      -- end
    end,
  },


  {
    -- integrate w/ desktop? pywal? swww transition(s)?
    -- font as well?
    -- crea completion source for installed colorschemes
    -- Styler! to force colorscheme change?
    -- how to integrate w/ lualine/statusline?
    -- would be cool to theme buffers based on extension or even group them, like group them by Front End (HTML, CSS), etc...
    -- usa ai for colorscheme generation based on filetype (check out plugin on reddit)
    -- :Styler without arguments should return the colorscheme of the current buffer
    -- setlocal! bg?
    -- TODO: does this work for statusline/snacks (preview) as well?
    -- make which-key use the colorscheme?
    'folke/styler.nvim',
    -- FIX: https://github.com/folke/styler.nvim/issues/7
    opts = {
      -- interessante che se usi colo theme in uno di questi il colorscheme non cambia
      themes = {
        -- Divido i &ft by category così so all'istante di che si tratta quel buffer
        -- maybe start letter of filetype->start letter of colorscheme? so you remember colorscheme's names

        -- ╭─────────────────────────────────────────────────────────╮
        -- │ prose                                                   │
        -- ╰─────────────────────────────────────────────────────────╯
        -- markdown = { colorscheme = "gruvbox" },
        -- la cmp window rimane del theme di startup (catppuccin ad esempio)
        -- would be nice if you could specify event for vimwiki, because I want to use filetype=markdown for that but for markdown files outside wiki I want another colorscheme... (to differentiate)
        -- that's why neorg is betta
        vimwiki = { colorscheme = 'github_dark_default' },
        -- help = { colorscheme = "catppuccin-mocha" },

        -- Make it accept glob/regex like in vim
        -- ["*"] = { colorscheme = "shado" },

        -- magari funge sul fisso
        -- snacks_picker_list  = { colorscheme = 'kanagawa-lotus' },
        -- ╭─────────────────────────────────────────────────────────╮
        -- │ programming                                             │
        -- ╰─────────────────────────────────────────────────────────╯
        -- lua = { colorscheme = 'darkrose' },
        -- perl = { colorscheme = 'oxocarbon' },
        -- nice with transparent background
        -- c = { colorscheme = 'shado' },
        -- lua = { colorscheme = "shado" },
        -- dbui = { colorscheme = "iceberg" },

        -- ── db ──────────────────────────────────────────────────────────────
        -- dbui = { colorscheme = 'melting' },
        -- dbui = { colorscheme = 'rose-pine' },
        -- dbout = { colorscheme = 'melting' },
        -- sql = { colorscheme = --[['melting']] 'github_light_high_contrast' },
        -- sql = { colorscheme = 'melting' },

        -- ── web ─────────────────────────────────────────────────────────────
        -- https://github.com/linkarzu/dotfiles-latest/blob/02b74813cd19ebdac8ea3999121a3c538ccedf2b/colorscheme/list/linkarzu-colors.sh
        -- html = { colorscheme = 'eldritch' },
        -- html = { colorscheme = 'darkrose' },
        -- css = { colorscheme = 'purpura' },
        -- javascript = { colorscheme = 'kanagawa-paper' },
        -- java = { colorscheme = 'jellybeans' },

        -- lisp
        -- clojure = { colorscheme = 'sakura' },
      },
    },
    -- To programmatically set the colorscheme for a certain window, you can use:
    --
    -- require("styler").set_theme(0, {
    --   colorscheme = "elflord",
    --   background = "dark"
    -- })
  }

}
