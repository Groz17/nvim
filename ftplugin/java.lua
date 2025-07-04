-- setlocal formatexpr=g:javaformat#RemoveCommonMarkdownWhitespace()
-- https://www.reddit.com/r/neovim/comments/18g2jgr/having_the_worst_time_trying_to_use_jdtls/
-- https://github.com/gmr458/nvim/blob/main/ftplugin/java.lua
-- HOW TO CONFIGURE THE JAVA DEBUGGER
-- -------------------------------------------------------------------------
-- https://github.com/mfussenegger/nvim-jdtls#configuration-quickstart
-- -------------------------------------------------------------------------
--
local config = {
  on_attach = function(client, bufnr)
    vim.lsp.codelens.refresh()
    require('jdtls').setup_dap({ hotcodereplace = 'auto' })
    local status_ok, jdtls_dap = pcall(require, 'jdtls.dap')
    if status_ok then
      jdtls_dap.setup_dap_main_class_configs() -- per quando inizia a debuggare al di fuori del main...
    -- jdtls_dap.setup_dap_main_class_configs( { config_overrides = { args = function() return vim.fn.input("Args: ") end } })
    -- i wanna see jdk methods...
    -- jdtls_dap.setup_dap_main_class_configs( { config_overrides = { stepFilters = {skipClasses= {'*'}} } })

    end
--     require("jdtls").setup.add_commands()
    -- https://github.com/mfussenegger/nvim-jdtls/issues/487
  end,
  ---@see https://www.reddit.com/r/neovim/comments/1cg1liu/comment/l1tt8m0/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
  cmd = { vim.fn.exepath'/bin/jdtls', },
  -- root_dir = require('jdtls.setup').find_root({'build.gradle', 'pom.xml', '.git'}),
  root_dir = vim.fs.dirname(
    vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]
  ),
  init_options = {
    bundles = {
      vim.fn.globpath("$MASON/share/java-debug-adapter", "*.jar", true, true)
    },
  },
}
require('jdtls').start_or_attach(config)

vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  pattern = { '*.java' },
  callback = function()
    local _, _ = pcall(vim.lsp.codelens.refresh)
  end,
})
