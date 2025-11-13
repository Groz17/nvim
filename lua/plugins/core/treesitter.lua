return
{
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufRead', 'BufNewFile' },
    dependencies = {
      --        {"nvim-treesitter/nvim-tree-docs"},
      -- { 'romgrk/nvim-treesitter-context' },
      -- lento in file markdown...
      -- { 'JoosepAlviste/nvim-ts-context-commentstring' },
      -- funge anche per html tags ;D
      { "HiPhish/rainbow-delimiters.nvim",
      main = 'rainbow-delimiters.setup',
      opts = {},
    },
      -- Usage: <div></div>    ciwspan<esc>   <span></span>
      -- these two should be part of autopairs tbh
      -- { 'brianhuster/nvim-treesitter-endwise',lazy=false,},
      -- { 'brianhuster/nvim-treesitter-endwise'},
      { 'RRethy/nvim-treesitter-endwise'},
    },
    build = ':TSUpdate',
    main='nvim-treesitter.configs',
    opts = {
      auto_install = true,
      -- ignore_install = { "latex" },
      tree_docs = {
        enable = true,
        spec_config = {
          jsdoc = {
            slots = {
              class = { author = true }
            }
          }
        }
      },

      -- ╭─────────────────────────────────────────────────────────╮
      -- │ Modules?                                                │
      -- ╰─────────────────────────────────────────────────────────╯
      -- Indentation based on treesitter for the = operator. NOTE: This is an experimental feature.
        -- BUG: messes with o, O, etc...
      indent = { enable = false },
      -- TODO: it should support alt-o as well...
      endwise = { enable = true },
      matchup = {
        enable = true, -- mandatory, false will disable the whole extension
        -- disable = { "c", "ruby" }, -- optional, list of language that will be disabled
        -- [options]
      },
      ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
      ignore_install = { 'org' },
      highlight = {
        enable = true,          -- false will disable the whole extension
        -- vimtex ftw
        -- disable = { "latex" },  -- list of language that will be disabled
        disable = {'csv'},
        additional_vim_regex_highlighting = {'org'},
        -- use_languagetree = true,
      },
      injection = {
        enable = true,
        query = os.getenv("HOME") .. '/.config/nvim/queries'  -- Path to your injection query file
      },
      -- query_dir = os.getenv("HOME") .. '/.config/nvim/queries', -- Specify your custom queries directory
      incremental_selection = {
        -- disable = false,
        -- would be cool if it showed (maybe as a notification) nvim-treesitter-textobjects name like @function.outer or smth or just InspectTree output
        enable = false,
        keymaps = {
        init_selection = '<a-v>',
        -- does it work like an hydra? like only after init_selection?
        -- could be interesting for macros
        -- node_incremental = '.',
        -- ; as in next (increment)
        -- node_incremental = ';',
        -- node_decremental = ',',

          -- how to make vim.g.count work here?
          -- maybe use v in visual mode?
        },
      },

            textobjects = {
              lsp_interop = {
                enable = true,
                border = 'none',
                floating_preview_opts = {},
                peek_definition_code = {
               -- ["gm"] = "@*",
               -- ["<leader>df"] = "@function.outer",
               -- ["<leader>dF"] = "@class.outer",
               -- mnemnonic: go hover
               -- ["gK"] = "@*", -- doesn't work?
               gK = "@function.outer",
                },
              },
              move = {
                enable = true,
                goto_next_start = {
                  [']f'] = '@function.outer',
                  -- [']a'] = '@argument.outer',
                  [']m'] = '@method.outer',
                  -- ...
                },
                goto_previous_start = {
                  ['[f'] = '@function.outer',
                  -- ['[a'] = '@argument.outer',
                  ['[m'] = '@method.outer',
                  -- ...
                },
              },
            },
        },

      },

          -- make this work w/ styler.nvim?
          {
            'nvim-treesitter/nvim-treesitter-context',
            lazy = false,
            keys =
            {
              {
                "[j",-- j di jump
                function() require("treesitter-context").go_to_context() end,
                desc = "Go to parent context",
                mode = {"n","x","o"},
              }},
                opts = {
                enable = true,   -- Enable this plugin (Can be enabled/disabled later via commands)
                throttle = true, -- Throttles plugin updates (may improve performance)
                max_lines = 0,   -- How many lines the window should span. Values <= 0 mean no limit.
                patterns = {
                  -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
                  -- For all filetypes
                  -- Note that setting an entry here replaces all other patterns for this entry.
                  -- By setting the 'default' entry below, you can control which nodes you want to
                  -- appear in the context window.
                  default = {
                    'class',
                    'function',
                    'method',
                    -- 'for', -- These won't appear in the context
                    -- 'while',
                    -- 'if',
                    -- 'switch',
                    -- 'case',
                  },
                  -- Example for a specific filetype.
                  -- If a pattern is missing, *open a PR* so everyone can benefit.
                  --   rust = {
                    --       'impl_item',
                    --   },
                  },
                }
            },
            {
              'windwp/nvim-ts-autotag',
              ft = { "astro", "glimmer", "handlebars", "html", "javascript", "jsx", "markdown", "php", "rescript",
                 "svelte", "tsx", "twig", "typescript", "vue", "xml", "eruby", "htmlangular", "htmldjango", "elixir",
                 "blade", "javascriptreact", "javascript.jsx", "typescript.tsx", "hbs", "rust" },
              opts = {
                opts = {
                per_filetype = {
                  vimwiki = {
                    enable_close = false, -- Auto close tags
                    enable_rename = false, -- Auto rename pairs of tags
                  }
                },
                enable_close_on_slash = true -- Auto close on trailing </
              }}
            },
          }

          -- M.treesitter_cmds = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSEnable", "TSDisable", "TSModuleInfo" }

          -- builtin.treesitter()                          *telescope.builtin.treesitter()*
          --     Lists function names, variables, and other symbols from treesitter queries
          --     - Default keymaps:
          --       - `<C-l>`: show autocompletion menu to prefilter your query by kind of ts
          --         node you want to see (i.e. `:var:`)
          --

          --
          -- -- How to make mini-ai work with this?
          -- local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
          -- parser_config.xquery = {
            --   install_info = {
              --     url = "~/.local/share/nvim/tree-sitter-xquery", -- where you have cloned this project
              --     files = {"src/parser.c"}
              --   },
              --   filetype = 'xquery',
              -- }
