-- mapping to ignore/toggle current line diag?
-- 'first'/'last' direction (https://www.reddit.com/r/neovim/comments/118511i/minibracketed_go_forwardbackward_with_square/)
--
-- TODO: come filtrare/eliminare/nascondere diagnostics tipo linea troppo lunga?
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- dd -> line because you repeat last character to mean line
-- vim.keymap.set("n", "<leader>dd", vim.diagnostic.open_float, { desc = "Show line diagnostics in window" })
-- TODO: usa v:count
-- TODO: fix with diffview mappings
vim.keymap.set("n", "<space>db", function() vim.diagnostic.open_float({ scope = "b" }) end, { desc = "Show buffer diagnostics in window" })
vim.keymap.set("n", "<space>dc", function() vim.diagnostic.open_float({ scope = "c" }) end, { desc = "Show cursor diagnostics in window" })

vim.keymap.set("n", "<space>dr", vim.diagnostic.reset, { desc = "Clear diagnostics" })
vim.keymap.set("n", "<space>dh", vim.diagnostic.hide, { desc = "Hide diagnostics" })
vim.keymap.set("n", "<space>ds", vim.diagnostic.show, { desc = "Show hidden diagnostics" })

local log_levels = {}
for k, v in pairs(vim.log.levels) do
  log_levels[v] = k
end

-- use trouble mappings...
-- What's the default severity?
-- Send diagnostics to quickfix
-- TODO: usa stesso trucchetto hex per usare vim.v.count per filtrare errors, warning, etc...
-- window which-key per ricordarti i valori? usa desc (attendiamo che una variable per todo_comments sia mergiata in neovim)
-- vim.keymap.set("n", "<leader>dq", function() vim.diagnostic.setqflist({severity=vim.v.count}) end, { desc = "Project " .. vim.api.nvim_eval([=[luaeval('vim.log').levels->filter({_,v->index([v],vim.v.count)>=0})->keys()[0]]=]) .. "diagnostics" })
-- vim.keymap.set("n", "<leader>dq", function() vim.diagnostic.setqflist({severity=vim.v.count}) end, { desc = "Project " .. vim.tbl_filter(function(item) return vim.fn.indexof({item},'v:val=='..vim.v.count)  end, vim.log.levels) .. "diagnostics" })
-- vim.keymap.set("n", "<leader>dq", function() vim.diagnostic.setqflist({severity=vim.v.count}) end, { desc = "Project " .. vim.iter(vim.log.levels):filter(function(_,v) return v == vim.v.count end):totable()[1][1] .. " diagnostics" })
-- vim.keymap.set("n", "<leader>dq", function() return '<CMD>lua vim.diagnostic.setqflist({severity=vim.v.count})<CR>' end, { desc = "Project " .. vim.iter(vim.log.levels):filter(function(_,v) return v == vim.v.count end):totable()[1][1] .. " diagnostics", expr = true })
-- vim.keymap.set("n", "<leader>dq", function() return ':<c-u>lua vim.diagnostic.setqflist({severity=vim.v.count})<CR>' end, { desc = "Project " .. (function() return vim.iter(vim.log.levels):filter(function(_,v) return v == vim.v.count end):totable()[1][1] end)() .. " diagnostics", expr = true })

-- =
-- vim.keymap.set("n", "<leader>dl", function() vim.diagnostic.setloclist({severity=vim.v.count}) end, { desc = "Document " .. log_levels[vim.v.count] .. " diagnostics" , expr = true})
-- change vim.log.levels to start with index 1 so v:count=0 can include all
-- vim.keymap.set("n", "<leader>dq", function() vim.diagnostic.setqflist({severity=vim.v.count}) end, { desc = "Project diagnostics" })
-- Functions that take a severity as an optional parameter (e.g. |vim.diagnostic.get()|) accept one of three forms:
-- gioca anche su max e min? e combinazioni
-- notify if lsp not started
vim.keymap.set("n", "<leader>dq", function() vim.diagnostic.setqflist({severity={max=vim.v.count}}) end, { desc = "Project diagnostics" })
vim.keymap.set("n", "<leader>dl", function() vim.diagnostic.setloclist({severity={max=vim.v.count}}) end, { desc = "Document diagnostics" })

-- fallback to these when lsp isn't on
--  " nnoremap <silent> <Leader>j     <cmd>cbelow<CR>
--  " nnoremap <silent> <Leader>k     <cmd>cabove<CR>
--  " usa j and k per gli errori
-- float=false because I use lsp_lines
-- ci vorebbe un secondo v:count per indicare vim.log.levels...
vim.keymap.set("n", "<space>j", function()  vim.diagnostic.jump({ count = vim.v.count1, float = not vim.diagnostic.config().virtual_lines }) end, { desc = "Go to next diagnostic" })
-- TODO: v:count to mean next v:count to last
vim.keymap.set("n", "<space>J", "]D", { desc = "Go to last diagnostic", remap = true })
vim.keymap.set("n", "<space>k", function() vim.diagnostic.jump({ count = -vim.v.count1, float = not vim.diagnostic.config().virtual_lines }) end, { desc = "Go to prev diagnostic" })
vim.keymap.set("n", "<space>K", "[D", { desc = "Go to first diagnostic", remap = true })
-- first and last diagnostics (have to prefix with d since those would be bufferline's go to next/previous buffer)
-- vim.keymap.set("n", "<leader>dK", function() vim.diagnostic.goto_next({cursor_position={1,0}}) end)
-- vim.keymap.set("n", "<leader>dJ", function() vim.diagnostic.goto_prev({cursor_position={vim.fn.line('$'),vim.fn.strlen(vim.fn.getline('$'))-1}}) end)
-- vim.keymap.set("n", "<leader>dJ", function() vim.diagnostic.goto_prev({cursor_position={vim.fn.line('$'),vim.fn.strdisplaywidth(vim.fn.getline('$'))-1}}) end)
-- https://www.reddit.com/r/neovim/comments/13t74ut/how_can_i_get_better_looking_errors/
-- TODO: usa vim.v.count come per i TODO
-- vim.keymap.set("n", "]e", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end, { desc = "Go to next ERROR" })
-- vim.keymap.set("n", "[e", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, { desc = "Go to previous ERROR" })
-- [W and ]W for first and last? also for errors
-- vim.keymap.set("n", "]w", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN }) end, { desc = "Go to next WARNING" })
-- vim.keymap.set("n", "[w", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN }) end, { desc = "Go to previous WARNING" })

