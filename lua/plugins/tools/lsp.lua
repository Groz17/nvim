-- https://github.com/artemave/workspace-diagnostics.nvim
-- https://github.com/davidyz/inlayhint-filler.nvim

---@see https://github.com/bcampolo/nvim-starter-kit/blob/d9092903e5691c129a56e0771957216e4b84aaba/.config/nvim/lua/plugins/nvim-lspconfig.lua#L50
-- LSP Support
-- how to know which of your LSP support a certain capability like inlay hint? fzf display???
return {
 {
   'williamboman/mason-lspconfig.nvim',
   dependencies = {
     -- how to list everything you've installed?
     'williamboman/mason.nvim',
   },
   lazy = true,
   opts = {
     -- Install these LSPs automatically
     ensure_installed = {
       'basedpyright',
       'rust_analyzer',
       'clangd',
       -- usa gx on MDN reference
       'cssls',
       'vimls',
       -- 'pst_ls',
       'taplo',
       'bashls',
       'perlnavigator',
       -- 'denols',
       --     ◍ postgrestools (keywords: postgres, sql)
       'sqlls',
       -- 'bashls', -- requires npm to be installed
       -- 'cssls', -- requires npm to be installed
       -- 'html', -- requires npm to be installed
       'lua_ls',
       -- 'jsonls', -- requires npm to be installed
       -- 'lemminx',
       -- 'marksman',
       -- 'quick_lint_js',
       -- 'tsserver', -- requires npm to be installed
       -- 'yamlls', -- requires npm to be installed
       'jdtls',
     },
   },
 },
 {
   -- can you make program config act like LSP? like .stylua.toml should show live diagnostics...
   -- LSP Configuration
   -- https://github.com/neovim/nvim-lspconfig
   -- can you make this plugin lazy?
   'neovim/nvim-lspconfig',
   -- lazy = false,
   event = 'VeryLazy',
   -- event = { 'BufReadPre', 'BufNewFile' },
   dependencies = {
     -- LSP Management
     { 'williamboman/mason-lspconfig.nvim', 'saghen/blink.cmp' },

   },
   config = function()

       -- Maybe use uppercase L here? <leader>L (to distinguish them...)
       -- Commands's mappings
       -- j,k,i sono tutte vicine (i è in mezzo a j e k (da sopra), manca solo la m (da sotto) che potrai usare per un eventuale nuovo comando)
       -- vim.keymap.set("n", "<leader>ls", ":LspStart<cr>")
       -- Use k and j top stop, minicking zoom mappings: <c-j> to zoom out (feels like abandoning an application) and <c-k> (feels like entering an application) ; they're nice because they're comfortable to type and also aren't associated with common words or actions.
       -- how to globally disable lsp?
       -- What about LspToggle?
       -- vim.keymap.set('n', 'grs', '<cmd>LspStart<cr>', { desc = 'Start' })
       vim.keymap.set('n', 'gr0', '<cmd>LspStart<cr>', { desc = 'Start' })
       -- how to disable globally?
       -- dot -> full stop (like a sentence)
       -- vim.keymap.set("n", "<leader>l.", ":LspStop<cr>", {desc="Stop"})
       -- vim.keymap.set('n', 'grS', '<cmd>LspStop<cr>', { desc = 'Stop' })
       -- i and o to start/stop (like electronics symbol?) (maybe uppercase to match symbol (i is not 1-looking))
       vim.keymap.set('n', 'gr_', '<cmd>LspStop<cr>', { desc = 'Stop' })
       -- Where is LspToggle???
       --vim.leymap.set('n','<leader>lh',':LspInfo<cr>', {desc="Info"})
     -- bug: premendo gr? due volte neovim crasha
     -- restart mapping in emacs? also for :restart command
       vim.keymap.set('n', 'gr?', '<cmd>LspInfo<cr>', { desc = 'Info' })

       -- strano che non c'è un log per ogni LS...
       -- vim.keymap.set('n', '<leader>lp', '<cmd>exe "e " .. v:lua.vim.lsp.get_log_path()<CR>', { desc = "Client's logfile " })
       -- log for every filetype???
       -- *vim.lsp.log.set_format_func()*
       vim.keymap.set('n', 'grl', '<CMD>LspLog<CR>', { desc = "Client's logfile " })
     local lspconfig = require('lspconfig')
     -- TODO: https://github.com/Saghen/blink.cmp/issues/13

     -- preview_location({location}, {opts})         *vim.lsp.util.preview_location()*

     vim.api.nvim_create_autocmd('LspAttach', {
       callback = function(args)
       local client = vim.lsp.get_client_by_id(args.data.client_id)
       -- assert(client ~= nil) (https://github.com/famiu/dot-nvim/blob/681c95b90db4af06cb17fffd23c3506aa95b9fed/lua/plugins/lsp/init.lua#L53)
       -- https://github.com/pwntester/codeql.nvim?tab=readme-ov-file

       -- TODO: substitute all this mappings with fzf: se 1->default LSP mapping behaviour, se n->apri fzf (ed eventualmente metti in quickfix/loclist)
       vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = args.buf, desc = 'Goto definition' })
       vim.keymap.set('n', '<c-]>', vim.lsp.buf.definition, { buffer = args.buf, desc = 'Goto definition' })
       -- vim.keymap.set("n", "gd", function() vim.lsp.buf.definition { on_list = on_list } end, opts)
       vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = args.buf, desc = 'Goto declaration' })
       --  " from https://github.com/VSCodeVim/Vim/blob/master/ROADMAP.md
       --      " gh - show the hover tooltip.
       --      " gb - add an additional cursor at the next place that matches *.
       --  " K -> documentation, gK -> hover
       -- how to go up and down? you could use ^ww to go to the floating window, but still
       --  " tooltip e hover sono sinonimi?
       -- make it so when no results open man/help (or maybe open man if v:count!=0)
       -- vim.keymap.set("n", "<c-w>gi","<cmd>split | lua vim.lsp.buf.implementation()<CR>", { buffer = bufnr ,desc = "Goto implementation" })
       -- idea: usa ^w o altro prefisso per cambiare modalita di visualizzazione comando lsp (window/floating window/go to buffer (edit)/etc...)

       -- vim.keymap.set('n', '<c-w>gi', function()
       --   -- local client = vim.lsp.get_client_by_id(ev.data.client_id)
       --   if client.supports_method('textDocument/implementation') then
       --     vim.cmd([[lua vim.lsp.buf.implementation()]])
       --   end
       -- end, { buffer = args.buf, desc = 'Goto implementation' })

       -- for multicursor
       -- vim.keymap.set("n", "<c-s>", vim.lsp.buf.signature_help, { buffer = bufnr ,desc = "Signature help" })

       -- { '<C-g>h', vim.lsp.buf.signature_help, mode = 'i', desc = 'Signature Help', has = 'signatureHelp' },
       -- buf_maps("i", { ["<M-s>"] = function() lsp.buf.signature_help() end })
       -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<c-\\>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
       --  " nnoremap <silent> 1gD           <cmd>lua vim.lsp.buf.type_definition()<CR>
       vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, { buffer = args.buf, desc = 'Goto type definition' })
       vim.keymap.set('n', 'gY', vim.lsp.buf.typehierarchy, { buffer = args.buf, desc = 'Subtypes or supertypes' })
       --  " nnoremap <silent> <F2>          <cmd>lua vim.lsp.buf.rename()<CR>
       ---@see https://www.reddit.com/r/neovim/comments/1gryk36/comment/lxbkwaa/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
       -- useful/nice trick to use normal mode instead of insert mode
       -- also cv (change variable)
       vim.keymap.set("n", "grn", function()
         local new_name = vim.fn.expand("<cword>") --TODO: sicuro non usare <cWORD>? magari usa grN per quella
         vim.cmd("undo!")
         -- settings that automatically saves the other files???
         vim.lsp.buf.rename(new_name)
       end, {
       desc = "apply forgotten symbol rename for last text edit",
     })
       --
       --  " usa <c-r><c-w> o <c-r><c-a> se necessario
       --  " does this preserve case?
       -- vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr ,desc = "Rename" })
       --  " would be cool if lsp didn't work these mappings would fall back to vim's implementation (usa http://neovimcraft.com/plugin/anuvyklack/keymap-amend.nvim/index.html)
       --  xnoremap <silent> <a-cr>        <cmd>lua vim.lsp.buf.range_code_action()<CR>
       -- vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
       -- vim.keymap.set({ "n", "x" }, "<a-cr>", vim.lsp.buf.code_action, merge(opts, { desc = "Code action" }))
       -- which you could just scroll with <c-{j,k}>
       vim.keymap.set('n', '<a-cr>', '<cmd>lua require("fastaction").code_action()<CR>', { buffer = args.buf, desc = "Code action" })
       vim.keymap.set('x', '<a-cr>', "<esc><cmd>lua require('fastaction').range_code_action()<CR>", { buffer = args.buf, desc = "Code action"})

       -- vim.keymap.set('n', '[I', vim.lsp.buf.references, { buffer = bufnr, desc = 'Goto references' })

       -- vim.keymap.set('n', 'grO', vim.lsp.buf.workspace_symbol, { buffer = args.buf, desc = 'Workspace symbol' })
       vim.keymap.set('n', 'grO', function() vim.lsp.buf.workspace_symbol(vim.fn.input('Query >')) end, { buffer = args.buf, desc = 'Workspace symbol' })
       -- used in mini.ai
       vim.keymap.set("n", "grc", vim.lsp.buf.incoming_calls, { buffer = args.buf, desc = "Incoming calls" })
       vim.keymap.set("n", "grC", vim.lsp.buf.outgoing_calls, { buffer = args.buf, desc = "Outgoing calls" })

       -- grl? toggle?
       vim.keymap.set('n', 'grl', vim.lsp.codelens.run, { buffer = args.buf, desc = 'Run code lens actions' })
       vim.keymap.set('n', 'grl', vim.lsp.codelens.refresh, { buffer = args.buf, desc = 'Refresh code lenses' })

       vim.keymap.set('n', 'grw', vim.lsp.buf.add_workspace_folder, { buffer = args.buf, desc = 'Add folder' })
       vim.keymap.set('n', 'grW', vim.lsp.buf.remove_workspace_folder, { buffer = args.buf, desc = 'Remove folder' })
       vim.keymap.set('n', 'grf', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, { buffer = args.buf, desc = 'Workspace folders' })

     -- ---https://github.com/Issafalcon/lsp-overloads.nvim?tab=readme-ov-file/https://www.reddit.com/r/neovim/comments/1gsoap2/info_about_overloaded_functions_and_constructor/
     -- --- Guard against servers without the signatureHelper capability
     -- if client.server_capabilities.signatureHelpProvider then
     --   require('lsp-overloads').setup(client, {    keymaps = {
     --     -- next_signature = "<c-)>",
     --     next_signature = "<c-(>",
     --     previous_signature = "<c-)>",
     --     next_parameter = "<a-(>",
     --     previous_parameter = "<a-)>",
     --     close_signature = "<A-s>"
     --   },})
     -- end
     ---https://github.com/neovim/neovim/pull/31311
     -- if client.supports_method('textDocument/foldingRange') then vim.wo.foldexpr = "v:lua.vim.lsp.foldexpr()" end
     -- TODO: add also            vim.wo.foldmethod = 'expr' (https://github.com/famiu/dot-nvim/blob/681c95b90db4af06cb17fffd23c3506aa95b9fed/lua/plugins/lsp/init.lua#L53)
     -- if client:supports_method(vim.lsp.protocol.Methods.textDocument_foldingRange) then vim.wo.foldexpr = "v:lua.vim.lsp.foldexpr()" end

     ---@see https://github.com/dam9000/kickstart-modular.nvim/blob/master/lua/kickstart/plugins/lspconfig.lua
     -- The following code creates a keymap to toggle inlay hints in your
     -- code, if the language server you are using supports them
     --
     -- TODO: add error notification?
     -- This may be unwanted, since they displace some of your code
     -- if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
       -- vim.keymap.set('n','grh', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, { buffer = args.buf, desc = 'Toggle Inlay Hints' })
     -- end
   end

     })

     -- TODO: probably not necessary
     local capabilities = require('blink.cmp').get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())
     capabilities.textDocument.completion.completionItem.snippetSupport = true

     require('mason-lspconfig').setup_handlers({
       function(server_name)
         if server_name ~= 'jdtls' then
           lspconfig[server_name].setup({
             -- usa on_attach per lsp-server specifici, LspAttach per config globale
             capabilities = capabilities
             -- TODO: funge? also blink icons?
             -- capabilities = require('blink.cmp').get_lsp_capabilities(server_name.capabilities)
           })
         end
       end,

     })

     -- -- Globally configure all LSP floating preview popups (like hover, signature help, etc)
     -- local open_floating_preview = vim.lsp.util.open_floating_preview
     -- function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
     --   opts = opts or {}
     --   opts.border = opts.border or "rounded" -- Set border to rounded
     --   return open_floating_preview(contents, syntax, opts, ...)
     -- end

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
-- {
--   'ray-x/lsp_signature.nvim',
--   cond = false,
--   -- vim.keymap.set({ 'n' }, '<F2>', function() require('lsp_signature').select_signature_key() end, { silent = true, noremap = true, desc = 'Toggle signature' })
--   opts = {
--     bind = true,
--     handler_opts = {
--       border = 'rounded',
--     },
--   },
-- },
-- {
--   "kevinhwang91/nvim-ufo", -- enable LSP-based folds
-- }
-- dependencies = {
--   'saghen/blink.cmp',
-- },
-- from cssls help?
-- --Enable (broadcasting) snippet capability for completion
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true


