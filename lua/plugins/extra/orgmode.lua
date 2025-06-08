-- https://github.com/nvim-orgmode/orgmode/issues/48#issuecomment-884528170
-- snacks integration?
-- local ORG_HOME = vim.fn.expand('$XDG_DATA_HOME/org')
-- orgmode.setup_ts_grammar()
return{{
  'nvim-orgmode/orgmode',
  init = function()
    vim.keymap.set('n','<space>eo', [[<CMD>tab drop ~/orgfiles/refile.org<cr>]],{desc="Orgfile"})
  end,
  event = "VeryLazy",
  ft = { 'org' },
  keys = function()
    return vim.tbl_values(require("lazy.core.plugin").values(require("lazy.core.config").spec.plugins["orgmode"], "opts", false).mappings.global)
  end,
  opts={
    --   org_agenda_files = {'~/Dropbox/org/*', '~/my-orgs/**/*'},
    org_agenda_files = '~/orgfiles/**/*',
    org_default_notes_file = '~/orgfiles/refile.org',
    ---@see https://github.com/nvim-orgmode/orgmode/discussions/643
    mappings = {
      -- Change everything (but globals) to use local leader for org files
      -- prefix = '<LocalLeader>o',
      prefix = '<LocalLeader>',

      -- NOTE: Have to manually re-specify the globals as they were using the prefix
      global = {
        -- org_agenda  = '<leader>W',
        -- org_capture = '<leader>w',
      },

      -- NOTE: This isn't using the prefix, but instead <Leader>, so we change it explicitly
      -- in insert mode though?
      org = {
        org_meta_return = '<LocalLeader><CR>',
      },

        text_objects = {
        inner_subtree = 'iR',
        around_subtree = 'aR',
        }
    },
  },
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
  opts = {
    mapping = {
      -- same as c-c - in emacs
      key = "<localleader>-"
    },

  },
}
}
