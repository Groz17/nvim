-- https://github.com/stevearc/conform.nvim/blob/339b3e4519ec49312d34fcfa275aa15bfaa67025/scripts/autoformat_doc.lua#L4
-- https://www.reddit.com/r/neovim/comments/1hbst6x/lazyvim_conformnvim_uses_wrong_ft/
-- https://github.com/skywind3000/vim-rt-format/blob/master/plugin/rtformat.vim

-- how to modify formatting to adjust to current indentation?
-- would be nice if with for ex <leader>f, (, for vim.g.tleader) or <leader>fF (more standard) it showed a telescope window with all formatting actions you can take, like trim whitespace, collapse, etc...
-- would be nice if it didn't change contents, the file won't be shown modified

-- when you've got multiple formatters, open telescope dialog to choose, or allow vim.v.count to automatically select the one you want

-- easing function? like to make the formatting appear easier on the eyes?
return {
  -- send errors/warnings/diff blocks to loclist?
  'stevearc/conform.nvim',
  -- add formatter-agnostic keybindings to disable format? like stylua:ignore and sql-formatter-disable (gcd (start) and gcD (end))
  -- lazy-loads: press gq (formatxpr) to load
  cmd = { 'ConformInfo' },
  -- for dadbod-ui buffer (acts as bufwritepre)
  -- TODO: format only if sql executed succesfully
  ft = 'sql',
  -- https://youtu.be/E-NAM9U5JYE?t=1725
  -- c-xh gq is also cool
  keys = { 'gq' },
  -- This will provide type hinting with LuaLS
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    -- default_format_opts={
    --   timeout_ms = 3000,
    -- },
    log_level = vim.log.levels.DEBUG,
    -- difference between these two?
    -- lsp_format = 'first',
    lsp_format = 'never',
    -- use vim.ui.select if multiple formatters?
    formatters_by_ft = {
      -- Use the "*" filetype to run formatters on all filetypes.
      -- ['*'] = { 'codespell' },
      -- Use the "_" filetype to run formatters on filetypes that don't have other formatters configured.
      -- maybe use gw (or gW) for this (w/W for whitespace)
      -- how to run only this formatter with a mapping?
      -- ["_"] = { "trim_whitespace" },
      -- go         = { "goimports", "gofumpt" },
      python = { 'isort', 'black' },
      json = { 'jq' },
      jsonc = { 'biome' },
      -- javascript = { { 'prettierd', 'prettier' } },
      --  Also biome is far superior to prettier.  (https://www.reddit.com/r/neovim/comments/1hbst6x/comment/m1ki7dd/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button)
      -- javascript = { 'prettier' },
      javascript = { 'biome' },
      -- adds newline at the end
      -- html    = { "htmlbeautifier" },
      -- doesn't seem to work in visual mode?
      -- html = { 'prettier' },
      markdown = { 'prettier' },
      vimwiki = { 'prettier' },
      css = { 'prettier' },
      perl = { 'perltidy' },
      less = { 'prettier' },
      scss = { 'prettier' },
      -- bash = { 'shellcheck' },
      bash = { 'shfmt' },
      -- sql = { 'sql_formatter' },
      -- toml = { 'taplo' },
      lua = { 'stylua' },
      -- BUG: formatexpr set by setlocal formatexpr=xmlformat#Format()
      -- xml = { 'xmlformatter' },
      yaml = { 'yq' },
      asm = { 'asmfmt' },
      -- java = { 'google-java-format' },
      -- java = { 'clang-format' },
    },
    -- Set up format-on-save
    -- does the cursor position get saved here?
    -- format_on_save = function(bufnr)
    --   -- Disable autoformat on certain filetypes
    --   local whitelist = { 'sql', --[["java"]] }
    --   if vim.tbl_contains(whitelist, vim.bo[bufnr].filetype) then
    --     return { timeout_ms = 500, lsp_fallback = true }
    --   end
    -- end,
    -- Customize formatters
    formatters = {
      shfmt = { prepend_args = { '-i', '2' } },
      perltidy = { prepend_args = { '-i', '2', '-st', '-pt=2', --[[ ,'-nsak=while' ]] }, },
      sql_formatter = { prepend_args = { '--config', '{"keywordCase": "upper"}' }, },
      -- prepend_args = { '--config-path=' .. vim.env.HOME .. '/.config/stylua.toml' }
      stylua = { prepend_args = { '--config-path=' .. vim.env.HOME .. '/.config/nvim/stylua.toml', },
      },
    },
  },
  -- should i disable lsp formatexpr?
  init = function() vim.o.formatexpr = "v:lua.require'conform'.formatexpr()" end,
  config = function(_, opts)
    require('conform').setup(opts)
    -- vim.o.formatexpr = "v:lua.require'conform'.formatexpr({lsp_fallback = true})"
    -- vim.o.formatexpr = "v:lua.require'conform'.formatexpr(#{lsp_fallback=v:true},)"
    -- I want = to use formatters and gq to use lsp formatters (or vice-versa)
    -- vim.o.equalprg = "v:lua.require'conform'.formatexpr()"
  end,
}
