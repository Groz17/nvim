-- lua require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
return {
  {
    'nvim-neotest/neotest-python',
    ft = 'python',
  },
  {
    'mfussenegger/nvim-dap-python',
    ft = 'python',
    keys = {
      {
        mode = 'n',
        '<localleader>tm',
        function() require('dap-python').test_method() end,
        buffer = true,
        ft = 'python',
      },
    },
    config = function()
      require('dap-python').setup(vim.g.python_host_prog)
      require('dap-python').test_runner = 'pytest'
    end,
  },
}
