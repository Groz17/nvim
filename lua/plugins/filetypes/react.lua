return {
  'napmn/react-extract.nvim',
  config = function(_,opts)
    require'react-extract'.setup(opts)
    require'which-key'.add({'<localleader>r', buffer = true, group = 'react-extract', mode = "x"})
  end,
  opts = {},
  ft = {'javascriptreact', 'typescriptreact'},
  keys = {
    {mode={ "x" }, "<LocalLeader>re", function() require("react-extract").extract_to_new_file() end,  desc = "extract to new file", buffer = true, ft = {'javascriptreact', 'typescriptreact'}},
    {mode={ "x" }, "<LocalLeader>rc", function() require("react-extract").extract_to_current_file() end,  desc = "extract to current file", buffer = true, ft = {'javascriptreact', 'typescriptreact'}},
  }
}
