return {
  -- nix one day...
  cmd = { vim.fn.exepath'sql-language-server', 'up','--method','stdio' },
  filetypes = {'sql'},
  -- root_dir = function() return vim.loop.cwd() end,
  -- how to ignore sqlite lines? ones that start with . basically
  -- single_file_support = true,
  ---@see https://github.com/Lasagnanator/neovim/blob/02c8255a7b4469b34d24901be92c50c4ad629042/lua/langs/sql.lua#L19 (eroeee)
         -- per ispirazione: https://github.com/search?q=linebreak-after-clause-keyword+language%3ALua&type=code
  settings = {
    -- would be nice to have completion both global and settings
    sqlLanguageServer = {
      lint = {
        rules = {
          ['linebreak-after-clause-keyword'] = 'off',
        },
      },
    },
  },
}

   -- {
   --   "rules": {
   --     "align-column-to-the-first": 0,
   --     "column-new-line": 0,
   --     "linebreak-after-clause-keyword": 0,
   --     "reserved-word-case": [0,"upper"],
   --     "space-surrounding-operators": 0,
   --     "where-clause-new-line": 0
   --   }
   -- }
