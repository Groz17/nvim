-- NixOS? https://www.reddit.com/r/neovim/comments/1js35ev/comment/mljpzco/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
-- orgmode w/ tangled sed could substitute this?
return {
  'nhu/patchr.nvim',
  opts = {
    plugins = {
      ['ef-themes.nvim'] = {
        vim.fn.stdpath('config') .. '/lua/plugins/patches/ef-themes-bg-autodetect.patch',
      },
    },
  },
}
