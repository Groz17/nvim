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
