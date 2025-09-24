-- https://github.com/zbirenbaum/copilot.lua/issues/302
return {
  "zbirenbaum/copilot.lua",
  dependencies = {
    "copilotlsp-nvim/copilot-lsp", -- (optional) for NES functionality
  },
  keys = { {'<leader>A'} },
  -- event = "InsertEnter",
  cmd = "Copilot",
  build = ":Copilot auth",
  config = function(_, opts)
    Snacks.toggle({
      name = "Github Copilot",
      get = function()
        if not vim.g.copilot_enabled then         -- HACK: since it's disabled by default the below will throw error
          return false
        end
        return not require("copilot.client").is_disabled()
      end,
      set = function(state)
        if state then
          require("copilot").setup(opts)           -- setting up for the very first time
          require("copilot.command").enable()
          vim.g.copilot_enabled = true
        else
          require("copilot.command").disable()
          vim.g.copilot_enabled = false
        end
      end,
    }):map("<leader>A")
  end,
  opts = {
    panel = {
      enabled = true,
      auto_refresh = true,
      layout = {
        position = "top", -- | top | left | right
        ratio = 0.4
      },
    },
    suggestion = {
      enabled = true,
      auto_trigger = false,
      -- BUG: doesn't work
      -- accept = '<space><space>',
      -- accept_word = "<M-)>",
      -- accept_word = "<M-w>",
      -- accept_word = "<m-tab>",
      -- accept_word = "<M-w>",
      -- accept_line = "<M-l>",
      -- next = "<C-.>",
      -- prev = "<C-,>",
      --         dismiss = "<C/>",
      -- very nice to use with home row mods
      -- consider ctrl and alt space?
    },
    nes = {
      enabled = true,
		keymap = {
			accept_and_goto = "<cr>",
    },
  },
    -- should_attach = function(_, bufname)
      --   return false
      -- end,
      layout = {
        -- position = "bottom", -- | top | left | right | horizontal | vertical
        position = "right"
      },
    },
  }
  -- vim.keymap.set('n','<m-t>',function()require("copilot.suggestion").toggle_auto_trigger()end,{desc="toggle auto trigger for the current buffer"})

  -- -- https://github.com/zbirenbaum/copilot.lua/issues/183
  -- doesn't work
  -- vim.keymap.set("i", "<a-w>", function()
    --   require("copilot.suggestion").accept_word()
    --   require("copilot.suggestion").next()
    -- end, { desc = "[copilot] accept (word) and next suggestion"})

    -- now it works
    -- vim.keymap.set("i", "<space><space>", function()
      --   require("copilot.suggestion").accept_word()
      --   require("copilot.suggestion").next()
      -- end, { desc = "[copilot] accept (word) and next suggestion"})

      -- vim.keymap.set("i", "<space><space>", function() require("copilot.suggestion").accept() end, { desc = "[copilot] accept"})
      -- vim.keymap.set("i", ";;", function() require("copilot.suggestion").accept() end, { desc = "[copilot] accept"})
      -- find comfortable mapping for this...
      -- vim.keymap.set("i", "jf", function() require("copilot.suggestion").accept() end, { desc = "[copilot] accept"})
      -- vim.keymap.set("i", "fj", function() require("copilot.suggestion").accept() end, { desc = "[copilot] accept"})
      -- vim.keymap.set("i", "<m-w>", function() require("copilot.suggestion").accept_word() end, { desc = "[copilot] accept_word"})
      -- vim.keymap.set("i", "<m-l>", function() require("copilot.suggestion").accept_line() end, { desc = "[copilot] accept_line"})
      -- vim.keymap.set("i", "<m-j>", function() require("copilot.suggestion").next() end, { desc = "[copilot] next"})
      -- vim.keymap.set("i", "<m-k>", function() require("copilot.suggestion").prev() end, { desc = "[copilot] previous"})
      -- -- Copilot
      -- vim.keymap.set("i", "<leader><C-j>", "<Plug>(copilot-next)", { desc = "open copilot" })
      -- vim.keymap.set("i", "<leader><C-k>", "<Plug>(copilot-previous)", { desc = "open copilot" })
      --
      --
