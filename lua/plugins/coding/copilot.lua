-- does this correct spellings as well?
return {{
  -- how does the plugin integrate with avante.nvim?
  "zbirenbaum/copilot.lua",
  cond=false,
  -- cond=false, -- attach it buffer by buffer with a keymap?
  -- https://github.com/zbirenbaum/copilot.lua/issues/302
  dependencies = { 'AndreM222/copilot-lualine',
  config=function ()

    -- TODO: replace this w/ lsp_status (use this icon though)
    local lualine = require'lualine'
    local opts = lualine.get_config()
    table.insert(opts.winbar.lualine_y, 1, { 'copilot' })
    lualine.setup(opts)
  end
},
  cmd = "Copilot",
  build = ":Copilot auth",
  event = "InsertEnter",
  opts = {
    -- https://github.com/zbirenbaum/copilot.lua/blob/master/SettingsOpts.md
    -- server_opts_overrides = {
    --   trace = "verbose",
    --   settings = {
    --     advanced = {
    --       -- how to modify at runtime? maybe lazy settings?
    --       listCount = 3, -- #completions for panel
    --       inlineSuggestCount = 3, -- #completions for getCompletions
    --     }
    --   },
    -- },
    panel={
      enabled = false,
      auto_refresh = true,
        layout = {
        position = "top", -- | top | left | right
        ratio = 0.4
      },
    },
    suggestion = {
      enabled = false,
      auto_trigger = true,
      keymaps = {
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
        accept = "<M-l>", -- similar to <c-l>
        accept_word = false,
        accept_line = false,
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
    },
    -- should_attach = function(_, bufname)
    --   return false
    -- end,
    filetypes = {
    --   -- gitcommit = false,
    --   -- gitrebase = false,
    --   -- markdown = false,
    --   -- vimwiki = false,
    --   -- neorg = false,
    --   lua = function ()
    --     ---@diagnostic disable-next-line: param-type-mismatch
    --     -- disable for neovim config files
    --     -- if string.match(vim.fn.expand('%:p:h'), '^' .. vim.fn.stdpath('config')) and vim.fn.bufname(vim.fn.bufnr(vim.fn.expand('%:p'))) ~= '' then
    --     if string.match(vim.fn.expand('%:p:h'), '^' .. vim.fn.stdpath('config')) then
    --       return false
    --     end
    --     return true
    --   end,
    --
    --   -- c = true,
      java = true,
      -- javascript = true,
    --   -- typescript = true,
    --   -- javascriptreact = true,
    --   -- typescriptreact = true,
      -- html = true,
    --   sql = true,
      -- css = true,
      ["*"] = false, -- disable for all other filetypes and ignore default `filetypes`
    },
    layout = {
      -- position = "bottom", -- | top | left | right | horizontal | vertical
      position = "right"
    },
  },
  config = function(_,opts)

    require("copilot").setup(opts)
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
      end
      -- come usare una macro per inserire i prossimi n suggerimenti? sleep doesn't work...
    },
  }

    -- -- Copilot
    -- vim.keymap.set("i", "<leader><C-j>", "<Plug>(copilot-next)", { desc = "open copilot" })
    -- vim.keymap.set("i", "<leader><C-k>", "<Plug>(copilot-previous)", { desc = "open copilot" })
    --
    --
