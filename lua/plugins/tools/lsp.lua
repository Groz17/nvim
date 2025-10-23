return {
  {
    'neovim/nvim-lspconfig',
    -- lazy = false,
    event = 'VeryLazy',
    -- event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'saghen/blink.cmp' },

    },
    config = function()

      vim.keymap.set('n', 'gr0', '<cmd>LspStart<cr>', { desc = 'Start' })
      -- dot -> full stop (like a sentence)
      vim.keymap.set('n', 'gr_', '<cmd>LspStop<cr>', { desc = 'Stop' })
      -- restart mapping in emacs? also for :restart command
      vim.keymap.set('n', 'gr?', '<cmd>LspInfo<cr>', { desc = 'Info' })

      vim.keymap.set('n', 'grl', '<CMD>LspLog<CR>', { desc = "Client's logfile " })

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          -- assert(client ~= nil) (https://github.com/famiu/dot-nvim/blob/681c95b90db4af06cb17fffd23c3506aa95b9fed/lua/plugins/lsp/init.lua#L53)
          -- https://github.com/pwntester/codeql.nvim?tab=readme-ov-file

          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = args.buf, desc = 'Goto definition' })
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = args.buf, desc = 'Goto declaration' })

          vim.keymap.set('n', 'grT', vim.lsp.buf.typehierarchy, { buffer = args.buf, desc = 'Subtypes or supertypes' })

          ---@see https://www.reddit.com/r/neovim/comments/1gryk36/comment/lxbkwaa/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
          -- useful/nice trick to use normal mode instead of insert mode
          -- also cv (change variable)
          --  " does this preserve case?
          vim.keymap.set("n", "grn", function()
            local new_name = vim.fn.expand("<cword>") --TODO: sicuro non usare <cWORD>? magari usa grN per quella
            vim.cmd("undo!")
            -- settings that automatically saves the other files???
            vim.lsp.buf.rename(new_name)
          end, {
          desc = "apply forgotten symbol rename for last text edit",
        })

        -- vim.keymap.set('n', '[I', vim.lsp.buf.references, { buffer = bufnr, desc = 'Goto references' })

        vim.keymap.set('n', '<f19>gO', vim.lsp.buf.workspace_symbol, { buffer = args.buf, desc = 'Workspace symbol' })
        -- used in mini.ai
        -- vim.keymap.set("n", "grc", vim.lsp.buf.incoming_calls, { buffer = args.buf, desc = "Incoming calls" })
        -- vim.keymap.set("n", "grC", vim.lsp.buf.outgoing_calls, { buffer = args.buf, desc = "Outgoing calls" })

        -- grl? toggle?
        vim.keymap.set('n', 'grl', vim.lsp.codelens.run, { buffer = args.buf, desc = 'Run code lens actions' })
        vim.keymap.set('n', 'grl', vim.lsp.codelens.refresh, { buffer = args.buf, desc = 'Refresh code lenses' })

        vim.keymap.set('n', 'grw', vim.lsp.buf.add_workspace_folder, { buffer = args.buf, desc = 'Add folder' })
        vim.keymap.set('n', 'grW', vim.lsp.buf.remove_workspace_folder, { buffer = args.buf, desc = 'Remove folder' })
        vim.keymap.set('n', 'grf', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, { buffer = args.buf, desc = 'Workspace folders' })

        -- This may be unwanted, since they displace some of your code
        -- if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
        vim.keymap.set('n','grh', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, { buffer = args.buf, desc = 'Toggle Inlay Hints' })
        -- end
      end

    })

    ---@see https://github.com/folke/snacks.nvim/blob/main/docs/notifier.md
    ---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
    local progress = vim.defaulttable()
    vim.api.nvim_create_autocmd("LspProgress", {
      ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
        if not client or type(value) ~= "table" then
          return
        end
        local p = progress[client.id]

        for i = 1, #p + 1 do
          if i == #p + 1 or p[i].token == ev.data.params.token then
            p[i] = {
              token = ev.data.params.token,
              msg = ("[%3d%%] %s%s"):format(
                value.kind == "end" and 100 or value.percentage or 100,
                value.title or "",
                value.message and (" **%s**"):format(value.message) or ""
              ),
              done = value.kind == "end",
            }
            break
          end
        end

        local msg = {} ---@type string[]
        progress[client.id] = vim.tbl_filter(function(v)
          return table.insert(msg, v.msg) or not v.done
        end, p)

        local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
        vim.notify(table.concat(msg, "\n"), "info", {
          id = "lsp_progress",
          title = client.name,
          opts = function(notif)
            notif.icon = #progress[client.id] == 0 and " "
            or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
          end,
        })
      end,
    })
  end,
},

{
  --     -- would be nice to have a mapping like <leader>{J,K} to go to next/prev bulb
  --     -- vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
  "kosayoda/nvim-lightbulb",
  event = "LspAttach",
  opts = {
    autocmd = { enabled = true }
  },
},
{
  "zeioth/garbage-day.nvim",
  dependencies = "neovim/nvim-lspconfig",
  event = "LspAttach",
  opts = {
    notifications = true,
    excluded_lsp_clients = {
      -- "null-ls",
      -- "jdtls",
      -- "lua_ls",
    },
  },
},
{
  "Davidyz/inlayhint-filler.nvim",
  cond=false,
  keys = {
    {
      "<Leader>i",
      function() require("inlayhint-filler").fill() end,
      desc = "Insert the inlay-hint under cursor into the buffer.",
      mode = { "n", "x" },
    },
  }
}
}
