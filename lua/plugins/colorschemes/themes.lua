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
    opts =function()
      local markup = "ef-summer" -- violetish
      local system =  "ef-arbutus" -- brownish
      local db = "ef-frost" -- whitish
      local scripting =  "ef-dark" -- nocturnal
      local shell = "ef-tritanopia-dark" -- reddish
      local web = "ef-owl" -- synthwavy
      local data = "ef-owl" -- ....
      return
      {
      -- interessante che se usi colo theme in uno di questi il colorscheme non cambia
      themes = {
        -- Divido i &ft by category così so all'istante di che si tratta quel buffer
        -- maybe start letter of filetype->start letter of colorscheme? so you remember colorscheme's names

        -- ╭─────────────────────────────────────────────────────────╮
        -- │ prose                                                   │
        -- ╰─────────────────────────────────────────────────────────╯
        -- la cmp window rimane del theme di startup (catppuccin ad esempio)
        -- Make it accept glob/regex like in vim
        -- ["*"] = { colorscheme = "shado" },
        -- magari funge sul fisso
        -- snacks_picker_list  = { colorscheme = 'kanagawa-lotus' },

-- Web: Bright, energetic themes reflecting the interactive nature of web development.
html        = { colorscheme = web },
css         = { colorscheme = web },
javascript  = { colorscheme = web },
typescript  = { colorscheme = web },

-- Markup: Warm and pastel Ef themes for a friendly, readable documentation feel.

markdown    = { colorscheme = markup },
rst         = { colorscheme = markup },
org         = { colorscheme = markup },
tex         = { colorscheme = markup },
xml         = { colorscheme = markup },

-- Data: Duo family (light/dark) for clean, distinct clarity typical of data formats.
json        = { colorscheme = data },
yaml        = { colorscheme = data },
toml        = { colorscheme = data },

-- Database: Cool, neutral color palette for formal, structured data environments.
sql         = { colorscheme = db },
dbui       = { colorscheme = db },
dbout       = { colorscheme = db },

-- Build: Utilitarian, frosty/wintery themes for automation/task runners.
make        = { colorscheme = 'ef-winter' },
-- docker

-- Shell: Dark and frosty themes representing the streamlined, utilitarian nature of shells.
sh          = { colorscheme = shell },
bash        = { colorscheme = shell },
zsh         = { colorscheme = shell },

-- Scripting: Cool, nocturnal themes for interpreted, rapid scripting languages.
python      = { colorscheme = scripting },
ruby        = { colorscheme = scripting },
perl        = { colorscheme = scripting },

-- System Languages: Robust, technical themes for low-level or performance-oriented languages.
c           = { colorscheme = system },
cpp         = { colorscheme = system },
rust        = { colorscheme = system },
zig         = { colorscheme = system },
      },
    }end,
    -- To programmatically set the colorscheme for a certain window, you can use:
    --
    -- require("styler").set_theme(0, {
    --   colorscheme = "elflord",
    --   background = "dark"
    -- })
  }

}
