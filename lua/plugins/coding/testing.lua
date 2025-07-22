-- https://github.com/andythigpen/nvim-coverage
return {{
  -- how to jump to next test?
  'nvim-neotest/neotest',
  lazy = true,
  -- add fzf-lua if no arguments in command
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  -- GOAT STUFF: https://github.com/nvim-neotest/neotest-python/issues/52#issuecomment-1676568667
  opts = function()
    return {
    }
  end,
  -- ["T"] = {
  --   name = "Test",
  keys = {
    { '<leader>tt', function() require('neotest').run.run() end, desc = 'Nearest' },
    { '<leader>tf', function() require('neotest').run.run(vim.fn.expand('%')) end, desc = 'Current file' },
    { '<leader>td', function() require('neotest').run.run({ strategy = 'dap' }) end, desc = 'Debug Nearest' },
    { '<leader>ta', function() require('neotest').run.run({ suite = true }) end, desc = 'All' },
    -- undefined field cwd
    -- { '<leader>tc', function() require('neotest').run.run(vim.uv.cwd()) end, desc = 'CWD' },
    { '<leader>tl', function() require('neotest').run.run_last() end, desc = 'Last' },
    { '<leader>ts', function() require('neotest').run.stop() end, desc = 'Stop' },
    { '<leader>to', function() require('neotest').output.open({ enter = true, auto_close = true }) end, desc = 'Show output' },
    { '<leader>tO', function() require('neotest').output_panel.toggle() end, desc = 'Toggle output panel' },
    { '<leader>tA', function() require('neotest').run.attach() end, desc = 'Attach' },
  },
},

{
  -- for coverage use <leader>c?
    "andythigpen/nvim-coverage",
    --- @see https://github.com/mozilla/grcov#usage
    dependencies = { "nvim-lua/plenary.nvim", },
    -- maybe use <leader>T as prefix?
    cond = false,
		cmd = { "Coverage", "CoverageSummary", "CoverageLoad", "CoverageShow", "CoverageHide", "CoverageToggle", "CoverageClear" },
    keys = {
      { '<leader>cl', function() require('coverage').load(true) end, desc = 'load' },
      { '<leader>cc', function() require('coverage').clear() end, desc = 'clear' },
      { '<leader>ct', function() require('coverage').toggle() end, desc = 'toggle' },
      { '<leader>cs', function() require('coverage').summary() end, desc = 'summary' },
      { ']u', function() require('coverage').jump_next('uncovered') end, 'jump next uncovered' },
      { '[u', function() require('coverage').jump_prev('uncovered') end, 'jump prev uncovered' },
    },
    opts = {}
}
}
-- -- Testing
-- wk.register({
--   ['<leader>t'] = {
--     name = 'Testing',
--     l = { '<cmd>Tclear!<cr><cmd>TestLast<cr>', 'Run previous test again' },
--     t = { '<cmd>Tclear!<cr><cmd>TestFile<cr>', 'Run tests in file' },
--     n = { '<cmd>Tclear!<cr><cmd>TestNearest<cr>', 'Run test close to cursor' },
--     v = { '<cmd>Tclear!<cr><cmd>TestVisit<cr>', 'Run test close to cursor' },
--     u = { name = 'Ultitest', t = { ':Ultest<cr>', 'Run tests in file' } },
--     d = {
--       name = 'Debug',
--       t = { ':UltestDebug<cr>', 'Debug tests in file' },
--       n = { ':UltestDebugNearest<cr>', 'Debug test close to cursor' },
--     },
--   },
-- })

-- " == vim-test ==
-- " these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
-- nmap <silent> t<C-n> :TestNearest<CR>
-- nmap <silent> t<C-f> :TestFile<CR>
-- nmap <silent> t<C-s> :TestSuite<CR>
-- nmap <silent> t<C-l> :TestLast<CR>
-- nmap <silent> t<C-g> :TestVisit<CR>
--

-- local dict =   { --[[ neotest ]]
--        "nvim-neotest/neotest",
--        dependencies = {
--            {
--                "rcarriga/neotest-plenary",
--                dependencies = "nvim-lua/plenary.nvim",
--            },
--            "haydenmeade/neotest-jest",
--        },
--        cmd = { "Neotest" },
--        config = function()
--            local namespace = vim.api.nvim_create_namespace("neotest")
--            vim.diagnostic.config({
--                virtual_text = {
--                    format = function(diagnostic)
--                        return diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
--                    end,
--                },
--            }, namespace)
--            require("neotest").setup({
--                discovery = { enabled = true },
--                diagnostic = { enabled = true },
--                -- floating = { border = lk.style.border.rounded },
--                quickfix = { enabled = false, open = true },
--                adapters = {
--                    require("neotest-jest")({
--                        jestCommand = "npm test --",
--                        env = { CI = true },
--                        cwd = function()
--                            return vim.fn.getcwd()
--                        end,
--                    }),
--                },
--                -- overseer.nvim
--                consumers = {
--                    overseer = require("neotest.consumers.overseer"),
--                },
--                overseer = {
--                    enabled = true,
--                    force_default = true,
--                },
--            })
--        end,

--            local wk = require("which-key")
--            wk.register({
--                ["n"] = {
--                    ["name"] = "+neotest",
--                    ["f"] = { function() neotest().run.run(vim.fn.expand("%")) end, "run-file" },
--                    ["F"] = { function() neotest().run.run({ vim.fn.expand("%"), concurrent = false }) end, "run-file-sync" },
--                    ["n"] = { function() neotest().jump.prev({ status = "failed" }) end, "next-failed" },
--                    ["o"] = { function() neotest().output.open({ enter = true, short = false }) end, "open" },
--                    ["p"] = { function() neotest().jump.next({ status = "failed" }) end, "prev-failed" },
--                    ["q"] = { function() neotest().run.stop({ interactive = true }) end, "cancel" },
--                    ["r"] = { function() neotest().run.run() end, "nearest" },
--                    ["t"] = { function() neotest().summary.toggle() end, "toggle-summary" },
