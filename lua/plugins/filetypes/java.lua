-- https://gitlab.com/schrieveslaach/sonarlint.nvim
-- https://www.reddit.com/r/neovim/comments/1cg1liu/neovim_starter_kit_for_java/



-- check this out: https://github.com/Matt-FTW/dotfiles/blob/5390514c131bed202634c55f7ca9a0cc87748155/.config/nvim/lua/plugins/extras/lang/sql-extended.lua#L12
-- maybe add tables: which-key, documentation, lsp, tools (mason)

-- TODO:
--     ○ nvim-java-test
--     ○ spring-boot.nvim
--https://github.com/JavaHello/spring-boot.nvim
-- italic font per static (like UML?)
--  test_nearest_method({ config = { console = 'console' }}) (https://github.com/mfussenegger/nvim-jdtls/issues/31)
-- https://gist.github.com/liujoey/eb800a0eafcbdb78a7ac7d758e5370bc
return {
  {
    -- TODO: constructor should accept v:count? like 2<mapping> -> 2 argument...
    -- TODO: add all attributes in constructor code action? maybe 'all' to type?
    -- TODO: add sprig-boot.nvim
    -- why do you need ftplugin and can't put everything here???
    'mfussenegger/nvim-jdtls',
    dependencies = { 'mfussenegger/nvim-dap' },
    ft = 'java',
    keys = {
      -- stylua: ignore start
      -- TODO: check if you can avoid using which-key and put everything in keys (use lhs without rhs, and maybe ask folke to use group instead of desc???)
      -- { '<localleader>r', ft = "java", buffer = true, desc = 'Refactoring' },
      -- probably not necessary to put ft='java' here
      { '<localleader>ri', function() require('jdtls').organize_imports() end, buffer = true, desc = 'Organize imports', ft = 'java'},
      { '<localleader>gs', function() require('jdtls').super_implementation() end, buffer = true, desc = 'Go to super implementation', ft = 'java'},
      { mode = 'x', '<localleader>rv', "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", buffer = true, desc = 'Extract variable', ft = 'java'},
      { '<localleader>rv', "<Cmd>lua require('jdtls').extract_variable()<CR>", buffer = true, desc = 'Extract variable', ft = 'java'},
      { mode = 'x', '<localleader>rc', "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", buffer = true, desc = 'Extract constant', ft = 'java'},
      { '<localleader>rc', "<Cmd>lua require('jdtls').extract_constant()<CR>", buffer = true, desc = 'Extract constant', ft = 'java'},
      { mode = 'x', '<localleader>rm', [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]], buffer = true, desc = 'Extract method', ft = 'java'},
      { '<localleader>rm', [[<ESC><CMD>lua require('jdtls').extract_method()<CR>]], buffer = true, desc = 'Extract method', ft = 'java'},

      { '<localleader>jr', '<cmd>JdtUpdateConfig<cr>', buffer = true, desc = 'JdtUpdateConfig', ft = 'java'},
      { '<localleader>jb', '<cmd>JdtBytecode<cr>', buffer = true, desc = 'JdtBytecode', ft = 'java'},
      { '<localleader>jc', '<cmd>JdtCompile<cr>', buffer = true, desc = 'JdtCompile', ft = 'java'},
      { '<localleader>jj', '<cmd>JdtJol<cr>', buffer = true, desc = 'JdtJol', ft = 'java'},
      -- how to open in vertical split?
      { '<localleader>jx', '<cmd>JdtJshell<cr>', buffer = true, desc = 'JdtJshell', ft = 'java'},
      { '<localleader>jw', '<cmd>JdtRestart<cr>', buffer = true, desc = 'JdtRestart', ft = 'java'},
      { '<localleader>js', '<cmd>JdtSetRuntime<cr>', buffer = true, desc = 'JdtSetRuntime', ft = 'java'},
      { '<localleader>ju', '<cmd>JdtShowLogs<cr>', buffer = true, desc = 'JdtShowLogs', ft = 'java'},
      { '<localleader>jt', '<cmd>JdtWipeDataAndRestart<cr>', buffer = true, desc = 'jdtWipeDataAndRestart', ft = 'java'},

      { '<localleader>tc', "<Cmd>lua require'jdtls'.test_class()<CR>", buffer = true, desc = 'Test class', ft = 'java'},
      { '<localleader>tm', "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", buffer = true, desc = 'Test nearest method', ft = 'java'},
      {"<localleader>tg","<Cmd>lua require'jdtls.tests'.generate()<CR>", desc="Generate tests", buffer=true,ft='java'},
      {"<localleader>ts","<Cmd>lua require'jdtls.tests'.goto_subjects()<CR>", desc="Jump to tests or subjects", buffer=true,ft='java'},
      -- stylua: ignore end
    },
    config = function()
      -- ~~NOTE: no need to add buffer = true since the next mappings aren't defined~~
          require('which-key').add({ '<localleader>r', buffer = true, group = 'Super' })
          require('which-key').add({ '<localleader>r', buffer = true, group = 'Refactoring' })
          require('which-key').add({ '<localleader>j', buffer = true, group = 'CLI' })
          require('which-key').add({ '<localleader>t', buffer = true, group = 'Test' })
    end,
  },
  -- {
  --   'rcasia/neotest-java',
  --   ft = 'java',
  --   dependencies = {
  --     'mfussenegger/nvim-jdtls',
  --     'mfussenegger/nvim-dap', -- for the debugger
  --     'rcarriga/nvim-dap-ui', -- recommended
  --     'theHamsta/nvim-dap-virtual-text', -- recommended
  --   },
  -- },
}
