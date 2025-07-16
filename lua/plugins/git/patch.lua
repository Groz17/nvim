-- NixOS? https://www.reddit.com/r/neovim/comments/1js35ev/comment/mljpzco/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
return {
  'nhu/patchr.nvim',
  cond=false,
  ---@type patchr.config
  opts = {
    plugins = {
      -- ['generic_plugin.nvim'] = {
      --   '/path/to/you/git.patch',
      --   '/path/to/you/other/git.patch',
      -- },
    },
  },
}
