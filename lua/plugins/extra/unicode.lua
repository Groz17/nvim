return {
  "ecruzolivera/snacks-unicode",
  dependencies = { "folke/snacks.nvim" },
  opts = {},
  -- Snacks.picker.pick("unicode", { categories = { "emoji" } })
  keys = {
    {
      mode = {"i","n"},
      "<F12>8<cr>",
      function()
        Snacks.picker.pick("unicode")
      end,
      desc = "Unicode Symbols",
    },
  },
}
