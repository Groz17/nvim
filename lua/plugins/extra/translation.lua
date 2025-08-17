-- use local LLM/local (command) translator???
return {
  -- use same mappings as chatgpt/muren, etc...
  -- use local LLM to translate???
  -- doesn't support unicode? like 懶
  'potamides/pantran.nvim',
  -- https://github.com/search?q=pantran+neovim&type=code
  -- how to jump to the translated window? {check floatterm docs}
  opts = function()return{
    -- Default engine to use for translation. To list valid engine names run
    -- `:lua =vim.tbl_keys(require("pantran.engines"))`.
    -- default_engine = "deepl",
    default_engine = "google",
    -- Configuration for individual engines goes here.
    engines = {
      deepl = {
        -- default_target = "en"
        default_target = "it"
      },
      yandex = {
        default_target = "ru"
      },
      google = {
        default_target = "it"
      },
      argos = {
        -- how to show vowels here (tashkeet)
        default_target = "ar"
      },
      apertium = {
        default_target = "hi"
      },
    },
    controls = {
      mappings = {
        edit = {
          n = {
            ["<C-g>"] = require("pantran.ui.actions").close,
            ["<M-w>"] = require("pantran.ui.actions").yank_close_translation,
            ["<M-S-5>"] = require("pantran.ui.actions").replace_close_translation,
            ["<C-M-w>"] = require("pantran.ui.actions").append_close_translation,
            ["<M-t>"] = require("pantran.ui.actions").switch_languages,
            ["<F15>s"] = require("pantran.ui.actions").select_source,
            ["<F15>t"] = require("pantran.ui.actions").select_target,
          },
          i = {
            -- Similar table but for insert mode. Using 'false' disables existing keybindings.
            -- C-u prefix for input mappings
            ["<C-g>"] = require("pantran.ui.actions").close,
            ["<M-w>"] = require("pantran.ui.actions").yank_close_translation,
            ["<M-S-5>"] = require("pantran.ui.actions").replace_close_translation,
            ["<C-M-w>"] = require("pantran.ui.actions").append_close_translation,
            ["<M-t>"] = require("pantran.ui.actions").switch_languages,
            ["<F15>s"] = require("pantran.ui.actions").select_source,
            ["<F15>t"] = require("pantran.ui.actions").select_target,
          }
        },
        -- Keybindings here are used in the selection window.
        select = {
          n = {
            -- ...
          }
        }
      }
    }
  }end,
  keys = {
    -- you could use v:count to specify languages? maybe in the order you've learnt them?

    -- ╭─────────────────────╮
    -- │       window        │
    -- ╰─────────────────────╯
    { mode = "n", "<f14>w", "<CMD>Pantran<CR>", desc = "Window" },

    -- ╭─────────────────────╮
    -- │     interactive     │
    -- ╰─────────────────────╯
    { mode = {"n","x"}, "<f14>i", function() return require("pantran").motion_translate({ mode = "interactive" }) end, desc = "Interactive", expr = true },
    { mode = {"n","x"}, "<f14>ii", function() return require("pantran").motion_translate({ mode = "interactive" }) .. '_' end, desc = "Interactive", expr = true },
    { mode = {"n","x"}, "<f14>I", function() return require("pantran").motion_translate({ mode = "interactive" }) .. '$' end, desc = "Interactive", expr = true },

    -- ╭─────────────────────╮
    -- │        yank         │
    -- ╰─────────────────────╯
    { mode = {"n","x"}, "<f14>y", function() return require("pantran").motion_translate({ mode = "yank" }) end, desc = "Yank", expr = true },
    { mode = {"n","x"}, "<f14>yy", function() return require("pantran").motion_translate({ mode = "yank" }) .. '_' end, desc = "Yank", expr = true },
    { mode = {"n","x"}, "<f14>Y", function() return require("pantran").motion_translate({ mode = "yank" }) .. '$' end, desc = "Yank", expr = true },

    -- ╭─────────────────────╮
    -- │       replace       │
    -- ╰─────────────────────╯
    -- s come in surround?
    { mode = {"n","x"}, "<f14>r", function() return require("pantran").motion_translate({ mode = "replace" }) end, desc = "Replace", expr = true },
    { mode = {"n","x"}, "<f14>rr", function() return require("pantran").motion_translate({ mode = "replace" }) .. '_' end, desc = "Replace", expr = true },
    { mode = {"n","x"}, "<f14>R", function() return require("pantran").motion_translate({ mode = "replace" }) .. '$' end, desc = "Replace", expr = true },

    -- ╭─────────────────────╮
    -- │       append        │
    -- ╰─────────────────────╯
    { mode = {"n","x"}, "<f14>a", function() return require("pantran").motion_translate({ mode = "append" }) end, desc = "Append", expr = true },
    { mode = {"n","x"}, "<f14>aa", function() return require("pantran").motion_translate({ mode = "append" }) .. '_' end, desc = "Append", expr = true },
    { mode = {"n","x"}, "<f14>A", function() return require("pantran").motion_translate({ mode = "append" }) .. '$' end, desc = "Append", expr = true },

    -- ╭─────────────────────╮
    -- │        hover        │
    -- ╰─────────────────────╯
    { mode = {"n","x"}, "<f14>h", function() return require("pantran").motion_translate({ mode = "hover" }) end, desc = "Hover", expr = true },
    { mode = {"n","x"}, "<f14>hh", function() return require("pantran").motion_translate({ mode = "hover" }) .. '_' end, desc = "Hover", expr = true },
    { mode = {"n","x"}, "<f14>H", function() return require("pantran").motion_translate({ mode = "hover" }) .. '$' end, desc = "Hover", expr = true },
  }
}
