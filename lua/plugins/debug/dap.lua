-- TODO: how to configuer elements? check the pro's configurations
---@see https://github.com/mfussenegger/nvim-jdtls/issues/97
--  remove the console = 'integratedTerminal'; option, so that by default the output is redirected to the REPL buffer.
-- https://github.com/Beloin/Launch.nvim

  -- `usevisible`

-- TODO: https://github.com/Weissle/persistent-breakpoints.nvim

-- https://github.com/jay-babu/mason-nvim-dap.nvim

-- https://github.com/lukas-reineke/dotfiles/blob/master/vim/lua/plugins/nvim_dap.lua
-- TODO: enter in terminal doesn't work (it's buggy use c-\c-n)
return
  {
    -- nvim-dap-projects
    "mfussenegger/nvim-dap",
    -- Uso hydra
    lazy = true, -- shouldn't be necessary cause it's a dependency of nvim-dap-ui but apparently it is...
    dependencies = {
        -- -- Runs preLaunchTask / postDebugTask if present
        -- { "stevearc/overseer.nvim", config = true },
      -- TODO: use blink
      -- {
      --
      --   -- sposta le 3 dipendenze in ui?
      --   "rcarriga/cmp-dap",
      --   config = function()
      --     -- TODO: can you use readline here?
      --     require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
      --       sources = {
      --         { name = "dap" },
      --       },
      --     })
      --   end,
      -- },
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {
          enabled_commands = false,
          commented = true,
          show_stop_reason = true, -- show stop reason when stopped for exceptions
          virt_text_pos = vim.fn.has("nvim-0.10") == 1 and "inline" or "eol",
        },
      },
      -- TODO: blink completion? + nvim-dap-view
      {'ofirgall/goto-breakpoints.nvim'},
      {
        "LiadOz/nvim-dap-repl-highlights",
        build = ":TSInstall dap_repl",
        dependencies = "nvim-treesitter/nvim-treesitter",
        opts = {},
      },

    },

    config = function()
    -- require("overseer").enable_dap() -- https://www.lazyvim.org/extras/editor/overseer
      local dap = require("dap")

  -- dap.defaults.fallback.external_terminal = {
  --   command = vim.fn.exepath('kitty'),
  --   args = {'-e'};
  -- }
  -- dap.defaults.fallback.force_external_terminal = true

      dap.defaults.fallback.switchbuf = "useopen,uselast"
      -- dap.defaults.fallback.switchbuf = 'usetab,uselast'

      --         ╭──────────────────────────────────────────────────────────╮
      --         │                         ADAPTERS                         │
      --         ╰──────────────────────────────────────────────────────────╯

dap.adapters.bashdb = { type = 'executable'; command = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/bash-debug-adapter'; name = 'bashdb';
}
      -- dap.adapters.firefox = { type = "executable", command = "node", args = { require('mason-registry').get_package('firefox-debug-adapter'):get_install_path() .. "/dist/adapter.bundle.js" } }
      -- dap.adapters.node2 = { type = "executable", command = "node", args = { require('mason-registry').get_package('node-debug2-adapter'):get_install_path() .. "/out/src/nodeDebug.js" } }
      -- dap.adapters.cppdbg = { id = "cppdbg", type = "executable", command = vim.fn.stdpath("data") .. "/mason/bin/OpenDebugAD7" }

      dap.adapters.lldb = {
        type = "executable",
        command = "/usr/bin/lldb-vscode-14", -- adjust as needed, must be absolute path
        name = "lldb",
      }
      -- dap.adapters.codelldb = {
      --   type = "server",
      --   port = "${port}",
      --   executable = {
      --     command = "~/.local/share/nvim/mason/packages/codelldb/extension/adapter/codelldb",
      --     args = { "--port", "${port}" },
      --   },
      -- }

      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
      }

      -- dap.adapters.rust = dap.adapters.lldb
      -- dap.adapters.c = dap.adapters.lldb
      -- dap.adapters.cpp = dap.adapters.lldb
      dap.adapters.rust = dap.adapters.lldb
      -- dap.adapters.c = dap.adapters.lldb
      dap.adapters.c = dap.adapters.gdb
      dap.adapters.cpp = dap.adapters.lldb

      --         ╭──────────────────────────────────────────────────────────╮
      --         │                      CONFIGURATIONS                      │
      --         ╰──────────────────────────────────────────────────────────╯
      -- TODO: metti in filetype configs...
