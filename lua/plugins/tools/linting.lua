-- how to show source (like lsp/linting tool) in quickfix???
return {
  {
    -- can you have multiple linters per filetype?
    -- How to disable certain errors like line too long?
    'mfussenegger/nvim-lint',
    -- Inutile se c'ho keys, right?
    -- event = { 'BufReadPre', 'BufNewFile' },
    keys = {
      -- mapping for current buffer and for whole workspace?
      {
        'm<cr>',
        function()
          -- TODO: show message if there are no errors...
          require('lint').try_lint()
          -- require("lint").try_lint(nil, { ignore_errors = true })
        end,
        desc = 'Lint file',
      },
    },
    config = function()
      local lint = require('lint')
      lint.linters_by_ft = {
        -- ["*"] = { "cspell", "codespell" },
        -- doesn't work
        -- ["*"] = { "codespell" },
        sh = { 'shellcheck' }, --shellharden?
        bash = { 'shellcheck' },
        lua = { 'luacheck' },
        html = { 'tidy' },
        swift = { 'swiftlint' },
        gitcommit = { 'gitlint' },
        -- javascript = { "jshint" },
        markdown = { 'markdownlint' },
        vimwiki = { 'markdownlint' },
        -- java = { 'checkstyle' },
        -- python = { "mypy", "pylint" },
        -- css = {'stylelint',},
        -- scss = {'stylelint',},
      }

      -- vim.api.nvim_create_autocmd(
      --   { 'BufWritePost', 'BufReadPost', 'InsertLeave', 'TextChanged' },
      --   {
      --     group = vim.api.nvim_create_augroup('lint', { clear = true }),
      --     callback = function()
      --       -- require('lint').try_lint('compiler')
      --       require('lint').try_lint()
      --     end,
      --   }
      -- )

      -- vim.keymap.set("n", "m<CR>", function() require("lint").try_lint() end, { desc = "Lint file" })

      -- ╭─────────────────────────────────────────────────────────╮
      -- │ Linter config                                           │
      -- ╰─────────────────────────────────────────────────────────╯
      local luacheck = require('lint').linters.luacheck
      luacheck.args = { '--formatter', 'plain', '--codes', '--ranges', '-', '--globals', 'vim','--no-max-line-length' }

      local markdownlint = require('lint').linters.markdownlint
      -- markdownlint.args = {'--disable','MD013','--'}
      markdownlint.args = { '--disable=MD013', '--' }
      -- ╭─────────────────────────────────────────────────────────╮
      -- │ LintInfo                                                │
      -- ╰─────────────────────────────────────────────────────────╯
      ---@see https://github.com/mfussenegger/nvim-lint/issues/559#issuecomment-2263995711
      -- Show linters for the current buffer's file type
      vim.api.nvim_create_user_command('LintInfo', function()
        local filetype = vim.bo.filetype
        local linters = require('lint').linters_by_ft[filetype]

        if linters then
          print('Linters for ' .. filetype .. ': ' .. table.concat(linters, ', '))
        else
          print('No linters configured for filetype: ' .. filetype)
        end
      end, {})
    end,
  },

  -- how to use have cwd as workspace (or .git???)

  -- autocmd BufWinEnter,BufEnter * lua require("trouble").action("on_win_enter")
  -- gitsigns: If installed and enabled (via config.trouble; defaults to true if installed), :Gitsigns setqflist or :Gitsigns seqloclist will open Trouble instead of Neovim's built-in quickfix or location list windows.
}
--   use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}
-- dispatch-like mappings
-- vim.keymap.set('n','m<cr>', ':make<cr>')
-- vim.keymap.set('n','m<c-n>', ':make -n<cr>')
-- vim.keymap.set('n','m<c-d>', ':make -d<cr>')
-- vim.keymap.set('n','M<c-d>', ':make -d ')
-- http://vimdoc.sourceforge.net/htmldoc/quickfix.html#compiler-select
-- let g:compiler_gcc_ignore_unmatched_lines = 1
