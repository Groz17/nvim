-- https://www.reddit.com/r/neovim/comments/1ij3oqa/kubectlnvim_lineage_feature/
-- https://github.com/kezhenxu94/kube.nvim
return {
  'Ramilito/kubectl.nvim',
  cond = false, -- impara docker prima
  opts = {},
  cmd = { 'Kubectl', 'Kubectx', 'Kubens' },
  keys = {
    { '<space>k', '<cmd>lua require("kubectl").toggle()<cr>' },
    { '<C-k>', '<Plug>(kubectl.kill)', ft = 'k8s_*' },
    { '7', '<Plug>(kubectl.view_nodes)', ft = 'k8s_*' },
    { '8', '<Plug>(kubectl.view_overview)', ft = 'k8s_*' },
    { '<C-t>', '<Plug>(kubectl.view_top)', ft = 'k8s_*' },
  },
}
