-- use local LLM/local (command) translator???
return {
  -- use same mappings as chatgpt/muren, etc...
  -- use local LLM to translate???
  -- doesn't support unicode? like 懶
  'potamides/pantran.nvim',
  cond=false,
  -- https://github.com/search?q=pantran+neovim&type=code
  -- how to jump to the translated window? {check floatterm docs}
  opts = {
    -- Default engine to use for translation. To list valid engine names run
    -- `:lua =vim.tbl_keys(require("pantran.engines"))`.
    default_engine = "deepl",
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
    -- controls = {
    --   mappings = {
    --     edit = {
    --       n = {
    --         -- Use this table to add additional mappings for the normal mode in
    --         -- the translation window. Either strings or function references are
    --         -- supported.
    --         -- ["j"] = "gj",
    --         -- ["k"] = "gk"
    --       },
    --       i = {
    --         -- Similar table but for insert mode. Using 'false' disables
    --         -- existing keybindings.
    --         -- ["<C-y>"] = false,
    --         -- ["<C-a>"] = require("pantran.ui.actions").yank_close_translation
    --       }
    --     },
    --     -- Keybindings here are used in the selection window.
    --     select = {
    --       n = {
    --         -- ...
    --       }
    --     }
    --   }
    -- }
  },
  keys = {
    -- you could use v:count to specify languages? maybe in the order you've learnt them?
    -- maybe map with <tab>? distinguish it from <c-i>...

    -- ╭─────────────────────╮
    -- │       window        │
    -- ╰─────────────────────╯
    -- { mode = "n", "ghw", "<CMD>Pantran<CR>", desc = "Interactive Translation" },
    { mode = "n", "gH", "<CMD>Pantran<CR>", desc = "Interactive Translation" },

    -- ╭─────────────────────╮
    -- │     interactive     │
    -- ╰─────────────────────╯
    { mode = {"n","x"}, "ghi", function() return require("pantran").motion_translate({ mode = "interactive" }) end, desc = "Interactive", expr = true },
    { mode = {"n","x"}, "ghii", function() return require("pantran").motion_translate({ mode = "interactive" }) .. '_' end, desc = "Interactive", expr = true },
    { mode = {"n","x"}, "ghI", function() return require("pantran").motion_translate({ mode = "interactive" }) .. '$' end, desc = "Interactive", expr = true },

    -- ╭─────────────────────╮
    -- │        yank         │
    -- ╰─────────────────────╯
    { mode = {"n","x"}, "ghy", function() return require("pantran").motion_translate({ mode = "yank" }) end, desc = "Yank", expr = true },
    { mode = {"n","x"}, "ghyy", function() return require("pantran").motion_translate({ mode = "yank" }) .. '_' end, desc = "Yank", expr = true },
    { mode = {"n","x"}, "ghY", function() return require("pantran").motion_translate({ mode = "yank" }) .. '$' end, desc = "Yank", expr = true },

    -- ╭─────────────────────╮
    -- │       replace       │
    -- ╰─────────────────────╯
    -- s come in surround?
    { mode = {"n","x"}, "ghr", function() return require("pantran").motion_translate({ mode = "replace" }) end, desc = "Replace", expr = true },
    { mode = {"n","x"}, "ghrr", function() return require("pantran").motion_translate({ mode = "replace" }) .. '_' end, desc = "Replace", expr = true },
    { mode = {"n","x"}, "ghR", function() return require("pantran").motion_translate({ mode = "replace" }) .. '$' end, desc = "Replace", expr = true },

    -- ╭─────────────────────╮
    -- │       append        │
    -- ╰─────────────────────╯
    { mode = {"n","x"}, "gha", function() return require("pantran").motion_translate({ mode = "append" }) end, desc = "Append", expr = true },
    { mode = {"n","x"}, "ghaa", function() return require("pantran").motion_translate({ mode = "append" }) .. '_' end, desc = "Append", expr = true },
    { mode = {"n","x"}, "ghA", function() return require("pantran").motion_translate({ mode = "append" }) .. '$' end, desc = "Append", expr = true },

    -- ╭─────────────────────╮
    -- │        hover        │
    -- ╰─────────────────────╯
    { mode = {"n","x"}, "ghh", function() return require("pantran").motion_translate({ mode = "hover" }) end, desc = "Hover", expr = true },
    { mode = {"n","x"}, "ghhh", function() return require("pantran").motion_translate({ mode = "hover" }) .. '_' end, desc = "Hover", expr = true },
    { mode = {"n","x"}, "ghH", function() return require("pantran").motion_translate({ mode = "hover" }) .. '$' end, desc = "Hover", expr = true },
  }
}

-- If ! is provided, the plugin will perform a reverse translating by switching target_lang and source_lang
--
-- Like :Translate..., but display the translation in a window
-- Like :Translate..., but replace the current text with the translation
-- Translate the text in the clipboard
-- Export the translation history
-- Display log message
--
