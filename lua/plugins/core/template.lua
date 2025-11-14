-- @ mapping like systemd templates
-- lsp for these template files?
-- how to automatically start insert?
-- issue: use java/default (no extension) and java/Main.java (put extension for filename)
-- keybinding idea: # (like org export template)
-- don't start lsp if inside skeletons dir?
return {
  'cvigilv/esqueleto.nvim',
  init = function()
    vim.api.nvim_create_autocmd('BufEnter',{
      group=vim.api.nvim_create_augroup('TemplateFileType',{clear=true}),
      pattern = vim.fn.stdpath('config') .. '/skeletons/**',
      command = 'set ft='
    })
  end,
  opts = {
    -- patterns = {'Main.java'}
  },
}

-- use like img-clip settings
-- For files and directories, you can specify settings that apply to only a
-- specific file or directory using its absolute path
-- (e.g. `/home/user/project/README.md`). You can also specify a general file or
-- directory name (e.g. `README.md`) which will apply the settings to any
-- `README.md` file. For custom options, you can specify a _trigger_ function that
-- returns a boolean value that is used to enable it.
