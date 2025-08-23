-- https://github.com/nvim-orgmode/orgmode/issues/48#issuecomment-884528170
--     ◍ textlsp (keywords: text, latex, org)
-- snacks integration?
-- local ORG_HOME = vim.fn.expand('$XDG_DATA_HOME/org')
-- orgmode.setup_ts_grammar()
return{
  {
  'nvim-orgmode/orgmode',
  dependencies = {'akinsho/org-bullets.nvim', opts={},},

  init = function()
    vim.keymap.set('n','<space>eo', [[<CMD>tab drop ~/notes/refile.org<cr>]],{desc="Orgfile"})
  end,
  event = "VeryLazy",
  ft = { 'org' },
  keys = function()
    return vim.tbl_values(require("lazy.core.plugin").values(require("lazy.core.config").spec.plugins["orgmode"], "opts", false).mappings.global)
  end,
  opts={
    --   org_agenda_files = {'~/Dropbox/org/*', '~/my-orgs/**/*'},
    org_agenda_files = '~/notes/**/*',
    -- org_default_notes_file = '~/notes/Task.org',
    org_default_notes_file = '~/notes/refile.org',
    ---@see https://github.com/nvim-orgmode/orgmode/discussions/643
    mappings = {
      -- Change everything (but globals) to use local leader for org files
      -- prefix = '<LocalLeader>o',
      prefix = '<LocalLeader>',

      -- NOTE: Have to manually re-specify the globals as they were using the prefix
      global = {
        org_agenda  = '<f15>a',
        org_capture = '<f15>c',
      },

      -- NOTE: This isn't using the prefix, but instead <Leader>, so we change it explicitly
      -- in insert mode though?
      org = {
        org_meta_return = '<m-cr>',
        org_next_visible_heading = false,
        org_previous_visible_heading = false,
      },

        text_objects = {
        inner_subtree = 'iR',
        around_subtree = 'aR',
        }
    },
  },
  config = function(_, opts)
    require'orgmode'.setup(opts)
    vim.keymap.set({"n","o"},"<f15>@",'<cmd>lua require("orgmode.org.text_objects").around_subtree()<cr>')
  end
},
{
  "chipsenkbeil/org-roam.nvim",
  cond=false,
  tag = "0.1.1",
  dependencies = {
    {
      "nvim-orgmode/orgmode",
      tag = "0.3.7",
    },
  },
  config = function()
    require("org-roam").setup({
      directory = "~/orgfiles/roam",
      -- optional
      -- org_files = {
      --   "~/another_org_dir",
      --   "~/some/folder/*.org",
      --   "~/a/single/org_file.org",
      -- }
    })
  end
},
{
  "hamidi-dev/org-list.nvim",
  dependencies = {
    "tpope/vim-repeat",  -- for repeatable actions with '.'
  },
  keys = {{ '<localleader>-', ft = 'org' }},
  opts = {
    mapping = {
      -- same as c-c - in emacs
      key = "<localleader>-"
    },

  },
}
}
