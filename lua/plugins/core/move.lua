return {
  {
    'booperlv/nvim-gomove',
    keys = {
      -- how to respect indentation?
      -- { "<M-h>",   mode = { "x", "n" }, desc = "Move lines/blocks left" },
      { "<M-j>",   mode = { "x", "n" }, desc = "Move lines/blocks down" },
      { "<M-k>",   mode = { "x", "n" }, desc = "Move lines/blocks up" },
      -- { "<M-l>",   mode = { "x", "n" }, desc = "Move lines/blocks right" },
      { "<M-s-h>", mode = { "x", "n" }, desc = "Duplicate lines/blocks left" },
      { "<M-s-j>", mode = { "x", "n" }, desc = "Duplicate lines/blocks down" },
      { "<M-s-k>", mode = { "x", "n" }, desc = "Duplicate lines/blocks up" },
      { "<M-s-l>", mode = { "x", "n" }, desc = "Duplicate lines/blocks right" },
    },
    opts = {
      reindent = false,
    }
  }
}
-- Bubble single lines       |                |
-- Bubble multiple lines     | vim-unimpaired |
-- vmap <C-Up> xkP`[V`]     |                |
-- vmap <C-Down> xp`[V']    |                |

