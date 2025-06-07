-- https://github.com/Jezda1337/nvim-html-css (lsp should do the work right?)
return {
  {
    'vuki656/package-info.nvim',
    requires = 'MunifTanjim/nui.nvim',
    -- bufreadpre diff?
    event = 'BufEnter package.json',
  -- cmd = ':Telescope package_info',
  -- stylua: ignore start
  keys = {
    -- CRUD
    { '<localleader>i', "<cmd>lua require('package-info').install()<cr>", ft = 'json', buffer = true, desc ="Install New Dependency" },
    { '<localleader>c', "<cmd>lua require('package-info').change_version()<cr>", ft = 'json', buffer = true, desc ="Install Different Version" },
    { '<localleader>s', "<cmd>lua require('package-info').show()<cr>", ft = 'json', buffer = true, desc = "Show dependency versions" },
    { '<localleader>S', "<cmd>lua require('package-info').show({force=true},)<cr>", ft = 'json', buffer = true, desc = "Show dependency versions(Force re-fetching)" },
    { '<localleader>h', "<cmd>lua require('package-info').show()<cr>", ft = 'json', buffer = true, desc = "Hide dependency versions" },
    { '<localleader>u', "<cmd>lua require('package-info').update()<cr>", ft = 'json', buffer = true, desc = "Update dependency" },
    { '<localleader>d', "<cmd>lua require('package-info').delete()<cr>", ft = 'json', buffer = true, desc = "Delete Dependency" },
  },
    -- stylua: ignore end
    opts = {},
  },
{
  'mattn/emmet-vim',
  ft = {'html','css'},
  init = function() vim.g.user_emmet_leader_key = ',' end,
}
}
