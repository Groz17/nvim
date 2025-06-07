-- like intellij
-- vim.keymap.set('n','<a-1>',vim.cmd.Lex)
-- add mappings for options, autocmd, lsp, (dirs) etc...
-- open terminal in cwd?
-- https://github.com/preservim/nerdtree#can-nerdtree-access-remote-files-via-scp-or-ftp
-- how to exit with esc?
-- it supports v:count with l
return {
  {
    -- how to sincronize with ZZ or :wq<CR>???
    -- how to open all files in a dir? visually select them and then?
    -- makes it so l exists...
    -- crea mapping per aprire directory in yazi.nvim?
    -- how to make it work with gf/gF?
    -- guarda post reddit per config git + fullscreen?
    -- TODO: call also when argc=0???
    -- please add image preview (for CodeSnap screenshots)
    -- use some tool to convert a PDF to PNG. 
    'echasnovski/mini.files',
    -- lazy = false,
    opts = {
      content = {
        -- filter = function(fs_entry)
        --   return not vim.startswith(fs_entry.name, ".")
        -- end,
      },
      mappings = {
        -- FIX: doesn't work...
        -- you can use macro here right?
        -- https://github.com/echasnovski/mini.nvim/issues/1309
        -- close       = {'<esc>','q'},
        close = '<esc>',
        go_in       = 'L',
        go_in_plus  = 'l',
        go_out      = 'H',
        -- wanna use macrooos
        go_out_plus = 'h',
      },
      options = {
        permanent_delete = false,
      },

      windows = {
        preview = true,
        -- TODO: make the height <= focused window?
        width_preview = 50,
      },
    },
    keys = {
      { -- Oil has key "mk", copy <leader>fm to "ml"
        -- "ml",
        -- "-",
        -- ee -> edit generic file
        -- ee -> cwd?
        -- '<leader>ee',
        -- like doom emacs
        -- <leader>: for workspace
        -- '<space>.',
        -- '<f12><c-f>',
        '<f12><c-j>',
        function()
          -- require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
          -- if not require("mini.files").close() then require("mini.files").open(vim.api.nvim_buf_get_name(0), true) end
          -- require("mini.files").open(nil,false)
          -- TODO: how to open if file doesn't exists (just deleted for example)? (maybe just parent directory)
          local ok,_ = pcall(require('mini.files').open,vim.api.nvim_buf_get_name(0), false)
          if not ok then require('mini.files').open(vim.fn.expand('%:p:h'), false)
 end
        end,
        desc = 'Open mini.files (directory of current file)',
      },
    },
    config = function(_, opts)
      require('mini.files').setup(opts)
      local map_split = function(buf_id, lhs, direction)
        local rhs = function()
          -- Make new window and set it as target
          local new_target_window
          vim.api.nvim_win_call(MiniFiles.get_explorer_state().target_window, function()
            vim.cmd(direction .. ' split')
            new_target_window = vim.api.nvim_get_current_win()
          end)

          MiniFiles.set_target_window(new_target_window)
        end

        -- Adding `desc` will result into `show_help` entries
        local desc = 'Split ' .. direction
        vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
      end

      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        callback = function(args)
          local buf_id = args.data.buf_id
          -- Tweak keys to your liking
          -- map_split(buf_id, 'gs', 'belowright horizontal')
          map_split(buf_id, '<c-w><c-f>', 'belowright horizontal')
          map_split(buf_id, '<c-w>f', 'belowright horizontal')
          -- maybe uppercase F for vertical?
          -- map_split(buf_id, 'gv', 'belowright vertical')
        end,
      })

      -- doesn't work
      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesActionRename",
        callback = function(event)
          Snacks.rename.on_rename_file(event.data.from, event.data.to)
        end,
      })

    local files_grug_far_replace = function(path)
      -- works only if cursor is on the valid file system entry
      local cur_entry_path = MiniFiles.get_fs_entry().path
      local prefills = { paths = vim.fs.dirname(cur_entry_path) }

      local grug_far = require "grug-far"

      -- instance check
      if not grug_far.has_instance "explorer" then
        grug_far.open {
          instanceName = "explorer",
          prefills = prefills,
          staticTitle = "Find and Replace from Explorer",
        }
      else
        grug_far.open_instance "explorer"
        -- updating the prefills without crealing the search and other fields
        grug_far.update_instance_prefills("explorer", prefills, false)
      end
    end

    -- would be nice to use visual mode or mark files and then use mapping...
    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesBufferCreate",
      callback = function(args)
        vim.keymap.set("n", "gs", files_grug_far_replace, { buffer = args.data.buf_id, desc = "Search in directory" })
      end,
    })
