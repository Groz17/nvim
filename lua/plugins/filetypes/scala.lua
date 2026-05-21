return {
  "scalameta/nvim-metals",
  dependencies = {
    {
      "mfussenegger/nvim-dap",
      config = function(self, opts)
        -- Debug settings if you're using nvim-dap
        local dap = require("dap")

        dap.configurations.scala = {
          {
            type = "scala",
            request = "launch",
            name = "RunOrTest",
            metals = {
              runType = "runOrTestFile",
              --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
            },
          },
          {
            type = "scala",
            request = "launch",
            name = "Test Target",
            metals = {
              runType = "testTarget",
            },
          },
        }
      end
    }
  },
  ft = { "scala", "sbt", "java" },
  opts = function()
    local metals_config = require("metals").bare_config()

    -- Example of settings
    metals_config.settings = {
      showImplicitArguments = true,
      excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
    }
    metals_config.init_options.statusBarProvider = "off"

    metals_config.on_attach = function(client, bufnr)
      require("metals").setup_dap()

      vim.keymap.set("n", "<localleader>ws", function()
        require("metals").hover_worksheet()
      end)
    end

    return metals_config
  end,
  config = function(self, metals_config)
    local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = self.ft,
      callback = function()
        require("metals").initialize_or_attach(metals_config)
        vim.keymap.set('n','<c-c><c-c>','<cmd>lua require"metals".commands()<CR>', { desc = "Commands picker" })
      end,
      group = nvim_metals_group,
    })

  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.worksheet.sc" },
    callback = function()
      vim.lsp.inlay_hint.enable(true)
    end,
    group = nvim_metals_group,
  })
  end
}
