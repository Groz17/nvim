-- https://www.reddit.com/r/neovim/comments/1i3tpko/introducing_notmuchnvim_readwrite_mail_offline_in/
-- https://github.com/felipec/notmuch-vim
-- https://github.com/soywod/himalaya.vim/blob/master/README.md
-- maybe intergrate with snacks.dashboard?
return {
  {
    -- TODO: support visual mode commands?
    -- show "last synced ... on top?"
    -- tree view w/ tags on the side?
    'yousefakbar/notmuch.nvim',
    cmd = { 'Notmuch', 'NmSearch', 'Inbox','NmSync', 'ComposeMail' },
    opts = {
      notmuch_db_path = os.getenv('XDG_DATA_HOME') .. '/mail/',
      -- maildir_sync_cmd = "mbsync personal",
      keymaps = {
        sendmail = '<C-g><C-g>',
      },
    },
    keys = {
      { '<c-c>m', '<CMD>Notmuch<CR>', desc = 'Launch notmuch landing page' },
      { '<f12>m', '<CMD>ComposeMail<CR>', desc = 'Compose Mail' },
      {
        '<c-s>', -- Can't be in insert mode when viewing emails (treat <c-s> as "alternative search" mapping)
        ':NmSearch<space>',
        desc = 'Notmuch query',
        ft = { 'notmuch-hello', 'notmuch-threads', 'mail' },
      },

      -- show these mappings in navbar
      { 'l', '<CR>', ft = 'notmuch-hello', remap = true },
      { 'l', '<CR>', ft = 'notmuch-threads', remap = true },
      { 'h', '<cmd>Notmuch<cr>', ft = 'notmuch-threads' },
      -- show diff/git-like tracking for emails?
      { 'h', '<c-^>', ft = 'mail' },
    },
  },
}
