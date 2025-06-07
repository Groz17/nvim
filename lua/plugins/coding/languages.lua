-- plugins that are specific to certain language(s)

-- A nice idea would be to have a "filetype prefix" <Leader> mapping for all the mappings a filetype plugin provides

-- here put only generic mappings like REPL? xidelplay

-- show diagnostic in markdown codeblocks? for ortographic errors mainly
return {

  {
    -- would be nice if you switched json buffer filter and output would be associated with that one you switched to
    -- would be nice if after manually deleted the associated buffers the sessions closed by itself
    -- Make something like this, but for xml and xpath (with xidel maybe)
    -- TODO: add completion (for JSON fields?) to *play plugin
    'phelipetls/vim-jqplay',
    init = function()

      vim.g.jqplay = { mods = 'vertical' }

      -- Wish it switched to jq:filter buf after running play/run/etc... by default... It works with LazyLoad!
      -- vim.api.nvim_create_autocmd("User",
      --   {
      --     group = vim.api.nvim_create_augroup("SwitchToFilterBuffer", {}),
      --     pattern = "LazyLoad",
      --     callback = function(e)
      --       if e.data == "vim-jqplay" then
      --         for _,b in pairs(vim.fn.getbufinfo()) do
      --           if string.match(b.name,"^jq%-filter://.*%.json$")  then
      --             vim.fn.win_gotoid(b.windows[1])
      --             return
      --           end
      --         end
      --       end
      --     end
      --   })
    end,

    -- stylua: ignore start
    keys = {
      {"<LocalLeader>jj", "<CMD>Jqplay<CR>", desc="Interactive session",ft = 'json' },
      {"<LocalLeader>jJ", ":Jqplay<Space>", desc="Interactive session + provided jq options",ft = 'json' },
      {"<LocalLeader>js","<CMD>JqplayScratch<CR>", desc="Jqplay + new scratch buffer.",ft = 'json'},
      {"<LocalLeader>jS",":JqplayScratch<Space>", desc="JqplayScratch + provided jq options",ft = 'json'},
      -- n stands for --null

      -- Once an interactive session is started the following commands are available:
      {"<LocalLeader>jc","<CMD>JqplayClose<CR>",desc="Stop the interactive session.",ft = 'json'},
      {"<LocalLeader>jd","<CMD>JqplayClose!<CR>",desc="Stop the interactive session + delete buffers",ft = 'json'},
      {"<LocalLeader>jr",":Jqrun<space>",desc="Invoke jq manually with the provided jq options",ft = 'json'},
      {"<LocalLeader>jR",":Jqrun!<space>",desc="Invoke jq manually with the overriding provided jq options",ft = 'json'},
      {"<LocalLeader>jq","<CMD>Jqstop<CR>",desc="Terminate a running jq process started by this plugin",ft = 'json'},
    },
    -- stylua: ignore end
    config = function() end,
  },
  {
    'midoBB/nvim-quicktype',
    cmd = 'QuickType',
    ft = { 'typescript', 'python', 'java', 'go', 'rust', 'cs', 'swift', 'elixir', 'kotlin', 'typescriptreact' },
  },
  -- yaml: https://github.com/ray-x/yamlmatter.nvim (https://www.reddit.com/r/neovim/comments/1fjj99v/rayxyamlmatternvim_a_neovim_plugin_to_pretty/)

  -----------------------------------------------------------
  -- HTLM/CSS
  -----------------------------------------------------------
  -- https://github.com/jdrupal-dev/css-vars.nvim
  --     { "Jezda1337/nvim-html-css",
  --         dependencies = {
  --             "nvim-treesitter/nvim-treesitter",
  --             "nvim-lua/plenary.nvim"
  --         },
  --         config = function()
  --             require("html-css"):setup()
  --         end
  --     },
  {
    'ziontee113/deliberate.nvim',
    cond = false,
    dependencies = {
      {
        'nvimtools/hydra.nvim',
      },
    },
    config = function()
      local supported_filetypes = { 'typescriptreact', 'svelte' }
      local augroup =
        vim.api.nvim_create_augroup('DeliberateEntryPoint', { clear = true })
      vim.api.nvim_create_autocmd({ 'FileType' }, {
        pattern = supported_filetypes,
        group = augroup,
        callback = function()
          local bufnr = vim.api.nvim_get_current_buf()
          if vim.tbl_contains(supported_filetypes, vim.bo.ft) then
            vim.keymap.set('n', '<Esc>', function() vim.api.nvim_input('<Plug>DeliberateHydraEsc') end, { buffer = bufnr })
            vim.keymap.set('i', '<Plug>DeliberateHydraEsc', '<Nop>', {})
          end
        end,
      })

      require('deliberate.hydra')
    end,
  },
  -- ╭─────────────────────────────────────────────────────────╮
  -- │ RTF                                                     │
  -- ╰─────────────────────────────────────────────────────────╯
  {
    -- "jocap/rich.vim",
    --     cond=false,
  },

  -----------------------------------------------------------
  -- DART
  -----------------------------------------------------------
  -- {
  --   'nvim-flutter/flutter-tools.nvim',
  --   -- TODO: ft = 'dart'?
  --   lazy = false,
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --   },
  --   config = true,
  -- },

  -----------------------------------------------------------
  -- PEST
  -----------------------------------------------------------
  {
    'pest-parser/pest.vim',
    opts = {},
    ft = 'pest',
    enabled = false,
  },

  -- xml, xls, xquery, etc...??
  -- {
  --   "sukima/xmledit", ft ='xml'
  -- }

  -- ╭─────────────────────────────────────────────────────────╮
  -- │ META                                                    │
  -- ╰─────────────────────────────────────────────────────────╯
  {
    dir = '~/.config/nvim/viml/plugins/vim-xidelplay/',
    cond = false,
    ft = {'xml','html'},
    init = function() vim.g.xidelplay = { mods = 'vertical' } end,
    config = function()
      -- vim.filetype.add({ pattern = { ['xidel-filter://.*'] = 'xquery' }, })
      -- vim.cmd('bufdo if &ft == "xidel" | set ft=xquery | endif')
      -- vim.cmd('autocmd BufRead,BufNewFile xidel-filter* setlocal filetype=xquery')
    end,
    -- Would be cool if lazy scoped those key per filetype... (only allowed them in xml in this case for example)
    -- stylua: ignore start
    keys = {
      {"<LocalLeader>jj", "<CMD>Xidelplay<CR>", desc="Interactive session" },
      {"<LocalLeader>jJ", ":Xidelplay<Space>", desc="Interactive session + provided xidel options" },
      {"<LocalLeader>js","<CMD>XidelplayScratch<CR>", desc="Xidelplay + new scratch buffer."},
      {"<LocalLeader>jS",":XidelplayScratch<Space>", desc="XidelplayScratch + provided xidel options"},
      -- n stands for --null
      {"<LocalLeader>jn","<CMD>XidelplayScratch!<CR>",desc="XidelplayScratch + forces --null-input "},
      {"<LocalLeader>jN",":XidelplayScratch!<Space>",desc="XidelplayScratch! + provided xidel options"},

      -- Once an interactive session is started the following commands are available:
      {"<LocalLeader>jc","<CMD>XidelplayClose<CR>",desc="Stop the interactive session."},
      {"<LocalLeader>jd","<CMD>XidelplayClose!<CR>",desc="Stop the interactive session + delete buffers"},
      {"<LocalLeader>jr",":Xidelrun<space>",desc="Invoke xidel manually with the provided xidel options"},
      {"<LocalLeader>jR",":Xidelrun!<space>",desc="Invoke xidel manually with the overriding provided xidel options"},
      {"<LocalLeader>jx","<CMD>Xidelstop<CR>",desc="Terminate a running xidel process started by this plugin"},
    },
    -- stylua: ignore end
  },
  {
    'bollu/vim-apl',
    ft = 'apl',
    init = function() vim.g.apl_prefix_key = '`' end,
    enabled = false,
  },
  -- ╭─────────────────────────────────────────────────────────╮
  -- │ latex                                                   │
  -- ╰─────────────────────────────────────────────────────────╯
  -- https://github.com/brennier/quicktex

  -- { "chrisbra/csv.vim", ft = { "csv" } },
  -- { "mustache/vim-mustache-handlebars", ft = { "handlebars", "mustache" } },

  -- ╭─────────────────────────────────────────────────────────╮
  -- │ Graphviz                                                │
  -- ╰─────────────────────────────────────────────────────────╯
  {
    'wannesm/wmgraphviz.vim',
    ft = 'dot',
    enabled = false,
  },
  -- ╭─────────────────────────────────────────────────────────╮
  -- │                       Injections                        │
  -- ╰─────────────────────────────────────────────────────────╯
  -- {
  --   'AckslD/nvim-FeMaco.lua',
  --   keys = {
  --     {
  --       '<leader>-',
  --       function() require('femaco.edit').edit_code_block() end,
  --       desc = 'Edit injected language trees',
  --     },
  --   },
  --   opts = {},
  -- },
{
  -- does this work with markdown/vimwiki?
    'jmbuhr/otter.nvim',
    cond = false,
    -- event = 'LspAttach',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {},
},
}
