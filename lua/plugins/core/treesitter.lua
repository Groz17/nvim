    -- dependencies = {
    --   --        {"nvim-treesitter/nvim-tree-docs"},
    --   -- { 'romgrk/nvim-treesitter-context' },
    --   -- lento in file markdown...
    --   -- { 'JoosepAlviste/nvim-ts-context-commentstring' },
    --   -- funge anche per html tags ;D
    --   { "HiPhish/rainbow-delimiters.nvim",
    --   main = 'rainbow-delimiters.setup',
    --   opts = {},
    -- },
      -- Usage: <div></div>    ciwspan<esc>   <span></span>
      -- these two should be part of autopairs tbh
      -- { 'brianhuster/nvim-treesitter-endwise',lazy=false,},
      -- { 'brianhuster/nvim-treesitter-endwise'},
      -- { 'RRethy/nvim-treesitter-endwise'},
    -- },
    -- opts = {
      -- tree_docs = {
      --   enable = true,
      --   spec_config = {
      --     jsdoc = {
      --       slots = {
      --         class = { author = true }
      --       }
      --     }
      --   }
      -- },

        -- BUG: messes with o, O, etc...
      -- indent = { enable = false },
      -- TODO: it should support alt-o as well...
      -- endwise = { enable = true },
      -- matchup = {
      --   enable = true, -- mandatory, false will disable the whole extension
      -- },






      -- ignore_install = { 'org' },
      -- highlight = {
      --   -- vimtex ftw
      --   -- disable = { "latex" },  -- list of language that will be disabled
      --   disable = {'csv'},
      --   additional_vim_regex_highlighting = {'org'},
      --   -- use_languagetree = true,
      -- },
      -- injection = { query = os.getenv("HOME") .. '/.config/nvim/queries'  -- Path to your injection query file },
      -- query_dir = os.getenv("HOME") .. '/.config/nvim/queries', -- Specify your custom queries directory
      -- incremental_selection = {
        -- would be cool if it showed (maybe as a notification) nvim-treesitter-textobjects name like @function.outer or smth or just InspectTree output
        -- keymaps = {
        -- does it work like an hydra? like only after init_selection?
        -- could be interesting for macros
          -- how to make vim.g.count work here?
          -- maybe use v in visual mode?
        -- },
      -- },

              --   peek_definition_code = {
              --  -- ["gm"] = "@*",
              --  -- ["<leader>df"] = "@function.outer",
              --  -- ["<leader>dF"] = "@class.outer",
              --  -- mnemnonic: go hover
              --  -- ["gK"] = "@*", -- doesn't work?
              --  gK = "@function.outer",
              --   },
              -- },
              -- move = { },

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
return
{
    "nvim-treesitter/nvim-treesitter",
    main = "nvim-treesitter",
    -- build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    init = function()
      local highlight = function(bufnr, lang)
        -------------------[ treesitter highlights ]-------------------------------
        if not vim.treesitter.language.add(lang) then
          return vim.notify(
            string.format("Treesitter cannot load parser for language: %s", lang),
            vim.log.levels.INFO,
            { title = "Treesitter" }
          )
        end
        vim.treesitter.start(bufnr)
      end

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local ft = vim.bo.filetype
          local bt = vim.bo.buftype
          local buf = args.buf

          if bt ~= "" then
            return
          end -- don't run further.

          local ok, treesitter = pcall(require, "nvim-treesitter")
          if not ok then
            return
          end

          --------------------[ treesitter folds ]-------------------------------

          if ft == "javascriptreact" or ft == "typescriptreact" then
            vim.opt_local.foldmethod = "indent"
          else
            vim.opt_local.foldmethod = "expr"
            vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
          end

          vim.schedule(function()
            -- Only run normal if we're not in terminal mode
            if vim.fn.mode() ~= "t" then
              vim.cmd "silent! normal! zx"
            end
          end)

          ---------------------[ treesitter indent ]-------------------------------

          if not vim.tbl_contains({ "python", "html", "yaml", "markdown" }, ft) then
            vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
          end

          --------------------[ treesitter parsers ]-------------------------------
          if vim.fn.executable "tree-sitter" ~= 1 then
            vim.api.nvim_echo({
              {
                "tree-sitter CLI not found. Parsers cannot be installed.",
                "ErrorMsg",
              },
            }, true, {})
            return false
          end

          if not vim.treesitter.language.get_lang(ft) then
            return
          end

          if vim.list_contains(treesitter.get_installed(), ft) then
            highlight(buf, ft)
          elseif vim.list_contains(treesitter.get_available(), ft) then
            treesitter.install(ft):await(function()
              highlight(buf, ft)
            end)
          end
        end,
      })
    end,
    opts = {
      install = {
        "css",
        "comment",
        "markdown",
        "markdown_inline",
        "regex",
        "vimdoc",
      },
    },
    config = function(_, opts)
      local treesitter = require "nvim-treesitter"
      treesitter.setup(opts)
      if vim.fn.executable "tree-sitter" ~= 1 then
        vim.api.nvim_echo({
          {
            "tree-sitter CLI not found. Parsers cannot be installed.",
            "ErrorMsg",
          },
        }, true, {})
        return false
      end
      treesitter.install(opts.install)
    end,
  }

  -- deps
          -- make this work w/ styler.nvim?
          --   {
          --     'windwp/nvim-ts-autotag',
          --     ft = { "astro", "glimmer", "handlebars", "html", "javascript", "jsx", "markdown", "php", "rescript",
          --        "svelte", "tsx", "twig", "typescript", "vue", "xml", "eruby", "htmlangular", "htmldjango", "elixir",
          --        "blade", "javascriptreact", "javascript.jsx", "typescript.tsx", "hbs", "rust" },
          --     opts = {
          --       opts = {
          --       per_filetype = {
          --         vimwiki = {
          --           enable_close = false, -- Auto close tags
          --           enable_rename = false, -- Auto rename pairs of tags
          --         }
          --       },
          --       enable_close_on_slash = true -- Auto close on trailing </
          --     }}
          --   },
          --
          -- {
          --   'nvim-treesitter/nvim-treesitter-context',
          --   lazy = false,
          --   keys =
          --   {
          --     {
          --       "[j",-- j di jump
          --       function() require("treesitter-context").go_to_context() end,
          --       desc = "Go to parent context",
          --       mode = {"n","x","o"},
          --     }},
          --       opts = {
          --       enable = true,   -- Enable this plugin (Can be enabled/disabled later via commands)
          --       throttle = true, -- Throttles plugin updates (may improve performance)
          --       max_lines = 0,   -- How many lines the window should span. Values <= 0 mean no limit.
          --       patterns = {
          --         -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
          --         -- For all filetypes
          --         -- Note that setting an entry here replaces all other patterns for this entry.
          --         -- By setting the 'default' entry below, you can control which nodes you want to
          --         -- appear in the context window.
          --         default = {
          --           'class',
          --           'function',
          --           'method',
          --           -- 'for', -- These won't appear in the context
          --           -- 'while',
          --           -- 'if',
          --           -- 'switch',
          --           -- 'case',
          --         },
          --         -- Example for a specific filetype.
          --         -- If a pattern is missing, *open a PR* so everyone can benefit.
          --         --   rust = {
          --           --       'impl_item',
          --           --   },
          --         },
          --       }
          --   },
