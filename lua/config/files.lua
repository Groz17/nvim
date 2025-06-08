-- usalo per grep, todo, edit, etc...
-- magari usa picker projects?
-- check for equivalent emacs mappings?
local files = {
  config = {
    mapping = 'c',
    --TODO: exclude nvim dir
    path = vim.env.HOME .. '/.config/',
  },
  -- my_vim_config = {
  vim_config = {
    mapping = 'v',
    path = vim.fn.stdpath('config'),
  },
  vim_config_plugins = {
    mapping = 'p',
    path = vim.fn.stdpath('config') .. '/lua/plugins',
  },
  -- projects = {
  --   mapping = 'j',
  --   -- TODO: come combinare git ls-files dei vari projects?
  --   path = vim.env.HOME .. '/Projects',
  -- },
  -- other_projects = {
  --   mapping = 'J',
  --   -- TODO: come combinare git ls-files dei vari projects?
  --   path = vim.env.HOME .. '/Other_Projects',
  -- },
  -- -- usa uppercase version for others...
  -- config_other = {
  --   mapping = 'C',
  --   path = vim.env.WIKI_DATA .. '/dotfiles/git_repos',
  -- },
  -- vim_config_others = {
  --   mapping = 'V',
  --   path = vim.env.WIKI_DATA .. '/neovim_config/git_repos',
  -- },
  vim_plugins = {
    mapping = 'P',
    path = vim.fn.stdpath('data') .. '/lazy',
  },
  -- scripts = {
  --   mapping = 's',
  --   path = vim.env.HOME .. '/scripts'
  -- },
  -- code duplication... (other/uppercase?)
  -- Projects = {
  --   mapping = 'j',
  --   path = vim.env.HOME .. '/projects',
  --
  -- },
  -- Uso già i mapping di vimwiki.lua
  -- wiki               = {mapping = "", path = vim.env.HOME .. "/vimwiki"},
}

local actions = {
  grep = {
    -- TODO: trova mapping più confortevole
    -- mapping = '<space>g',
    mapping = '<space>F',
    func = function(path)
      -- how to ignore filenames when searching?
    -- rg -g *.lua -g *.vim
    Snacks.picker.grep({ cwd = path})
    end,
  },
  files = {
    -- would be cool to use without releasing keys...
    mapping = '<space>f',
    func = function(path)
    Snacks.picker.--[[git]]files({ cwd = path, layout={preset = "select",preview=false }})
    end,
  },
}

for action in pairs(actions) do
  require'which-key'.add({actions[action].mapping, group = action})
  for file in pairs(files) do
    vim.keymap.set(
      'n',
      actions[action].mapping .. files[file].mapping,
      function() actions[action].func(files[file].path) end,
      { desc = file }
    )
  end
end
