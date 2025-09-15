-- like intellij
-- vim.keymap.set('n','<a-1>',vim.cmd.Lex)
-- add mappings for options, autocmd, lsp, (dirs) etc...
-- open terminal in cwd?
-- https://github.com/preservim/nerdtree#can-nerdtree-access-remote-files-via-scp-or-ftp
-- it supports v:count with l
return {
  -- how to sincronize with ZZ or :wq<CR>???
  -- how to open all files in a dir? visually select them and then?
  -- makes it so l exists...
  -- crea mapping per aprire directory in yazi.nvim?
  -- how to make it work with gf/gF?
  -- guarda post reddit per config git + fullscreen?
  -- TODO: call also when argc=0???
  -- please add image preview (for CodeSnap screenshots)
  -- use some tool to convert a PDF to PNG.
  'nvim-mini/mini.files',
  lazy = false,
  cmd = 'Dired',
  opts = {
    use_as_default_explorer = true,
    content = {
      -- filter = function(fs_entry)
      --   return not vim.startswith(fs_entry.name, ".")
      -- end,
    },
    mappings = {
      -- FIX: doesn't work...
      -- you can use macro here right?
      -- https://github.com/nvim-mini/mini.nvim/issues/1309
      -- close       = {'<esc>','q'},
      -- close       = '<esc>',
      close       = '<c-g>',
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
    {
      '<f12><c-j>', -- dired-jump
      function()
        local ok, _ = pcall(require('mini.files').open, vim.api.nvim_buf_get_name(0), false)
        if not ok then
          require('mini.files').open(vim.fn.expand('%:p:h'), false)
        end
      end,
      desc = 'mini.files (directory of current file)',
    },
    {
      '<f12>pD',
      function () require('mini.files').open(Snacks.git.get_root(), false) end,
      desc = 'mini.files (Root)',
    },
  },
  config = function(_, opts)
    require('mini.files').setup(opts)
    -- emacs to vim: capitalize commands and camel case
    vim.api.nvim_create_user_command("DiredJump",[[exe "norm \<f12>\<c-j>"]],{})
    local map_split = function(buf_id, lhs, direction)
      local rhs = function()
        -- Make new window and set it as target
        local new_target_window
        vim.api.nvim_win_call(MiniFiles.get_explorer_state().target_window, function()
          vim.cmd(direction .. ' split')
          new_target_window = vim.api.nvim_get_current_win()
        end)

        MiniFiles.set_target_window(new_target_window)
        MiniFiles.go_in()
        MiniFiles.close()
      end

      -- Adding `desc` will result into `show_help` entries
      local desc = 'Split ' .. direction
      vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
    end

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      callback = function(args)
        local buf_id = args.data.buf_id
        -- map_split(buf_id, 'O', 'belowright horizontal')
        -- map_split(buf_id, 'o', 'belowright vertical')
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
        grug_far.get_instance('explorer'):open()
        -- updating the prefills without crealing the search and other fields
        grug_far.get_instance('explorer'):update_input_values(prefills, false)
      end
    end

    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesBufferCreate",
      callback = function(args)
        vim.keymap.set("n", "gs", files_grug_far_replace, { buffer = args.data.buf_id, desc = "Search in directory" })
      end,
    })
    -- https://github.com/nvim-mini/mini.nvim/blob/848c5e8f428faf843051768e0d56104cd02aea1f/doc/mini-files.txt#L522-L537
    local set_mark = function(id, path, desc)
      MiniFiles.set_bookmark(id, path, { desc = desc })
    end
    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesExplorerOpen',
      callback = function()
        -- code duplication (ripeto sempre le stess dirs (anche per fzf-lua/telescope))
        set_mark('v', vim.fn.stdpath('config'), 'Neovim Config')   -- path
        set_mark('c', vim.fn.getenv('HOME') .. '/.config', 'Config') -- path
        -- TODO: how to get dir when vim was run from?
        set_mark('w', vim.fn.getcwd, 'Working directory')          -- callable
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

  end,
}
