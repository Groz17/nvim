-- integra con unimpaired
--local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"
-- vim way: ; goes to the direction you were moving.
-- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
-- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)
-- Furthermore, you can make any custom movements (e.g. from another plugin) repeatable with the same keys. This doesn't need to be treesitter-related.
--
-- -- example: make gitsigns.nvim movement repeatable with ; and , keys.
-- local gs = require("gitsigns")
-- make this also work with unimpaired
--
-- -- make sure forward function comes first
-- local next_hunk_repeat, prev_hunk_repeat = ts_repeat_move.make_repeatable_move_pair(gs.next_hunk, gs.prev_hunk)
-- -- Or, use `make_repeatable_move` or `set_last_move` functions for more control. See the code for instructions.

return
-- recommend updating the parsers on update
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
      { 'nvim-treesitter/nvim-treesitter-refactor' },
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
        enable = true,
        keymaps = {
          -- visual mode buffata
	   --like expand-region emacs?
        -- init_selection = '<c-=>',
        init_selection = '<a-v>',
        -- init_selection = '<space><space>',
        -- does it work like an hydra? like only after init_selection?
        -- could be interesting for macros
        -- magari usa ; e ,? (https://github.com/folke/flash.nvim)
        -- node_incremental = '.',
        -- ; as in next (increment)
        -- node_incremental = ';',
        -- scope_incremental = 'grc',
        -- node_decremental = ',',
          -- init_selection = "gnn",
          -- node_incremental = "grn",
          -- scope_incremental = "grc",
          -- node_decremental = "grm",
          -- init_selection = "<CR>",
          -- scope_incremental = "<CR>",
          -- node_incremental = "<TAB>",
          -- node_decremental = "<S-TAB>",

          -- how to make vim.g.count work here?
          -- maybe use v in visual mode?
          -- init_selection = '<c-space>',
          -- node_incremental = '<c-space>',
          -- scope_incremental = '<c-s>',
          -- node_decremental = '<M-space>',
          -- { "<bs>", desc = "decrement selection", mode = "x" },
        },
      },

      refactor = {
        highlight_definitions = { enable = true },
        -- sostituisce il block box neovim plugin
        highlight_current_scope = { enable = false },
        -- smart_rename = {
          --   enable = true,
          --   keymaps = {
            --     -- smart_rename = "grr",
            --   },
            -- },

            navigation = {
              enable = false,
              keymaps = {
                -- use emacs keymaps
                -- goto_definition = "gnd",
                -- list_definitions = "gnD",
                goto_definition = false,
                list_definitions = false,
                -- list_definitions_toc = "gO",
                -- emacs?
                -- goto_next_usage = "<a-*>",
                -- goto_previous_usage = "<a-#>",
              },
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
-- Navigation around the AST tree.
-- https://github.com/aaronik/treewalker.nvim
--https://github.com/ruicsh/nvim-config/blob/main/lua/plugins/treewalker.lua
{
	"aaronik/treewalker.nvim",
  cond=false,
	keys = function()
		local tw = require("treewalker")

		return{
      -- similar to orgmode ig
			{ "<c-j>", tw.move_down, "Jump to next sibling node", { mode = { "n", "x" } } },
			{ "<c-k>", tw.move_up, "Jump to previous sibling node", { mode = { "n", "x" } } },
			{ "<c-h>", tw.move_out, "Jump to parent", { mode = { "n", "x" } } },
			{ "<c-l>", tw.move_in, "Jump to child", { mode = { "n", "x" } } },
			{ "<m-k>", tw.swap_up, "Swap up" },
			{ "<m-j>", tw.swap_down, "Swap down" },
			{ "<m-h>", tw.swap_left, "Swap left" },
			{ "<m-l>", tw.swap_right, "Swap right" },
    }
	end,

	enabled = not vim.g.vscode,
},


      -- -- --    "" lua << EOF
      -- -- --    "" local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
      -- -- --
      -- -- --    "" parser_configs.markdown = {
        -- -- --    ""   install_info = {
          -- -- --    ""     url = "https://github.com/ikatyang/tree-sitter-markdown",
          -- -- --    ""     files = { "src/parser.c", "src/scanner.cc" },
          -- -- --    ""   },
          -- -- --    ""   filetype = "markdown",
          -- -- --    "" }
          -- -- --    "" EOF
          -- -- --
          -- -- --    " nnoremap cof :set foldmethod=expr<cr>:set foldexpr=nvim_treesitter#foldexpr()<cr>
          -- -- --    " treesitter foldexpr
          -- -- --    " nnoremap <leader>tf :set foldmethod=expr<cr>:set foldexpr=nvim_treesitter#foldexpr()<cr>
          -- -- --    " nnoremap <leader>ff :set foldmethod=expr<cr>:set foldexpr=nvim_treesitter#foldexpr()<cr>
          -- -- --    " fo -> fold, easy peasy
          -- -- --    " nnoremap <leader>fo :set foldmethod=expr<cr>:set foldexpr=nvim_treesitter#foldexpr()<cr>
          -- -- --    " e like fx (json) mapping, it's also easier to type
          -- -- --    nnoremap <leader>fe :set foldmethod=expr<cr>:set foldexpr=nvim_treesitter#foldexpr()<cr>
          -- -- --
          -- -- --    " tree_sitter fold
          -- -- --    " nnoremap <leader>tf :set foldmethod=expr<cr>:set foldexpr=nvim_treesitter#foldexpr()<cr>
          -- -- --    " nnoremap <bar> <leader>h :if set foldmethod=expr | set foldexpr=nvim_treesitter#foldexpr() | else | set foldmethod=expr | set foldexpr=nvim_treesitter#foldexpr() | endif<cr>
          -- -- --
          -- -- --    " echo nvim_treesitter#statusline(90)  " 90 can be any length
          -- -- --    " module->expression_statement->call->identifier
          -- -- --
          -- -- --    " I WANT TARGETS.VIM EVERYWHERE
          -- -- --    "nnoremap if goto functionif
          -- -- --


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
              ft = { "astro", "glimmer", "handlebars", "html", "javascript", "jsx", "markdown", "php", "rescript", "svelte", "tsx", "twig", "typescript", "vue", "xml", "eruby", "htmlangular", "htmldjango", "elixir", "blade", "javascriptreact", "javascript.jsx", "typescript.tsx", "hbs", "rust" },
              opts =
              { opts = {
                per_filetype = {
                  vimwiki = {
                    enable_close = false, -- Auto close tags
                    enable_rename = false, -- Auto rename pairs of tags
                  }
                },
                enable_close_on_slash = true -- Auto close on trailing </
              }}
            },
            {
              -- would be cool if I could use operator & texobjects... like f for function_definition?
              -- complete with only treesitter nodes existing in current buffer?
              -- If `nvim-treesitter-textobjects` is installed, you can directly use treesitter captures instead of types in your sort groups, i.e:
              -- would be cool to expand (in cmdline) ad esempio af to @function.outer (maybe query mini.ai opts?), ofc only when you're already inserted :\s*TSort\s*
              "maxbol/treesorter.nvim",
              dependencies = "nvim-treesitter/nvim-treesitter-textobjects",
              -- require("treesorter").sort({"function_definition+declaration", "method"})
              cmd = "TSort",
              opts = {},
              -- keys={
                -- TODO: usa stessi mapping di nvim-treesitter-textobjects
                -- { "<leader>sf", ":TSort @function.outer<CR>", noremap = true, silent = true },
              -- }
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