dap.configurations.sh = {
  {
    type = 'bashdb',
    request = 'launch',
    name = "Launch file",
    showDebugOutput = true,
    pathBashdb = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb',
    pathBashdbLib = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir',
    trace = true,
    file = "${file}",
    program = "${file}",
    cwd = '${workspaceFolder}',
    pathCat = "cat",
    pathBash = "/bin/bash",
    pathMkfifo = "mkfifo",
    pathPkill = "pkill",
    args = {},
    argsString = '',
    env = {},
    terminalKind = "integrated",
  }
}

      dap.configurations.bash = dap.configurations.sh

      dap.configurations.cpp = {
      --   {
      --     name = 'Launch',
      --     -- type = 'lldb',
      --     type = 'codelldb',
      --     request = 'launch',
      --     program = function() return vim.fn.expand("%:r") end,
      --     -- program = function() return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file') end,
      --     cwd = "${workspaceFolder}",
      --     -- stopOnEntry = false,
      --     stopOnEntry = false,
      --     args = {},
      --
      -- maybe you could app args before running countinue ("a" key mapping)
      -- -- args = function()
      -- --   return coroutine.create(function(dap_run_co)
      -- --     vim.ui.input({ prompt = 'Args >'}, function(choice)
      -- --       if choice then
      -- --         local arg = require("dap.utils").splitstr(choice)
      -- --       end
      -- --       coroutine.resume(dap_run_co, arg)
      -- --     end)
      -- --   end)
      -- -- end,
      --   },
      {
        name = "Launch file",
        type = "lldb",
        request = "launch",
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopAtEntry = true,
      },
      {
        name = 'Attach to gdbserver :1234',
        type = 'cppdbg',
        request = 'launch',
        MIMode = 'gdb',
        miDebuggerServerAddress = 'localhost:1234',
        miDebuggerPath = '/usr/bin/gdb',
        cwd = '${workspaceFolder}',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
      },

      }
      -- dap.configurations.c = dap.configurations.cpp
      -- TODO: how to show asm?
      dap.configurations.c = {
        {
          name = "Launch",
          type = "gdb",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = "${workspaceFolder}",
          stopAtBeginningOfMainSubprogram = false,
        },
        {
          name = "Select and attach to process",
          type = "gdb",
          request = "attach",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          pid = function()
            local name = vim.fn.input('Executable name (filter): ')
            return require("dap.utils").pick_process({ filter = name })
          end,
          cwd = '${workspaceFolder}'
        },
        {
          name = 'Attach to gdbserver :1234',
          type = 'gdb',
          request = 'attach',
          target = 'localhost:1234',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}'
        },
      }
      dap.configurations.rust = dap.configurations.cpp
					-- dap.configurations.java = {
					-- 	{
					--          name = "java",
					-- 		javaExec = "java",
					-- 		request = "launch",
					-- 		type = "java",
					-- 	}
					--      }
					-- 	{
					-- 		type = "java",
					-- 		request = "attach",
					-- 		name = "Debug (Attach) - Remote",
					-- 		hostName = "127.0.0.1",
					-- 		port = 5005,
					-- 	},
					-- }

      -- dap.configurations.java = {
      --
      --   {
      --     name = "Debug Launch (2GB)",
      --     type = 'java',
      --     request = 'launch',
      --     -- request = 'attach',
      --     -- vmArgs = "-Xmx2g "
      --   }
      --
      --
      -- }

      --         ╭──────────────────────────────────────────────────────────╮
      --         │                          SIGNS                           │
      --         ╰──────────────────────────────────────────────────────────╯

      local sign = vim.fn.sign_define

      -- sign("DapBreakpoint", { text = " ", texthl = "", linehl = "", numhl = "" })
      sign("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
      sign("DapBreakpointRejected", { text = " ", texthl = "DiagnosticError", linehl = "", numhl = "" })
      sign("DapBreakpointCondition", { text = " ", texthl = "", linehl = "", numhl = "" })
      sign("DapStopped", { text = "", texthl = "DiagnosticWarn", linehl = "DapStoppedLine", numhl = "DapStoppedLine" }      )
      sign("DapLogPoint", { text = "", texthl = "", linehl = "", numhl = "" })
      sign("DapBreakpointRejected", { text = "" })
    end,
  }

--     'jayp0521/mason-nvim-dap.nvim',
--     cmd = 'DAPInstall',
--     opts = {
--         automatic_setup = true,
--         handlers = {
--             function(conf)
--                 require 'mason-nvim-dap'.default_setup(conf)
--             end,
--         },
--     },
-- }
