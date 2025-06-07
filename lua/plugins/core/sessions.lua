-- https://github.com/stevearc/resession.nvim
--Use <a-s> to save session (mimics <c-s> for file...)

-- https://github.com/rmagatti/auto-session
-- how to have multiple sessions for same dir in same git branch?
return {
  -- Does it work for temporary files like the ones you create when running nvim with <URL1> <URL2> (URLs as arguments)?
  -- doesn't work with dadbod-ui?
  'olimorris/persisted.nvim',
  -- per startup plugin...
  -- dependencies = { "nvim-telescope/telescope.nvim"},

  keys = {

    -- <leader>s -> sessions
    -- { '<leader>ss',     ':SessionToggle<space>', desc = 'Toggle Session' },
    -- same mapping as unimpaired (y to toggle), nice because y is not a very common letter that may be used in these kinds of mappings
    -- would be cool if it notified...
    { '<leader>st', '<CMD>SessionToggle<CR>', desc = 'Toggle Session' },
    -- same as lsp mappings
    -- would be cool if it notified...
    { '<leader>sj', '<CMD>SessionStart<CR>', desc = 'Start' },
    -- would be cool if it notified...
    { '<leader>sk', '<CMD>SessionStop<CR>', desc = 'Stop Recording' },
    { '<leader>sw', '<CMD>SessionSave<CR>', desc = 'Save Current' },
    -- automatically select if only 1?
    { '<leader>sL', '<CMD>SessionLoad<CR>', desc = 'Load' },
    -- How to make this accept v:count?
    { '<leader>sl', '<CMD>SessionLoadLast<CR>', desc = 'Load Last' },
    -- no tab completion?
    -- doesn't work?
    -- it should open mini.files/explorer/native (in the future)
    { '<leader>sf', ':SessionLoadFromFile<space>', desc = 'Load From File' },
    -- please plugin author, add those...
    -- maybe you can use this instead? https://github.com/nvim-telescope/telescope-project.nvim
    -- { '<leader>sr',     ':SessionRename<CR>',    desc = 'Rename Current Session' },
    -- { '<leader>sr',     ':SessionRename<space>', desc = 'Rename Session' },
    { '<leader>sd', '<CMD>SessionDelete<CR>', desc = 'Delete Current' },
    -- { '<leader>s,', ':Telescope persisted<CR>',      desc = 'List' },
    -- use vim.ui.select?
    -- { '<leader>sl', '<CMD>Telescope persisted<CR>', desc = 'List' },
  },

  -- init = function()
  --     vim.api.nvim_create_autocmd('VimLeavePre', {
  --         callback = function()
  --             require 'persisted'.save()
  --         end,
  --     })
  -- end,
  opts = {
    autostart = false,
    -- put them in config instead of data so I can track them with Git?
    save_dir = vim.fn.stdpath('config') .. '/sessions/', -- directory where session files are saved
    silent = false, -- silent nvim message when sourcing session file
    use_git_branch = true, -- create session files based on the branch of the git enabled repository
    autosave = false, -- automatically save session files when exiting Neovim
    should_autosave = nil, -- function to determine if a session should be autosaved
    -- should_autosave = function()
    --     -- do not autosave if the alpha dashboard is the current filetype
    --     return vim.bo.filetype ~= 'alpha'
    -- end,
    -- way to notify is cwd has session associated???
    autoload = false, -- automatically load the session for the cwd on Neovim startup
    on_autoload_no_session = nil, -- function to run when `autoload = true` but there is no session to load
    -- on_autoload_no_session = function()
    --     vim.notify 'Session Not Exist'
    -- end,
    follow_cwd = true, -- change session file name to match current working directory if it changes
    allowed_dirs = nil, -- table of dirs that the plugin will auto-save and auto-load from
    ignored_dirs = nil, -- table of dirs that are ignored when auto-saving and auto-loading
    -- telescope = {
    --   -- options for the telescope extension
    --   reset_prompt_after_deletion = true, -- whether to reset prompt after session deleted
    --   after_source = function(session)
    --     vim.notify('Loaded session ' .. session.name)
    --   end,
    -- },
  },
  config = function(_, opts)
    require('persisted').setup(opts)

    -- metti tutti i mapping di telescope in config (you can't put them in keys)
    -- a quanto pare questo mapping loada anche il plugin persisted
    -- vim.keymap.set('n', '<leader>s', ':Telescope persisted<CR>', { desc = 'List' })
    -- I don't want to use a whole namespace for just one command
    -- vim.keymap.set('n', '<leader>ss', ':Telescope persisted<CR>', { desc = 'List' })
  end,
}

-- https://github.com/jedrzejboczar/possession.nvim/issues/49
-- https://github.com/jedrzejboczar/possession.nvim/issues/3
-- https://github.com/jedrzejboczar/possession.nvim/issues/17
-- https://github.com/jedrzejboczar/possession.nvim/issues/34
-- https://github.com/jedrzejboczar/possession.nvim/issues/32
-- https://github.com/jedrzejboczar/possession.nvim/issues/22
-- splitting sessions into workspaces (https://github.com/jedrzejboczar/possession.nvim?tab=readme-ov-file)
-- list workspaces with telescope?
-- {
--     'jedrzejboczar/possession.nvim',
--     dependencies = { 'nvim-lua/plenary.nvim' },
--     -- Save & restore nvim-dap breakpoints
--     -- require('telescope').load_extension('possession')
--
--     config = function()
--         require('possession').setup {
--             session_dir = vim.fn.getenv('HOME') .. '/.config/nvim/sessions'
--         }
--         require('telescope').load_extension('possession')
--         vim.keymap.set('n', '<leader>s,','<cmd>Telescope possession list<CR>', {desc = "Telescope list sessions"})
--     end,
--
--     keys = {
--
--         -- <leader>s -> sessions
--         { '<leader>ss',     ':PossessionSave<space>',   desc = 'Save Current Session' },
--         { '<leader>sl',     ':PossessionLoad<CR>',      desc = 'Load Last Session' },
--         { '<leader>sL',     ':PossessionLoad<space>',   desc = 'Load Session' },
--         { '<leader>sr',     ':PossessionRename<CR>',    desc = 'Rename Current Session' },
--         { '<leader>sr',     ':PossessionRename<space>', desc = 'Rename Session' },
--         { '<leader>sc',     ':PossessionClose<CR>',     desc = 'Close Current Session' },
--         { '<leader>sd',     ':PossessionDelete<CR>',    desc = 'Delete Session(s)' },
--         { '<leader>sD',     ':PossessionDelete<space>', desc = 'Delete Session(s)' },
--         -- si -> session info
--         -- last one I guess
--         { '<leader>si',     ':PossessionShow<CR>',      desc = 'Show Session(s)' },
--         { '<leader>sI',     ':PossessionShow<space>',   desc = 'Show Session(s)' },
--         -- | -> lista (dal basso all'alto)
--         { '<leader>s<BAR>', ':PossessionList<CR>',      desc = 'List Sessions' },
--
--         -- How to store Session.vim files in ~/.vim/sessions??? It's annoying to have this file in the current directory
--
--     }
-- }
