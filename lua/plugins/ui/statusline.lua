-- https://github.com/dgox16/dotfiles/blob/c46c715eb7d443f6cef15932ea5dbfb0abafed51/.config/nvim/lua/configs/lualine.lua
-- ogni letter key for mode
-- show ft plugins in statusline as a remainder
return {
  {
    'nvim-lualine/lualine.nvim', dependencies = {
       -- { "bezhermoso/todos-lualine.nvim" },
        -- { "folke/todo-comments.nvim" } -- REQUIRED!
      },
    event = { 'BufReadPost', 'BufAdd', 'BufNewFile' },
    -- cond=false,
    config = function()
        -- local todos_file = require("todos-lualine").component({cwd="%"})
        -- local todos_workspace = require("todos-lualine").component({cwd=""})
      -- dividi in 3 sezioni...
      -- local function getLspName()
      --   local bufnr = vim.api.nvim_get_current_buf()
      --   local buf_clients = vim.lsp.get_clients({ bufnr = bufnr })
      --   local buf_ft = vim.bo.filetype
      --   if next(buf_clients) == nil then return '  No servers' end
      --   local buf_client_names = {}
      --
      --   local lint_s, lint = pcall(require, 'lint')
      --   if lint_s then
      --     for ft_k, ft_v in pairs(lint.linters_by_ft) do
      --       if type(ft_v) == 'table' then
      --         for _, linter in ipairs(ft_v) do
      --           if buf_ft == ft_k then
      --             table.insert(buf_client_names, linter)
      --           end
      --         end
      --       elseif type(ft_v) == 'string' then
      --         if buf_ft == ft_k then table.insert(buf_client_names, ft_v) end
      --       end
      --     end
      --   end
      --
      --   local ok, conform = pcall(require, 'conform')
      --   local formatters =
      --     table.concat(conform.list_formatters_for_buffer(), ' ')
      --   if ok then
      --     for formatter in formatters:gmatch('%w+') do
      --       if formatter then table.insert(buf_client_names, formatter) end
      --     end
      --   end
      --
      --   local hash = {}
      --   local unique_client_names = {}
      --
      --   for _, v in ipairs(buf_client_names) do
      --     if not hash[v] then
      --       unique_client_names[#unique_client_names + 1] = v
      --       hash[v] = true
      --     end
      --   end
      --   local language_servers = table.concat(unique_client_names, ', ')
      --
      --   -- return '  ' .. language_servers
      --   return language_servers
      -- end
      --
      -- local lsp = {
      --   function() return getLspName() end,
      -- }

      local lazy = {
        require('lazy.status').updates,
        cond = require('lazy.status').has_updates,
        color = { fg = 'ff9e64' },
      }

      -- ╭─────────────────────────────────────────────────────────╮
      -- │ tabline                                                 │
      -- ╰─────────────────────────────────────────────────────────╯
      -- red circle with register in center?
      local macro = {
        require('noice').api.status.mode.get,
        cond = require('noice').api.status.mode.has,
      }

      local session = {
        function() return 'Session active' end,
        cond = function() return vim.g.persisting end,
      }
      -- remove filename?
      -- so dap is not lazy loaded?
      local debug = {
        function() return '  ' .. require('dap').status() end,
        cond = function()
          return package.loaded['dap'] and require('dap').status() ~= ''
        end,
      }
      local db = {

        function() return ' ' .. vim.fn['db_ui#statusline']() end,
        cond = function()
          if vim.g.loaded_dbui == 1 and vim.fn['db_ui#statusline']() ~= '' then
            return true
          else
            return false
          end
        end,
      }

      local profile = {
        function() return 'Profiling...' end,
        cond = function() return Snacks.profiler.status().cond() ~= false end,
      }

      -- TODO: put in tabline or statusline according to distance line number you're on and tabline/statusline
      local modified_count = {
        -- TODO: code duplication...
        function() return "[+]: ".. vim.api.nvim_eval[[getbufinfo()->filter({_,v->v.changed==1})->filter({_,v->v.bufnr->getbufvar('&modifiable')})->len()]] end,
        -- how to activate only if you switch from a modified buffer?
        -- cond = function() return vim.api.nvim_eval[[getbufinfo()->filter({_,v->v.changed==1})->len()]] ~= 0 and vim.fn.mode() ~= 'i' end,
        cond = function() return vim.api.nvim_eval[[getbufinfo()->filter({_,v->v.changed==1})->filter({_,v->v.bufnr->getbufvar('&modifiable')})->len()]] ~= 0 and vim.fn.mode() ~= 'i' and not vim.tbl_contains(vim.api.nvim_eval[[getbufinfo()->filter({_,v->v.changed==1})->map({ _,v->v.bufnr })]],vim.api.nvim_get_current_buf())end,
        color = { bg = 'ff0000' },
      }

      require('lualine').setup({
        options = {
      -- section_separators = { left = '', right = '' },
      -- component_separators = { left = '', right = '' },
          icons_enabled = true,
          theme = 'auto',
          -- theme = 'shado',
          disabled_filetypes = {
            statusline = {
              'dashboard',
              'alpha',
              'ministarter',
              'snacks_dashboard',
            },
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = true,
        },

        tabline = {
          -- temporary states
          lualine_a = {
            modified_count,
            macro,
            session,
            debug,
            db,
            profile,
          },
          -- so diagnostics line up (how to have fixed-length component?)
          -- imagine them as something u need to get rid of (they're in ur face)
          lualine_b = {
            -- should these go to winbar/non global statusline? for when editing multiple projects
            -- run only if in diagnostic? like root marker? pls neovim introduce this concept... (don't wanna be in ~ using this)
            { 'diagnostics', sources={'nvim_workspace_diagnostic'} },
            -- { 'location' },
            -- also local todos?
            -- {todos_workspace}
          },

          -- magari cambia colore se modified? etc...
          -- don't show encoding if utf-8
          -- lualine_c = { 'filetype', 'encoding'--[[, 'location']] },
          -- lualine_c = { 'buffers' },
          -- lualine_c = {'%=', '%t%m', '%3p'} ,
          -- centra path?
          -- lualine_c = {'%=', '%F%t' } ,
          -- use c-^ for this...
          -- hide current buffer from list?
          lualine_c = {{'buffers',mode=4}},
          -- lualine_c = {
            -- { 'diagnostics', sources={'nvim_workspace_diagnostic'} }
          -- },
          -- lualine_y = { lsp },
          -- tabs/project and windows/local one above the other
          lualine_z = {
            {'tabs',
            -- how to show only if not current tab? i don't want left stuff to shift (can i disable that?)
            show_modified_status = false,
            -- does'nt work
          fmt = function(name, context)
            -- Show + if buffer is modified in tab
            local buflist = vim.fn.tabpagebuflist(context.tabnr)
            local winnr = vim.fn.tabpagewinnr(context.tabnr)
            local bufnr = buflist[winnr]
            local mod = vim.fn.getbufvar(bufnr, '&mod')
            return name .. (mod == 1 and ' +' or '')
          end
        },
      }
        },

        winbar = {
        -- lualine_b = {},

          lualine_a = {
            { 'diagnostics', sources={'nvim_diagnostic'} },
            -- sposto per ultima xke refresha
            -- { todos_file },
            -- TODO: repo diff? in tabline
            {'diff'},
        },

              -- like git fugitive commit:file
              -- per vimwiki files don't show vimwiki? also show paren dir and color code (resources=azzurro, basics=green, ...)
              -- magari mostra solo directory?
        lualine_b = {

                    {
                        "branch",
                        icon = {"",align='right',

                        -- color = function()
                        --     local name = vim.fn.FugitiveHead()
                            -- return { fg = (name == "main" or name == "master") and "ff00ff" or '#'..name:sub(1,6) }
                        --     return { fg = (name == "main" or name == "master") and "ff00ff" or "yellow" }
                        -- end,
                    },
                  },
                  -- how to put in the middle?
                  -- TODO: show winnr?
          {'filename',
        path=1,
            color = function()
               return { fg = vim.bo.modified and '#aa3355' or '#33aa88' }
            end,
      },

      -- use B/L for visual mode?
          { 'mode', fmt = function(str) return str:sub(1,1) end }
    },
          -- lualine_c = {'%=', '%F' } ,
      -- buggy af
      -- lualine_c = {
      --       { todos_file },
      -- },

      -- is it possible to differentiate by lsp?
          lualine_y = { 'lsp_status' },
      },
        inactive_winbar = {
          lualine_a = {{'filename',path=4}},
        },

        -- swap statusline and tabline, and put num of modified buffers and not saved
        sections = {
          -- workspace diagnostics?
          -- lualine_a = { 'mode' },
          lualine_a = { '' },
          lualine_b = {lazy},
          lualine_c = {''},
          -- lualine_x = { 'selectioncount' },
          -- lualine_y = {'repo_diff'  },
          -- lualine_y = { lazy },
          lualine_x = {},
          lualine_y = {},
          lualine_z = {}
        },
        -- do these work w/ global statusline?
        inactive_sections = {
          -- lualine_a = {'lazy'},
          lualine_b = {},
          -- usa 1<c-g> per full path
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
        -- extensions = {
        --     'fugitive', 'lazy', 'man', 'mason', 'nvim-dap-ui', 'oil', 'overseer', 'quickfix', 'symbols-outline', 'trouble'
        -- }
      })
    end,
  },
}
