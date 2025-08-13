-- cloud from https://prismic.io/blog/gitlab-vs-github

-- how to browse github using gh? maybe sourcegraph?
return {
  {
    -- in cache tieni repo a cui tieni tipo kernel e neovim (per imparare un po' dai pro)
    -- make it clone private repositories as well
    'moyiz/git-dev.nvim',
    cmd = {'GitDevOpen', 'GitDevRecents', 'GitDevCleanAll' },
    opts = {
      -- maybe delete after 10 repos? config option?
      ephemeral = false,
      history = {
        n = math.huge
      },
      cd_type = 'tab',
      opener = function(dir)
        vim.cmd('tabnew')
        require('mini.files').open(vim.fn.fnameescape(dir))
        -- require('oil').open_float()
      end,
    },
    config = function(_, opts)
      require('git-dev').setup(opts)
      -- require('telescope').load_extension('git_dev')
    end,
    keys = {
      {
        '<leader>go',
        function()
          local repo = vim.fn.input('Repository name / URI: ')
          if repo ~= '' then require('git-dev').open(repo) end
        end,
        desc = '[O]pen a remote git repository',
      },
      -- BUG: lazy should take the command's description, this is redundancy...
      { '<leader>gO', '<CMD>GitDevRecents<CR>', desc = 'Revisit previously opened repositories.' },
    },
  },
  {
    -- TODO: usa localleader instead of leader... (add PR)
    -- TODO: use a repo config in opts if you're working for a long time for a single repo? or just a octo.json or something local config?
    -- gist create???
    -- put all issues in quickfix/location list???
    -- interactive graphql editor? with tab completion for tihub?
    -- magari usa v:count per open/closed/etc...?
    -- https://cli.github.com/manual/gh_search_commits???
    -- integrate with lazygit? o mapping?
    'pwntester/octo.nvim',
    -- get inspired by forge emacs plugin?
    -- BUG: list of emojis is messed up
    -- make it support URLS as well (to search issues)
    -- make startinsert optional...
    -- add mapping inside fzf-lua to filter by closed, open, etc...
    cmd = 'Octo',
    -- list of frequently visited repos???
    dependencies = {
      'nvim-lua/plenary.nvim',
      'echasnovski/mini.icons',
    },
    -- keys ={}, -- consider using <leader>go (o di octo)
    -- Add pr to add which-key bindings for every prefix like <localleader>{a,i}, etc...
    -- transient window?
    keys = {
      -- imitate fugitive/telescope-github/git-dev?
      { "<leader>gX", "<cmd>Octo repo browser<cr>", desc = "Open in Browser" },
      -- { "<leader>gu", "<cmd>Octo repo url<cr>", desc = "Copy Repo Url" },
      { "<leader>gY", "<cmd>Octo repo url<cr>", desc = "Copy Repo Url" },
      -- { mode = { 'n', 'x' }, '<Leader>gX', ':GBrowse<space>', desc = 'Open [args] browser' },
      -- how to add repo as argument?
      -- { "<leader>gO", ":Octo<space>", desc = "Github Open" },
      -- { "<leader>gO", function() require("octo.commands").octo("repo="..vim.fn.input("Repo: >")) end , desc = "Github Open" },
      -- { "<leader>gopl", "<cmd>Octo pr list<cr>", desc = "Github Pull-request List" },
        -- maps.n[prefix .. "x"] = { "<Cmd>Octo actions<CR>", desc = "Run an action" }

    -- TODO: find better mappings...
    { "<a-s-x>", "<cmd>Octo<CR>", desc = "Open Octo", ft = 'octo' },
    },
    opts = {
      enable_builtin = true,
      picker = 'snacks',
      picker_config = {
        use_emojis = true,
      },
      -- usa stessi mapping (demicolon) (shift) maybe add PR?
      mappings = {
        issue = {
          -- maybe don't map (kanata)
          next_comment = { lhs = ")", desc = "go to next comment" },
          prev_comment = { lhs = "(", desc = "go to previous comment" },
        },
        pull_request = {
          next_comment = { lhs = ")", desc = "go to next comment" },
          prev_comment = { lhs = "(", desc = "go to previous comment" },
        },
      },
      review_thread = {
        next_comment = { lhs = ")", desc = "go to next comment" },
        prev_comment = { lhs = "(", desc = "go to previous comment" },
      },
      review_diff = {
        next_thread = { lhs = ")", desc = "move to next thread" },
        prev_thread = { lhs = "(", desc = "move to previous thread" },
      },
    },
    config = function(_,opts)
      require'octo'.setup(opts)
    end
  }
}
--  ╭──────────────────────────────────────────────────────────╮
--  │                          Gists                           │
--  ╰──────────────────────────────────────────────────────────╯
-- https://github.com/rawnly/gist.nvim
