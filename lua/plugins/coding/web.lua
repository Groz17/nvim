-- https://github.com/Jezda1337/nvim-html-css (lsp should do the work right?)
return {
  {
    'vuki656/package-info.nvim',
    requires = 'MunifTanjim/nui.nvim',
    -- bufreadpre diff?
    event = 'BufEnter package.json',
  -- cmd = ':Telescope package_info',
  -- stylua: ignore start
  config = function(_,opts)
    require'which-key'.add({'<localleader>p', group = "package-info", buffer = true})
    -- CRUD
    vim.keymap.set('n', '<localleader>pi', "<cmd>lua require('package-info').install()<cr>", {buffer = true, desc ="Install New Dependency" })
    vim.keymap.set('n', '<localleader>pc', "<cmd>lua require('package-info').change_version()<cr>", {buffer = true, desc ="Install Different Version" })
    vim.keymap.set('n', '<localleader>ps', "<cmd>lua require('package-info').show()<cr>", {buffer = true, desc = "Show dependency versions" })
    vim.keymap.set('n', '<localleader>pS', "<cmd>lua require('package-info').show({force=true})<cr>", {buffer = true, desc = "Show dependency versions(Force re-fetching)" })
    vim.keymap.set('n', '<localleader>ph', "<cmd>lua require('package-info').show()<cr>", {buffer = true, desc = "Hide dependency versions" })
    vim.keymap.set('n', '<localleader>pu', "<cmd>lua require('package-info').update()<cr>", {buffer = true, desc = "Update dependency" })
    vim.keymap.set('n', '<localleader>pd', "<cmd>lua require('package-info').delete()<cr>", {buffer = true, desc = "Delete Dependency" })
  end,
    -- stylua: ignore end
    opts = {},
  },
{
  'mattn/emmet-vim',
  ft = {'html','css'},
  init = function() vim.g.user_emmet_leader_key = ',' end,
}
}
