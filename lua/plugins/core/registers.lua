return {
  {
    -- TODO: check if clipboard was modified outside and update it
    -- autocmd/event to check if register value has changed? for @+...
    -- INFO: bel plugin
    -- TODO: works unless you switch i3 workspace
    'EtiamNullam/deferred-clipboard.nvim',
    opts = {
      lazy = true,
    },

  },

  {
    "gbprod/yanky.nvim",
    opts = {},
    keys = {
      { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank text" },
      -- { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after cursor" },
      -- { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before cursor" },
      { "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after selection" },
      { "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before selection" },
      { "<m-y>", "<Plug>(YankyPreviousEntry)", mode = "n", desc = "Select previous entry through yank history" },
      { "<m-y>", "<C-o><Plug>(YankyPreviousEntry)", mode = "i", desc = "Select previous entry through yank history" },
      -- { "<leader>u<m-y>", "<Plug>(YankyNextEntry)", desc = "Select next entry through yank history" },
      -- { "<a-p>", "<Plug>(YankyPutafterCharwiseJoined)", desc = "Select previous entry through yank history" },
      -- { "<a-s-p>", "<Plug>(YankyPutBeforeCharwiseJoined)", desc = "Select next entry through yank history" },
      { "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
      { "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
      { "]P", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
      { "[P", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
      { ">p", "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Put and indent right" },
      { "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Put and indent left" },
      { ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put before and indent right" },
      { "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", desc = "Put before and indent left" },
      { "=p", "<Plug>(YankyPutAfterFilter)", desc = "Put after applying a filter" },
      { "=P", "<Plug>(YankyPutBeforeFilter)", desc = "Put before applying a filter" },
      {"iy", function() require("yanky.textobj").last_put() end, mode={ "o", "x" }, },
      {"ay", function() require("yanky.textobj").last_put() end, mode={ "o", "x" }, },
      {
        "<leader>p",
        function()
          Snacks.picker.yanky()
        end,
        mode = { "n", "x" },
        desc = "Open Yank History",
      },
    },
  }
}