-- lspconfig.ast_grep.setup{}

-- install sed :))
--  -- https://github.com/Beaglefoot/awk-language-server/
-- lspconfig.awk_ls.setup({})

   -- how to disable when virtual_text is on? like in lazy.nvim's update window
   -- TODO: put this in diagnostics.lua? also don't attach only on lspattach (diagnostics could be triggered by CLI command as well/others?) maybe just use keys
{ 'Issafalcon/lsp-overloads.nvim',event='LspAttach'},
--
--   {
--     -- would be nice to have a mapping like <leader>{J,K} to go to next/prev bulb
--     -- vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
--     "kosayoda/nvim-lightbulb",
--     event = "LspAttach",
--     opts = {
--       autocmd = { enabled = true }
--     },
--     config = function()
--       vim.fn.sign_define("LightBulbSign", { text = "", texthl = "DiagnosticInfo", numhl = "", linehl = "" })
--     end,
--   },
 {
     'Chaitanyabsprip/fastaction.nvim',
     -- keys = {'<a-cr>'},
     event = "LspAttach",
     -- ---@type FastActionConfig
     opts = {
       -- priority
     },
 },
--   {
--     "smjonas/inc-rename.nvim",
--     event = "LspAttach",
--     config = function()
--       require("inc_rename").setup()
--       vim.keymap.set("n", "<leader>lr", function() return ":IncRename " .. vim.fn.expand("<cword>") end, { expr = true,  desc = "󰑕 Rename word under cursor"  })
--       vim.keymap.set("n", "<leader>lR", ":IncRename<space>", { desc = "󰑕 Rename" })
--     end,
--   },
--   {
--     'SmiteshP/nvim-navic',
--     cond = false,
--     dependencies = 'neovim/nvim-lspconfig',
--     opts = {
--       lsp = { auto_attach = true },
--       separator = " > ",
--       highlight = true,
--       depth_limit = 5,
--     },
--     event = 'LspAttach'
--   },
--   {
--     'Wansmer/symbol-usage.nvim',
--     event = 'LspAttach', -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
--     config = function()
--       -- local function a(b)return vim.api.nvim_get_hl(0,{name=b})end;vim.api.nvim_set_hl(0,'SymbolUsageRef',{bg=a('Type').fg,fg=a('Normal').bg,bold=true})vim.api.nvim_set_hl(0,'SymbolUsageRefRound',{fg=a('Type').fg})vim.api.nvim_set_hl(0,'SymbolUsageDef',{bg=a('Function').fg,fg=a('Normal').bg,bold=true})vim.api.nvim_set_hl(0,'SymbolUsageDefRound',{fg=a('Function').fg})vim.api.nvim_set_hl(0,'SymbolUsageImpl',{bg=a('@parameter').fg,fg=a('Normal').bg,bold=true})vim.api.nvim_set_hl(0,'SymbolUsageImplRound',{fg=a('@parameter').fg})local function c(d)local e={}if d.references then table.insert(e,{'󰍞','SymbolUsageRefRound'})table.insert(e,{'󰌹 '..tostring(d.references),'SymbolUsageRef'})table.insert(e,{'󰍟','SymbolUsageRefRound'})end;if d.definition then if#e>0 then table.insert(e,{' ','NonText'})end;table.insert(e,{'󰍞','SymbolUsageDefRound'})table.insert(e,{'󰳽 '..tostring(d.definition),'SymbolUsageDef'})table.insert(e,{'󰍟','SymbolUsageDefRound'})end;if d.implementation then if#e>0 then table.insert(e,{' ','NonText'})end;table.insert(e,{'󰍞','SymbolUsageImplRound'})table.insert(e,{'󰡱 '..tostring(d.implementation),'SymbolUsageImpl'})table.insert(e,{'󰍟','SymbolUsageImplRound'})end;return e end;require('symbol-usage').setup({text_format=c})
--     end
--   },
--       -- stylua: ignore end
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
}
-- }
-- -- mapping: g<c-p>?
-- -- https://github.com/rmagatti/goto-preview

-- https://github.com/jmbuhr/otter.nvim
-- treat symbol as tag so you can use the vim tag mappings?

-- live render workspace diagnostics in quickfix with current buf errors on top, buffer diagnostics in loclist
-- https://github.com/onsails/diaglist.nvim

-- compila ensure_installed

-- https://github.com/joechrisellis/lsp-format-modifications.nvim
-- https://github.com/joechrisellis/lsp-format-modifications.nvim/issues/1#issuecomment-1275302811

-- how to only show warnings or errors (on column sign)?
}
-- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