-- ╭─────────────────────────────────────────────────────────╮
-- │ Signs                                                   │
-- ╰─────────────────────────────────────────────────────────╯

-- https://www.reddit.com/r/neovim/comments/18teetv/comment/kff81za/?utm_source=share&utm_medium=web2x&context=3
-- local signs = { Error = '🤬', Warn = '🤔', Hint = '☝️', Info = '🤓' }
-- for type, icon in pairs(signs) do
--   local hl = 'DiagnosticSign' .. type
--   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
-- end

    -- vim.diagnostic.config({

-- https://github.com/yorickpeterse/nvim-dd

-- diagnostic comment
-- vim.cmd([[
-- map <expr> <leader>dc DiagComment()
-- fun! DiagComment() abort
-- " considera anche severity di warning e inferiore? magari con un v:count
-- let diagnostics = luaeval('vim.diagnostic.get(0)')
-- if !diagnostics->empty()
-- let commentstring = &commentstring->substitute(' %s$','','')
-- " considera anche end_lnum?
-- pu!=repeat(' ', indent(line('.'))) .. commentstring .. ' ' .. diagnostics->filter({k,v->v.lnum==line('.')})[0].message
-- else
--   lua vim.notify("No diagnostic in current line")
-- endif
-- endfun
-- ]])

-- virtual_text={filter=}

vim.cmd[[
set numberwidth=3
set signcolumn=yes:1
set statuscolumn=%l%s
]]
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '',
    },
    numhl = {
      [vim.diagnostic.severity.WARN] = 'WarningMsg',
      [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
      [vim.diagnostic.severity.INFO] = 'DiagnosticInfo',
      [vim.diagnostic.severity.HINT] = 'DiagnosticHint',

    },
  },
  -- https://www.reddit.com/r/neovim/comments/1jo9oe9/i_set_up_my_config_to_use_virtual_lines_for/
  virtual_text = {
    enabled = true,
    severity = {
      max = vim.diagnostic.severity.WARN,
    },
  },
  virtual_lines = {
    enabled = true,
    severity = {
      min = vim.diagnostic.severity.ERROR,
    },
  },
})
