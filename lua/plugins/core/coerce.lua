-- hook with blink? keymappings for completions
return {
  {
    -- https://github.com/welitonfreitas/dotfiles/blob/c032a393e723097197215b68537c76c82498af4c/.config/nvim/lua/plugins/coerce.lua#L4
    --https://github.com/gregorias/coerce.nvim/issues/5
    -- LSP and fallback to this?
    'gregorias/coerce.nvim',
    dependencies = 
    {
      "gregorias/coop.nvim",
    },
    keys = { { 'cr' }, { mode = 'x', 'R' }, },
    opts = function()
      return {
        default_mode_keymap_prefixes = {
          normal_mode = 'cr',
          -- motion_mode = 'cr',
          -- motion_mode = 'cR', -- or EOL mapping?
          visual_mode = 'R',
        },
        cases = {
          { keymap = 'c', case = require('coerce.case').to_camel_case, description = 'camelCase' },
          { keymap = 'd', case = require('coerce.case').to_dot_case, description = 'dot.case' },
          { keymap = 'k', case = require('coerce.case').to_kebab_case, description = 'kebab-case' },
          { keymap = 'n', case = require('coerce.case').to_numerical_contraction, description = 'numeronym (n7m)' },
          { keymap = 'p', case = require('coerce.case').to_pascal_case, description = 'PascalCase' },
          { keymap = 's', case = require('coerce.case').to_snake_case, description = 'snake_case' },
          { keymap = 'u', case = require('coerce.case').to_upper_case, description = 'UPPER_CASE' },
          { keymap = 'f', case = require('coerce.case').to_path_case, description = 'path/case' },
          { keymap = 'a', case = require('coerce.case').to_space_case, description = 'space case' },
          -- -vim.keymap.set('n','crt',function() require('textcase').operator('to_title_case') end)
          -- -vim.keymap.set('n','cr,',function() require('textcase').operator('to_comma_case') end)
          -- -vim.keymap.set('n','crn',function() require('textcase').operator('to_constant_case') end)
        },
      }
    end,
    config = function(_,opts)
      require('coerce').setup(opts)
      -- TODO: this run before the mapping runs right?
      vim.opt.iskeyword:append('-')

    end,
  },
  {
    'tpope/vim-abolish',
    -- https://github.com/0styx0/abbreinder.nvim
    init = function()
      -- Disable coercion mappings. I use coerce.nvim for that.
      vim.g.abolish_no_mappings = true
    end,
    cmd = { 'S', 'Subvert', 'Abolish' },
  },
}
