return {
  -- integrate notmuch.nvim here?
  'snacks.nvim',
  opts = {
      -- dashboard = {
        -- intergrate w/ github?
        -- example = "github",
        -- enabled = true,
        -- projects/sessions... workspace? diff?
        -- formats = {
        --   key = function(item)
        --     return {
        --       -- would be cool to put key inside circle...
        --       { '[', hl = 'special' },
        --       { item.key, hl = 'key' },
        --       { ']', hl = 'special' },
        --     }
        --   end,
        -- },
        -- email/calendar
        -- voglio bookmarks/project/sessions/MRU (vimwiki/wiki TODO?/most recent TODO? or ones with most priority?) (lsp workspaces)
        -- use it to display new word (at every startup?) every day? and automaticaly add them to anki (maybe use API word of the day or smth...)
        -- sections = {
        --
        --   -- quotes on the sides (either?)
        --   ---@see https://gist.github.com/rootiest/f6a227effc6b87c73923691d6ef92078
        --   -- github issues/jira/TODOs
        --   {
        --     section = 'terminal',
        --     -- See: https://github.com/Ryu0118/Kusa
        --     -- cmd = 'kusa rootiest && sleep 0.2',
        --     cmd = 'fortune',
        --     padding = 0,
        --     height = 14,
        --     width = 120,
        --     indent = 8,
        --   },
        --   { section = 'keys', gap = 1, padding = 1 },
        --   -- { title = "Sessions", padding = 1 },
        --   -- provide mapping to list all sessions/todo/etc...?
        --   -- { section = 'session'},
        --   -- {  icon = " ", title = "Sessions", section = "session", indent = 2, padding = 1 },
        --   {
        --     pane = 2,
        --     icon = ' ',
        --     title = 'MRU',
        --     section = 'recent_files',
        --     indent = 2,
        --     padding = { 2, 14 },
        --   },
        --   {
        --     pane = 2,
        --     icon = ' ',
        --     title = 'Projects',
        --     section = 'projects',
        --     indent = 2,
        --     padding = 2,
        --   },
        --   {
        --     pane = 2,
        --     icon = ' ',
        --     title = 'Git Status',
        --     section = 'terminal',
        --     enabled = function() return Snacks.git.get_root() ~= nil end,
        --     -- enabled = vim.fn.FugitiveGitDir() ~= '',
        --     -- enabled = Snacks.git.get_root(),
        --     -- cmd = 'hub status --short --branch --renames',
        --     cmd = 'git status --short --branch --renames',
        --     padding = 2,
        --     indent = 3,
        --     ttl = 1 * 60, -- Time between git updates
        --   },
        --   { section = 'startup' },
        -- },
      -- },
    }
}
