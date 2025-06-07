---@see https://github.com/ptdewey/plantuml-lsp
local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")
if not configs.plantuml_lsp then
  configs.plantuml_lsp = {
    default_config = {
      cmd = { vim.fn.stdpath'data' .. "/plantuml-lsp/plantuml_lsp", "--stdlib-path=" .. vim.fn.stdpath'data' .. "/plantuml-stdlib" },
      filetypes = { "plantuml" },
      root_dir = function(fname)
        return  vim.fs.dirname(fname)
      end,
      settings = {},
    }
  }
end
lspconfig.plantuml_lsp.setup {}