-- https://github.com/echasnovski/mini.nvim/blob/848c5e8f428faf843051768e0d56104cd02aea1f/doc/mini-files.txt#L522-L537
  local set_mark = function(id, path, desc)
    MiniFiles.set_bookmark(id, path, { desc = desc })
  end
  vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesExplorerOpen',
    callback = function()
      -- code duplication (ripeto sempre le stess dirs (anche per fzf-lua/telescope))
      set_mark('v', vim.fn.stdpath('config'), 'Neovim Config') -- path
      set_mark('c', vim.fn.getenv('HOME') .. '/.config', 'Config') -- path
      -- TODO: how to get dir when vim was run from?
      set_mark('w', vim.fn.getcwd, 'Working directory') -- callable
      set_mark('~', '~', 'Home directory')
      -- set_mark('i', '~/Pictures/Code', 'Screenshots')

      -- set_mark('d', vim.fn.getenv('BACKUP_DIR'), 'HDD directory')
      -- TODO: app 'p' mark for current project cwd (neovim api, plz add function to get that path) (also for rooter functio)
      -- set_mark('p', vim.fs.dirname(vim.fs.find({ '.git', 'Makefile' }, { path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)), upward = true })[1]), 'Root directory')
      -- nevermind, it's just w
    end,
  })

    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesActionRename",
      callback = function(event)
        Snacks.rename.on_rename_file(event.data.from, event.data.to)
      end,
    })

  local map_split = function(buf_id, lhs, direction)
    local rhs = function()
      -- Make new window and set it as target
      local cur_target = MiniFiles.get_explorer_state().target_window
      local new_target = vim.api.nvim_win_call(cur_target, function()
        vim.cmd(direction .. ' split')
        return vim.api.nvim_get_current_win()
      end)

      MiniFiles.set_target_window(new_target)

      -- This intentionally doesn't act on file under cursor in favor of
      -- explicit "go in" action (`l` / `L`). To immediately open file,
      -- add appropriate `MiniFiles.go_in()` call instead of this comment.
    end

    -- Adding `desc` will result into `show_help` entries
    local desc = 'Split ' .. direction
    vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
  end

  vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesBufferCreate',
    callback = function(args)
      local buf_id = args.data.buf_id
      -- Tweak keys to your liking
      map_split(buf_id, '<C-s>', 'belowright horizontal')
      map_split(buf_id, '<C-v>', 'belowright vertical')
    end,
  })end},
  {
    -- duckdb
-- https://www.reddit.com/r/neovim/comments/1k3tro0/if_youre_using_yaziyazinvim_i_have_a_plugin_for/
    -- - hint: execute the following command to see your configuration: > :lua =require('yazi').config
    "mikavilpas/yazi.nvim",
    -- lazy = false,
    cond = true,
    -- event = "VeryLazy",
    opts = {
      open_for_directories = true,
    },

    keys = {
        { "<leader>ey", "<cmd>Yazi<CR>", desc = "Open Yazi" },
      },
    }
    -- {
      --   'stevearc/oil.nvim',
      --   cond=false,
      --   opts = {},
      -- Optional dependencies
      -- dependencies = { "nvim-tree/nvim-web-devicons" },
      -- }
}
