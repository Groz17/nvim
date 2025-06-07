return {
  {
    -- packer.nvim
    -- would be nice to have telescope use it for help_tags and man_pages...
    -- tbl_islist add pr deprecated...
    'Tyler-Barham/floating-help.nvim',
    pin = true, -- vim.tbl_islist deprecated (fai PR)
    event = 'CmdlineEnter',
    -- only if not a LSP-powered buffer?
    -- keys = {'K'},
    opts = {
      -- Defaults
      width = 100, -- Whole numbers are columns/rows
      height = 0.73, -- Decimals are a percentage of the editor
      position = 'C', -- NW,N,NW,W,C,E,SW,S,SE (C==center)
      border = 'rounded', -- rounded,double,single
      onload = function(query_type) end, -- optional callback to be executed after help contents has been loaded
    },
    config = function(_, opts)
      local fh = require('floating-help')

      fh.setup(opts)

      -- Create a keymap for toggling the help window
      -- vim.keymap.set('n', '<F1>', fh.toggle)
      -- Create a keymap to search cppman for the word under the cursor
      -- vim.keymap.set('n', '<F2>', function() fh.open('t=cppman', vim.fn.expand('<cword>')) end)
      -- Create a keymap to search man for the word under the cursor
      -- vim.keymap.set('n', '<F3>', function() fh.open('t=man', vim.fn.expand('<cword>')) end)
      -- vim.keymap.set({'n','x'}, 'K', function() fh.open('t=man', vim.fn.expand('<cword>')) end)

    -- Only replace cmds, not search; only replace the first instance
    local function cmd_abbrev(abbrev, expansion)
      local cmd = 'cabbr ' .. abbrev .. ' <c-r>=(getcmdpos() == 1 && getcmdtype() == ":" ? "' .. expansion .. '" : "' .. abbrev .. '")<CR>'
      vim.cmd(cmd)
    end

      -- Redirect `:h` to `:FloatingHelp`
      cmd_abbrev('h', 'FloatingHelp')
      -- Would be nice to specify regex? even tough I mostly just use :h
      -- cmd_abbrev('he', 'FloatingHelp')
      -- cmd_abbrev('hel', 'FloatingHelp')
      cmd_abbrev('help', 'FloatingHelp')
      cmd_abbrev('helpc', 'FloatingHelpClose')
      cmd_abbrev('helpclose', 'FloatingHelpClose')
    end,
  },
  {
    -- BUG: For an in-depth setup of `snacks.nvim` with `lazy.nvim`, check the example (it shows .nvimm instead of .nvim)
    'OXY2DEV/helpview.nvim',
    -- lazy = false, -- Recommended
    -- In case you still want to lazy load
    ft = 'help',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      preview = {
        icon_provider = "mini",
      }

    }
  },

  -- https://github.com/alx741/vinfo/issues/6
  -- set ft=pinfo
  {
    -- support -o option? for jargon command
    'alx741/vinfo',
    cmd = { 'Vinfo' },
  },
  -- tldr? AI help? howdoi -c
}
