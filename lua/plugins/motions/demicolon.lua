-- also make this work for stuff like zj, zk
  return{
    'mawkler/demicolon.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    -- Can't be lazy otherwise doesn't work with gitsigns
    -- keys = {'(',')'},
    opts = {
      keymaps = {
        horizontal_motions = false,
        repeat_motions = 'stateful',
      },
    },
  }
