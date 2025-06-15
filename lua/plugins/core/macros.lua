-- how to execute macro slowly to see why it's failing?
-- use emacs keybindins c-xc-kn save

-- require("telescope").load_extension("macros")
return {
  -- {
    --  "ecthelionvi/NeoComposer.nvim",
    --  dependencies = { "kkharji/sqlite.lua" },
    --  opts = {},
    -- },

    -- minimal config for lazy-loading with lazy.nvim
    {
      cond = false,
      "chrisgrieser/nvim-recorder",
      -- dependencies = "rcarriga/nvim-notify",
      keys = {
        -- these must match the keys in the mapping config below
        { "q", desc = " Start Recording" },
        { "Q", desc = " Play Recording" },
      },
      opts = {
        slots = { "q", "w" },
        mapping = {
          -- switchSlot = "@",
					-- switchSlot = "<C-0>",
					switchSlot = "<C-1>", -- near q on qwerty
          -- BUG: This should map only inside a recording
          addBreakPoint = "<space><space>",
          -- addBreakPoint = "^^",
        },
      },
      config = function(_,opts)
        require("recorder").setup(opts)

        local lualineA = require("lualine").get_config().tabline.lualine_a or {}
        local lualineB = require("lualine").get_config().tabline.lualine_b or {}
        table.insert(lualineA, 1, { require("recorder").recordingStatus })
        table.insert(lualineB, 1, { require("recorder").displaySlots })

        require("lualine").setup {
          tabline = {
            lualine_b = lualineB,
            lualine_a = lualineA,
          },
        }
      end,
    },
    {
      -- fai in modo che dopo aver premuto <c-.> puoi premere . (map . if prevchar='<c-.>' then <c-.> else .?)
      "tani/dmacro.vim",
      -- lazy = true,
      -- event = { 'BufNewFile', 'BufRead' },
      -- doesn't work with folding mappings like za?
      event = {'TextChanged','TextChangedI'},

      -- 			dmacro_key = '<Leader>.' --  you need to set the dmacro_key dmacro_key = "<C-.>", dmacro_key = '<C-q>'
      config = function()
        -- vim.keymap.set({ "i", "n" }, '<C-.>', '<Plug>(dmacro-play-macro)')
        vim.keymap.set({ "i", "n" }, '<f12>z', '<Plug>(dmacro-play-macro)') --repeat
      end
    },
  }
