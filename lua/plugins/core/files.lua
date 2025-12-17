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
      desc = "Current file's directory",
    },
    {
      '<f12>pD',
      function () require('mini.files').open(Snacks.git.get_root(), false) end,
      desc = "Root's directory",
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

-- -- https://github.com/nvim-mini/mini.nvim/discussions/2173
-- Window width based on the offset from the center, i.e. center window
-- is 60, then next over is 20, then the rest are 10.
-- Can use more resolution if you want like { 60, 20, 20, 10, 5 }
local widths = { 60, 20, 10 }

local ensure_center_layout = function(ev)
    local state = MiniFiles.get_explorer_state()
    if state == nil then return end

    -- Compute "depth offset" - how many windows are between this and focused
    local path_this = vim.api.nvim_buf_get_name(ev.data.buf_id):match('^minifiles://%d+/(.*)$')
    local depth_this
    for i, path in ipairs(state.branch) do
        if path == path_this then depth_this = i end
    end
    if depth_this == nil then return end
    local depth_offset = depth_this - state.depth_focus

    -- Adjust config of this event's window
    local i = math.abs(depth_offset) + 1
    local win_config = vim.api.nvim_win_get_config(ev.data.win_id)
    win_config.width = i <= #widths and widths[i] or widths[#widths]

    win_config.col = math.ceil(0.5 * (vim.o.columns - widths[1]))
    for j = 1, math.abs(depth_offset) do
        local sign = depth_offset == 0 and 0 or (depth_offset > 0 and 1 or -1)
        -- widths[j+1] for the negative case because we don't want to add the center window's width 
        local prev_win_width = (sign == -1 and widths[j+1]) or widths[j] or widths[#widths]
        -- Add an extra +2 each step to account for the border width
        win_config.col = win_config.col + sign * (prev_win_width + 2)
    end

    win_config.height = depth_offset == 0 and 25 or 20
    win_config.row = math.ceil(0.5 * (vim.o.lines - win_config.height))
    win_config.border = { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" }
    vim.api.nvim_win_set_config(ev.data.win_id, win_config)
end

vim.api.nvim_create_autocmd("User", {pattern = "MiniFilesWindowUpdate", callback=ensure_center_layout})
  end,
}
