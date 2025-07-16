-- integrate w/ neorg?
-- would be cool to define automatically expand snippet when typing todo it becomes TODO, or vim mapping
-- https://github.com/search?q=repo%3Afolke%2Ftodo-comments.nvim+lualine&type=issues
-- https://github.com/search?q=repo%3Afolke%2Ftodo-comments.nvim%20lualine&type=code
-- https://github.com/folke/todo-comments.nvim/issues/98
-- https://github.com/folke/todo-comments.nvim/issues/259
-- https://github.com/folke/todo-comments.nvim/issues/172
-- TODO: surround visual selection w/ TODO  (w/ mini.surround)
-- TODO: ask folke for priority spec? like 1TODO or TODO1-5?
return {
  { -- https://github.com/folke/todo-comments.nvim/issues/71

    --  ╭──────────────────────────────────────────────────────────╮
    --  │                           TODO                          │
    --  │                           HACK                          │
    --  │                   WARN (WARNING, XXX)                   │
    --  │           PERF (OPTIM, PERFORMANCE, OPTIMIZE)           │
    --  │                       NOTE (INFO)                       │
    --  │             ⏲ TEST (TESTING, PASSED, FAILED)             │
    --  ╰──────────────────────────────────────────────────────────╯

    -- are these mapped to conventionalcommits?
    -- TODO: automatically uppercase todo, note, etc...
    -- integrate with demicolon?
    'folke/todo-comments.nvim',
    -- cond=false,
    event = { 'BufReadPost', 'BufNewFile' },
    cmd = { 'TodoQuickFix', 'TodoLocList', 'TodoTrouble' },
    -- dependencies = { 'nvim-lua/plenary.nvim' },
    -- maybe use gct (or better mapping) to add todo, etc...
    -- a mapping like <leader>j,k sounds better
    -- TODO: create snippets for each of these?
    -- NOTICE: ??? PgADMIN errors
    -- you could map these with conventionalcommits/semver???
    keys = function()
      -- maybe order using major system? like 1=todo, 2=note, 3=warn (W~~M), 4=perf, others?  ( usa -> (?:(?:T(?:EST(?:ING)?|ODO)|PERF(?:ORMANCE)?|FIX(?:IT|ME)?|HACK|NOTE) [1-7]|[1-7] (?:T(?:EST(?:ING)?|ODO)|PERF(?:ORMANCE)?|FIX(?:IT|ME)?|HACK|NOTE)   )
      -- maybe open which-key window to remember them? (desc key must contain vim.v.count)
      -- [
      -- FIX:
      -- -- FIXME:
      -- -- BUG:
      -- -- FIXIT:
      -- -- ISSUE:

      -- TODO:,

      -- HACK:,
      -- -- WARN:
      -- -- WARNING:
      -- -- XXX:

      -- PERF:
      -- -- OPTIM:
      -- -- PERFORMANCE:
      -- -- OPTIMIZE:

      -- NOTE:
      -- INFO:

      -- TEST:
      -- -- TESTING:
      -- -- PASSED:
      -- -- FAILED:
      --]
      local _keywords = {}
      -- TODO:  syntax highlight the command with bash
      local extracted_keywords = vim.json.decode(
        vim.fn.system([[ast-grep run --pattern 'local defaults = { $$$B }' ]] .. vim.fn.stdpath('data') .. [['/lazy/todo-comments.nvim/lua/todo-comments/config.lua']] .. [[| sed 's/^[^:]\+:[0-9]\+://' | sed '1s/local defaults =/return/' | yq -pl -oj | jq '[.keywords|to_entries[]|[.key,((.value.alt) // empty)]|flatten]']])
      )
      for _, k in ipairs(extracted_keywords) do
        table.insert(_keywords, k)
      end

      local vcount2keywords = function()
        if vim.v.count == 0 then return nil end
        local wanted_keywords = {}
        local bit_keywords = vim.api.nvim_eval(
          [[v:count->printf('%b')->split('\zs')->reverse()->map({p,b->b*float2nr(pow(2,str2nr(p)))})->filter('v:val != 0')]]
        )
        for _, bit in ipairs(bit_keywords) do
          table.insert(
            wanted_keywords,
            _keywords[math.log(bit) / math.log(2) + 1]
          )
        end
        -- return vim.iter(vim.iter(wanted_keywords):flatten():totable()):join()
        -- return vim.iter(vim.iter(wanted_keywords):flatten()._table):join(",")
        return vim.iter(vim.iter(wanted_keywords):flatten():totable()):join(',')
        -- return vim.iter(vim.iter(wanted_keywords):flatten():totable())
        -- INFO: is totable() even necessary?
        -- return vim.iter(vim.iter(wanted_keywords):flatten()):join()
      end

      return {
        -- would be nice to use chords as in https://github.com/jtroo/kanata/issues/99 so for ex press 2 keys at the same (num/sym layer) time to output in their sum, etc...
        -- TODO: crea buffer mappings (lowercase version)
        -- usa magari leader/control/alt con simboli (vedi kanata)
        -- { '<leader>(', function() require('todo-comments').jump_next({ keywords = vcount2keywords() }) end, desc = 'Next todo comment' },
        -- { '+', function() require('todo-comments').jump_next({ keywords = vcount2keywords() }) end, desc = 'Next todo comment' },
        -- cosi come se fosse j and k
        -- { '_', function() require('todo-comments').jump_next({ keywords = vcount2keywords() }) end, desc = 'Next todo comment' },
        -- { '<space><space>', function() require('todo-comments').jump_next({ keywords = vcount2keywords() }) end, desc = 'Next todo comment' },
        -- { ']<space>', function() require('todo-comments').jump_next({ keywords = vcount2keywords() }) end, desc = 'Next todo comment' },
        -- { '<leader>tk', function() require('todo-comments').jump_prev({ keywords = vcount2keywords() }) end, desc = 'Previous todo comment' },
        -- { '<leader>)', function() require('todo-comments').jump_prev({ keywords = vcount2keywords() and vim.split(vcount2keywords(), ',') or nil }) end, desc = 'Previous todo comment' },
        -- { '+', function() require('todo-comments').jump_prev({ keywords = vcount2keywords() and vim.split(vcount2keywords(), ',') or nil }) end, desc = 'Previous todo comment' },
        -- { '<space><s-space>', function() require('todo-comments').jump_prev({}) end, desc = 'Previous todo comment' },
        -- { '[<space>', function() require('todo-comments').jump_prev({}) end, desc = 'Previous todo comment' },

        -- { "<leader>tq", "<cmd>TodoQuickFix<CR>", desc = "List all project todos [QuickFix]" },
        { '<leader>Tq', function() require('todo-comments.search').setqflist({ keywords = vcount2keywords() }) end, desc = 'List all project todos [QuickFix]' },
        -- { "<leader>tl", "<cmd>TodoLocList<CR>", desc = "List all project todos [LocList]" },
        { '<leader>Tl', function() require('todo-comments.search').setloclist({ keywords = vcount2keywords() }) end, desc = 'List all project todos [LocList]' },
        -- { "<leader>tx", "<cmd>TodoTrouble<CR>", desc = "List all project todos [Trouble]" },
        { '<leader>Tx', function() require('trouble').open({ mode = 'todo', keywords = vcount2keywords() }) end, desc = 'List all project todos [Trouble]' },

        --   -- would be cool if desc could get variable from previous function (to show FIX, etc...), maybe use vim.g.*?
        --   -- desc = "List all " .. vim.v.count .. " todos [Telescope]",
          -- { "<leader>tp", function () Snacks.picker.todo_comments({keywords = vcount2keywords() and vim.split(vcount2keywords(), ',') or nil}) end, desc = "Todo/Fix/Fixme" },
          -- doesn't actually search in comments though, in everything...
          { "<space>:", function () Snacks.picker.todo_comments({keywords = vcount2keywords() and vim.split(vcount2keywords(), ',') or nil}) end, desc = "Todo/Fix/Fixme" },
          -- { "<space>Tb", function () Snacks.picker.todo_comments({cwd=vim.fn.expand("%:h"), search=vim.fn.expand("%:t"),keywords = vcount2keywords() and vim.split(vcount2keywords(), ',') or nil}) end, desc = "Todo/Fix/Fixme" },
          -- find better solution
          { "<space>;", function () Snacks.picker.todo_comments({cwd=vim.fn.expand("%:h"),pattern=vim.fn.expand("%:t"), keywords = vcount2keywords() and vim.split(vcount2keywords(), ',') or nil}) end, desc = "Todo/Fix/Fixme" },
      }
    end,
    opts = {
      highlight = {
        -- i'd like the colon to be optional, for stuff like headings todo
        pattern = [[(KEYWORDS)\s*(\([^\)]*\))?:]],
        keyword = 'bg',
        after = '',
      },
      -- Stessi colori dei chakra, inoltre puoi pensare alla combinazione rgb come alla combinazione hex
      -- maybe first color black? (2^0)
      colors = {
        error = { 'DiagnosticError', 'ErrorMsg', '#ff0000' },
        warning = { 'DiagnosticWarn', 'WarningMsg', '#ffa500' },
        info = { 'DiagnosticInfo', '#ffff00' },
        hint = { 'DiagnosticHint', '#00ff00' },
        default = { 'Identifier', '#0000ff' },
        test = { 'Identifier', '#800080' },
      },
    },
    config = function(_, opts)
      require('todo-comments').setup(opts)
      -- li tengo qui che magari il mapping ]t può tornare utile, anzi no
      -- You can also specify a list of valid jump keywords
      -- vim.keymap.set("n", "]t", function() require("todo-comments").jump_next({ keywords = { "ERROR", "WARNING" } }) end, { desc = "Next error/warning todo comment" })
    end,
  },
  -- doesn't work
--   {
--     "nvim-lualine/lualine.nvim",
--     optional = true,
--     lazy = false,
--     dependencies = {
--         { "bezhermoso/todos-lualine.nvim" },
--         { "folke/todo-comments.nvim" } -- REQUIRED!
--     },
--     config = function ()
--         -- Create the todos-lualine component:
--         local todos_component = require("todos-lualine").component()
--         require('lualine').setup({
--             tabline = {
--                 -- Add it to whichever section you'd like e.g. right next to "progress" on the right:
--                 lualine_y = {'progress', todos_component },
--             }
--         })
--     end,
-- },
}

-- controlla che non hai scritto cose tipo ToDO: etc... (typos in todo comments...)
