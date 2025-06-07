-- yanky.nvim?
-- https://github.com/ibhagwan/smartyank.nvim?tab=readme-ov-file
return {
  -- ╭─────────────────────────────────────────────────────────╮
  -- │ clipboard                                               │
  -- ╰─────────────────────────────────────────────────────────╯
  {
    -- So I have 2 separate databases for clipboard, one for neovim (neoclip) and one for not-neovim (copyq)
    'AckslD/nvim-neoclip.lua',
    cond = false,
    event = { 'TextYankPost', 'RecordingEnter' },
   -- dependencies = {
   --   { 'kkharji/sqlite.lua' },
   -- },
    opts = {
      enable_persistent_history = false,
      history = math.huge,
      lenght_limit = math.huge,
      --  If you often use multiple sessions in parallel and wants the history synced you might want to enable this.
      continuous_sync = true,
      filter = function(data)
        for _, entry in ipairs(data.event.regcontents) do
          if vim.fn.match(entry, [[^\s*$]]) == 0 then
            return false
          else
            return true
          end
        end
      end,
    },
    keys = {
      -- { '<leader>""', function() require('telescope').extensions.neoclip.default() end, desc = "Show yank history in current session"  },
      -- snacks.nvim?
      { '<leader>""', function() require('neoclip.fzf')() end, desc = 'Show yank history in current session' },
      { '<leader>"u', function() require('neoclip.fzf')('unnamed') end, desc = 'Replace register <unnamed> from the history' },
      { '<leader>"u', function() require('neoclip.fzf')('star') end, desc = 'Replace register <star> from the history' },
      { '<leader>"u', function() require('neoclip.fzf')('plus') end, desc = 'Replace register <plus> from the history' },
      { '<leader>"u', function() require('neoclip.fzf')('unnamed') end, desc = 'Replace register <unnamed> from the history' },
      { '<leader>"q', function() require('neoclip.fzf').macroscope.default() end, desc = 'Access recorded macros' },
      -- { "<leader>Q", "<CMD>Telescope macroscope<space>" },
    },
  },
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
  -- [y, ]y mappings?
  -- maybe kanata can help with those silly amount of mappings?
  -- m-y?
  "gbprod/yanky.nvim",
  -- dependencies = {
  --   { "kkharji/sqlite.lua" }
  -- },
  -- keys = {
  -- keys = function()
  --   -- use neovim's default behaviour for p, for force -wise with another mapping
  --   -- local charwise='p'
  --   -- look how cute those mappings are 😭
  --   local charwise='cp'
  --   local linewise='cP'
  --   -- similar mapping to g<ctrl-h> for select mode
  --   -- local blockwise='g<c-p>'
  --   local blockwise='<c-p>'
  --
  --   return {
  --     {";y","<cmd>YankyRingHistory<cr>"},
  --     {mode={"n","x"}, "y", "<Plug>(YankyYank)"},
  --
  --   -- ╭─────────────────────────────────────────────────────────╮
  --   -- │ unimpaired                                              │
  --   -- ╰─────────────────────────────────────────────────────────╯
  --   { "]p", "<Plug>(YankyPutIndentAfterLinewise)"},
  --   { "[p", "<Plug>(YankyPutIndentBeforeLinewise)"},
  --   { "]P", "<Plug>(YankyPutIndentAfterLinewise)"},
  --   { "[P", "<Plug>(YankyPutIndentBeforeLinewise)"},
  --
  --   { ">p", "<Plug>(YankyPutIndentAfterShiftRight)"},
  --   { "<p", "<Plug>(YankyPutIndentAfterShiftLeft)"},
  --   { ">P", "<Plug>(YankyPutIndentBeforeShiftRight)"},
  --   { "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)"},
  --
  --   { "=p", "<Plug>(YankyPutAfterFilter)"},
  --   { "=P", "<Plug>(YankyPutBeforeFilter)"},
  --   -- ╭─────────────────────────────────────────────────────────╮
  --   -- │ modifier                                                │
  --   -- ╰─────────────────────────────────────────────────────────╯
  --   -- create function?
  --   -- for put-type in {"PutAfter", "PutBefore", "GPutAfter", "GPutBefore", "PutIndentAfter", "PutIndentBefore"}
  --   -- for modifier in 
  --   -- ╭─────────────────────────────────────────────────────────╮
  --   -- │ text object                                             │
  --   -- ╰─────────────────────────────────────────────────────────╯
  --   {mode={ "o", "x" }, "iy", function() require("yanky.textobj").last_put() end, {}},
  --   {mode={ "o", "x" }, "ay", function() require("yanky.textobj").last_put() end, {}},
  -- } end,

  keys = {
    -- {";y","<cmd>YankyRingHistory<cr>",desc = "Open Yank History" },
    { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank text" },
    -- { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after cursor" },
    -- { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before cursor" },
    { "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after selection" },
    { "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before selection" },
    -- { "<c-p>", "<Plug>(YankyPreviousEntry)", desc = "Select previous entry through yank history" },
    -- { "<c-s-p>", "<Plug>(YankyNextEntry)", desc = "Select next entry through yank history" },
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
  },
  opts = {
    textobj = {
      enabled = true,
    },
    ring = {
      history_length = 500,
      storage = "shada",
    },
    system_clipboard= {sync_with_ring = false}
  },
},

  {
    'AckslD/nvim-anywise-reg.lua',
    -- NOTE: non funge
    cond = false,
    opts = {
      operators = { 'y', 'd', 'c' },
      textobjects = {
        { 'i', 'a' },
        { 'w', 'W', 'f', 'c' },
      },
      paste_keys = {
        ['p'] = 'p',
        ['P'] = 'P',
      },
      register_print_cmd = true,
    },
  },
  {
    -- https://github.com/hrsh7th/nvim-pasta
  'ku1ik/vim-pasta',
  cond=false,
  keys = {'p','P'}
  }
}
