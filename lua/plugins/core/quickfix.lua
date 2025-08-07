-- editing quickfix list should really be the default (similar to ^x^q in dired)

-- https://github.com/wsdjeg/quickfix.nvim
-- https://github.com/ten3roberts/qf.nvim
return {
  {
    -- Would be nice to save a range of file with {range}w, for ex .w for current file
    -- https://github.com/gabrielpoca/replacer.nvim
    "Olical/vim-enmasse",
    ft = 'qf',
    pin = true
  },
{
  'stevearc/quicker.nvim',
  cond=false,
  event = "FileType qf",
  ---@module "quicker"
  ---@type quicker.SetupOptions
  opts = {number=true, constrain_cursor=true},
},


  -- how to position quickfix list on top of window?
  --
  -- Se solo fzf.vim avesse un comando :Quickfix simile a :Buffers...
  -- use {'kevinhwang91/nvim-bqf', ft = 'qf'}

  {
    -- possible to use telescope instead of fzf using zf?
    'kevinhwang91/nvim-bqf',
    cond=false,
    init = function()
--  ╭──────────────────────────────────────────────────────────╮
--  │ Format new quickfix                                      │
--  ╰──────────────────────────────────────────────────────────╯
      local fn = vim.fn

      function _G.qftf(info)
        local items
        local ret = {}
        -- The name of item in list is based on the directory of quickfix window.
        -- Change the directory for quickfix window make the name of item shorter.
        -- It's a good opportunity to change current directory in quickfixtextfunc :)
        --
        -- local alterBufnr = fn.bufname('#') -- alternative buffer is the buffer before enter qf window
        -- local root = getRootByAlterBufnr(alterBufnr)
        -- vim.cmd(('noa lcd %s'):format(fn.fnameescape(root)))
        --
        if info.quickfix == 1 then
          items = fn.getqflist({ id = info.id, items = 0 }).items
        else
          items = fn.getloclist(info.winid, { id = info.id, items = 0 }).items
        end
        -- dynamic limit based on max lenght of entries?
        local limit = 73
        local fnameFmt1, fnameFmt2 = '%-' .. limit .. 's', '…%.' .. (limit - 1) .. 's'
        local validFmt = '%s │%5d:%-3d│%s %s'
        for i = info.start_idx, info.end_idx do
          local e = items[i]
          local fname = ''
          local str
          if e.valid == 1 then
            if e.bufnr > 0 then
              fname = fn.bufname(e.bufnr)
              if fname == '' then
                fname = '[No Name]'
              else
                fname = fname:gsub('^' .. vim.env.HOME, '~')
              end
              -- char in fname may occur more than 1 width, ignore this issue in order to keep performance
              if #fname <= limit then
                fname = fnameFmt1:format(fname)
              else
                fname = fnameFmt2:format(fname:sub(1 - limit))
              end
            end
            local lnum = e.lnum > 99999 and -1 or e.lnum
            local col = e.col > 999 and -1 or e.col
            local qtype = e.type == '' and '' or ' ' .. e.type:sub(1, 1):upper()
            str = validFmt:format(fname, lnum, col, qtype, e.text)
          else
            str = e.text
          end
          table.insert(ret, str)
        end
        return ret
      end

      vim.o.qftf = '{info -> v:lua._G.qftf(info)}'

      -- vim.cmd([[
      -- hi BqfPreviewBorder guifg=#3e8e2d ctermfg=71
      -- hi BqfPreviewTitle guifg=#3e8e2d ctermfg=71
      -- hi BqfPreviewThumb guibg=#3e8e2d ctermbg=71
      -- hi link BqfPreviewRange Search
      -- ]])
    end,
    ft = 'qf',
    opts = {
      auto_enable = true,
      auto_resize_height = true,   -- highly recommended enable
      preview = {
        win_height = 12,
        win_vheight = 12,
        wrap = true,
        delay_syntax = 80,
        border = { '┏', '━', '┓', '┃', '┛', '━', '┗', '┃' },
        show_title = false,
        should_preview_cb = function(bufnr, qwinid)
          local ret = true
          local bufname = vim.api.nvim_buf_get_name(bufnr)
          local fsize = vim.fn.getfsize(bufname)
          if fsize > 100 * 1024 then
            -- skip file size greater than 100k
            ret = false
          elseif bufname:match('^fugitive://') then
            -- skip fugitive buffer
            ret = false
          end
          return ret
        end
      },
      -- make `drop` and `tab drop` to become preferred
      func_map = {
        drop = 'o',
        openc = 'O',
        split = '<C-s>',
        tabdrop = '<C-t>',
        -- set to empty string to disable
        tabc = '',
        ptogglemode = 'z,',
        -- how to scroll by only one line? or specified amount of lines?
        -- apparently <A-K> != <A-k>? search documentation on case sensitivity for these <...> mappings
        -- pscrollup = '<A-K>',
        pscrollup = '<A-k>',
        pscrolldown = '<A-j>',
      },
      filter = {
        -- how to use quickfix?
        fzf = {
          action_for = { ['ctrl-s'] = 'split', ['ctrl-t'] = 'tab drop' },
          --  '--delimiter', '│'
          extra_opts = { '--bind', 'ctrl-o:toggle-all', '--prompt', '> ' }
        }
      }
    }
  }

  -- " purtroppo ho dovuto spostare così in basso questa fold perché il plugin non si caricava abbastanza in fretta... config del cazzo che ho
  -- lua << EOF
  --     local bqf_pv_timer
  --     require('bqf').setup {
  --         preview = {
  --             should_preview_cb = function(bufnr, qwinid)
  --                 local bufname = vim.api.nvim_buf_get_name(bufnr)
  --                 if bufname:match '^fugitive://' and not vim.api.nvim_buf_is_loaded(bufnr) then
  --                     if bqf_pv_timer and bqf_pv_timer:get_due_in() > 0 then
  --                         bqf_pv_timer:stop()
  --                         bqf_pv_timer = nil
  --                     end
  --                     bqf_pv_timer = vim.defer_fn(function()
  --                         vim.api.nvim_buf_call(bufnr, function()
  --                             vim.cmd(('do fugitive BufReadCmd %s'):format(bufname))
  --                         end)
  --                         require('bqf.preview.handler').open(qwinid, nil, true)
  --                     end, 60)
  --                 end
  --                 return true
  --             end
  --         }
  --     }
  -- EOF
  --

-- ,'jceb/vim-hier'
}


