return {
  {
    {
      'folke/lazydev.nvim',
      ft = 'lua', -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
          { path = "snacks.nvim", words = { "Snacks" } },
        },
        -- disable when a .luarc.json file is found
        enabled = function(root_dir)
          return not vim.uv.fs_stat(root_dir .. "/.luarc.json")
        end,
      },
    },
  },
}

-- {
--   "jbyuki/one-small-step-for-vimkind",
--   cond = false,
--   keys = {
--     { "<F5>", function() require("osv").launch({ port = 8086 }) end, desc = "Adapter Lua Server" },
--     { "<F6>", function() require("osv").run_this() end, desc = "Adapter Lua" },
--   },
--   config = function()
--     local dap = require("dap")
--     dap.configurations.lua = {
--       {
--         type = "nlua",
--         request = "attach",
--         name = "Attach to running Neovim instance",
--       },
--     }
--
--     dap.adapters.nlua = function(callback, config)
--       callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
--     end
--   end,
--   -- event = "BufEnter " .. vim.fn.stdpath('config') .. "**/*.lua"
--   -- ft = "lua",
-- },

-- { '<leader>e<Cr>', function() require 'osv'.run_this() end,             desc = 'Start To Debug' },
-- { '<leader>en',    function() require 'osv'.launch { port = 8086 } end, desc = 'Start To Debug' },
