-- https://github.com/search?q=%22UrlView+lazy%22&type=code
-- https://github.com/axieax/urlview.nvim/issues/54
return {
  -- pretty useful for vimwiki (would be nice if this could search a directory...) (add search string (or maybe title) on the right title-cased)
  -- https://github.com/axieax/urlview.nvim/pull/63
  "axieax/urlview.nvim",
  -- maybe this plugin's functionality can be found in terminal multiplexer or emulator
  -- pin=true,
  keys = {
    -- how to configure telescope here? add options to telescope extension?
    { "[U", desc = "Previous URL" },
    { "]U", desc = "Next URL" },
    -- slash perché fa parte di un url (ed anche mapping comodo)
    -- Here it should open multiple links in multiple tabs right? set browser = qutebrowser/lynx/w3m? that opens in vertical split? nxwm
    { "<C-c>U", [[<Cmd>UrlView buffer sorted=false<CR>]],  desc = "Buffers"  },
    -- { "<f18>P", [[<Cmd>UrlView lazy<CR>]], desc = "Plugins" },
    -- Doesn't support multiple selection... FIX:
    -- Here you can use %<, etc...
    -- { "<LEADER>Uf", [[:UrlView file filepath=]], desc="File" },
  },
  opts = {
    -- For some reason the plugin works but shows errors...
    log_level_min = 5,
    pickers = "native",
    default_include_branch = true,
    jump = {
      prev = "[U",
      next = "]U"
    },
    default_register = '"'
  },
  config = function(_,opts)
  require("urlview").setup(opts)

  local search = require("urlview.search")
  local search_helpers = require("urlview.search.helpers")
  search.jira = search_helpers.generate_custom_search({
    capture = "AXIE%-%d+",
    format = "https://jira.axieax.com/browse/%s",
    })
  end
}
