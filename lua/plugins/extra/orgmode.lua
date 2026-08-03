-- https://github.com/nvim-orgmode/orgmode/issues/48#issuecomment-884528170
--     ◍ textlsp (keywords: text, latex, org)
-- snacks integration?
-- local ORG_HOME = vim.fn.expand('$XDG_DATA_HOME/org')
-- orgmode.setup_ts_grammar()
return {
  {
    'nvim-orgmode/orgmode',
    dependencies = { 'akinsho/org-bullets.nvim', opts = {} },

    init = function()
      -- vim.keymap.set('n','<space>eo', [[<CMD>tab drop ~/notes/refile.org<cr>]],{desc="Orgfile"})
    end,
    -- event = 'VeryLazy',
    -- ft = { 'org' },
    -- keys = function()
    --   return vim.tbl_values(
    --     require('lazy.core.plugin').values(
    --       require('lazy.core.config').spec.plugins['orgmode'],
    --       'opts',
    --       false
    --     ).mappings.global
    --   )
    -- end,
    opts = {
      --   org_agenda_files = {'~/Dropbox/org/*', '~/my-orgs/**/*'},
      -- org_agenda_files = '~/org/**/*',
org_agenda_files = '~/org/*.org',
org_startup_folded = 'showeverything',
      -- org_default_notes_file = '~/notes/Task.org',
      org_default_notes_file = '~/org/inbox.org',
      ---@see https://github.com/nvim-orgmode/orgmode/discussions/643
      mappings = {
        -- Change everything (but globals) to use local leader for org files
        -- prefix = '<LocalLeader>o',
        prefix = '<LocalLeader>',
        org_toggle_checkbox = false,

        -- NOTE: Have to manually re-specify the globals as they were using the prefix
        global = {
          org_agenda = '<C-c>a',
          org_capture = '<C-c>c',
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
        },
      },
    },
    config = function(_, opts)
      require('orgmode').setup(opts)
      vim.keymap.set(
        { 'n', 'o' },
        '<C-c>@',
        '<cmd>lua require("orgmode.org.text_objects").around_subtree()<cr>'
      )


      local wikipath = vim.fn.expand'~/org/'
    local send_outside = function(--[[space, importanceopts]]f)
      local clipboard = vim.fn.getreg("+", 1, true)
      if vim.tbl_isempty(clipboard) then
        vim.notify('Empty clipboard, aborting...', vim.log.levels.ERROR)
        return
      end

      if string.find(clipboard[1], "http") or string.find(clipboard[1], "%[%[http")then
        if vim.fn.empty(vim.fn.system({ "rg", "-F", (clipboard[1]
            :gsub("^%[%[([^%]]+)%]%[[^%]]*%]%]$", "%1") -- Org link with description
            :gsub("^%[%[([^%]]+)%]%]$", "%1")             -- Org link without description
            :gsub("#.*$", "")),                             -- Remove fragment
            vim.fn.expand('~').. "/org" })) == 0 then
          vim.notify('Clipboard already in wiki...', vim.log.levels.ERROR)
          return
        end
      end
     Snacks.picker.--[[git]]files ({
          cwd = wikipath,
          layout = { fullscreen = true,preview=false },
          title = "Send clipboard to "..f,
        cmd = 'fd',
        args = { "--type", "f", "--strip-cwd-prefix", '^(' .. f .. [[(\.org|\.txt)$|tasks|bookmarks\.org)]], },
        on_close = function() vim.schedule(function()
          vim.cmd'q'
        end) end,
        on_show = function() vim.cmd'startinsert' end,
        confirm = function(picker, item)
            local path = wikipath .. item.file

	    if f == "todo" then
	       clipboard[1] = "* TODO " .. clipboard[1]
	    end
            vim.fn.writefile(vim.list_extend({ '' }, clipboard), path, 'a')

          vim.fn.jobstart({
            "sh",
            "-c",
            [[
    dunstify -A "open,Open" -a neovim "Sent clipboard to $1" "$2" | grep -q 2 &&
    emacsclient -c -a '' --eval "(progn (find-file (expand-file-name \"~/org/$1\")) (goto-char (point-max)))"
  ]],
            "sh",
            vim.fn.fnamemodify(path, [[:~:s?\~/org/??]]),
            vim.trim(vim.fn.join(clipboard, "\n")),
          }, { detach = true })
          picker:close()
        end,
      })
    end


    vim.keymap.set('n', '<leader>Qd', function() send_outside('todo') end, { desc = "Go to Wiki file" })
    vim.keymap.set('n', '<leader>Qy', function() send_outside('data') end, { desc = "Go to Wiki file" })
    vim.keymap.set({'n'--[[,'x']]}, 'vsw', function() Snacks.picker.grep_word { cwd = "~/org/wiki", regex = false } end, { desc = "Search word in Wiki" })
    vim.keymap.set('n', 'vsu', function() Snacks.picker.grep { cwd = "~/org", search = vim.fn.getline('.'):match( 'http%S+'),regex = false } end, { desc = "Search URL in Wiki" })
    vim.keymap.set('n', 'vsc', function()Snacks.picker.grep {cwd = "~/org", search = vim.fn.trim(vim.fn.getreg('"')), regex = false} end, { desc = "Search clipboard in Wiki" })
    vim.keymap.set('n', 'vsh', function() Snacks.picker.grep { cwd = "~/org", search = '^# .*', glob = { 'data*.org' } } end, { desc = "Search Headers in Data" })

    end,
    -- vim.lsp.enable('org')
  },
  {
    'chipsenkbeil/org-roam.nvim',
    cond = false,
    tag = '0.1.1',
    dependencies = {
      {
        'nvim-orgmode/orgmode',
        tag = '0.3.7',
      },
    },
    config = function()
      require('org-roam').setup({
        directory = '~/orgfiles/roam',
        -- optional
        -- org_files = {
        --   "~/another_org_dir",
        --   "~/some/folder/*.org",
        --   "~/a/single/org_file.org",
        -- }
      })
    end,
  },
  {
    'hamidi-dev/org-list.nvim',
    dependencies = {
      'tpope/vim-repeat', -- for repeatable actions with '.'
    },
    keys = { { '<localleader>-', ft = 'org' } },
    opts = {
      mapping = {
        -- same as c-c - in emacs
        key = '<localleader>-',
      },
    },
  },
}
