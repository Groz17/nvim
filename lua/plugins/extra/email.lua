-- https://www.reddit.com/r/neovim/comments/1i3tpko/introducing_notmuchnvim_readwrite_mail_offline_in/
-- https://github.com/felipec/notmuch-vim
-- https://github.com/soywod/himalaya.vim/blob/master/README.md
-- maybe intergrate with snacks.dashboard?
return {
  {
    -- TODO: support visual mode commands?
    'yousefakbar/notmuch.nvim',
    cmd = { 'Notmuch', 'NmSearch' },
    opts = {
      notmuch_db_path = os.getenv('XDG_DATA_HOME') .. '/mail/',
      -- maildir_sync_cmd = "mbsync personal",
      keymaps = {
        sendmail = '<C-g><C-g>',
      },
    },
    keys = {
      -- Lists available tags in your Notmuch database in a buffer.
      -- for plugins with jut a mapping, use symbols
      { '<f12>m', '<CMD>Notmuch<CR>', desc = 'Launch notmuch landing page' },
      -- { "<leader>n", ":NmSearch<space>", desc = "Notmuch query"},
      {
        '<space><space>',
        ':NmSearch<space>',
        desc = 'Notmuch query',
        ft = { 'notmuch-hello', 'notmuch-threads', 'mail' },
      },

      -- show these mappings in navbar
      { 'l', '<CR>', ft = 'notmuch-hello', remap = true },
      { 'l', '<CR>', ft = 'notmuch-threads', remap = true },
      -- {"h","q", ft = "notmuch-threads", remap = true},
      { 'h', '<c-^>', ft = 'notmuch-threads' },
      { 'h', '<c-^>', ft = 'mail' },
      -- { 'h', '<CMD>bwipeout<CR>', ft = 'notmuch-threads' },
      -- { 'h', '<CMD>bwipeout<CR>', ft = 'mail' },
      -- {"h","q", ft = "mail", remap = true}
    },
  },
  {
    'aliyss/vim-himalaya-ui',
    cmd = {
      'HimalayaUI',
    },
    -- keys = {
    --   { '<f12>m', '<cmd>HimalayaUI<cr>', desc = 'Himalaya UI', },
    -- },
    config = function()
      vim.cmd([[
        augroup lasCR
        au!
        au Filetype himalayaui nmap<buffer>l <cr>
        au Filetype himalayaui nmap<buffer><tab> <cr>
        au Filetype himalaya-email-listing nmap<buffer>l <cr>
        augroup END
        ]])
    end,
  },
}
