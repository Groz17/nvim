-- make blink work w gitignore using / as ./
-- preserve case when completing?
-- trigger also on backspace?
-- don't suggest deprecated (also for cmdline...)
-- what's the default score_offset?
-- distinguish between general snippets (like date) and filetype snippets? in icon? also yours?
-- https://github.com/ribru17/blink-cmp-spell
-- press one character to show all suggestions?
-- how to suggest based on context? like in plugin config inside opts={} when writing keys I don't want to write for loops
-- immediate suggestions? when you don't even type one char?
-- how to show suggestions in select mode?
-- show preview of suggestion?
-- I need async path source like in nvim-cmp
-- add treesitter highlight?
-- BlinkInfo command?
-- 2 problems: first it shows documentation only when i accept a suggestion, the second is shows two documentation windows
-- TODO: prioritize most chosen selection (maybe in a session or persistenly???)??? like più should appear before piu when writing Italian (or when writing comments show up spell-fixed words)
-- don't show for snacks input?
-- in comments sources: dictionary/git+lsp harper
-- disable c-n/p so i can use emacs
return {
  -- please support luasnip... (for https://github.com/chrisgrieser/nvim-scissors)
  -- TODO: icons?
  -- maybe color the line depending on source?
  -- mapping to show possible completion with fzf-lua? or just API to show completions with their source? for git commit snippets
  -- deduplicate entries if lsp and snippets, choose lsp
  'saghen/blink.cmp',
  -- wait for completion update...
  event = { 'InsertEnter', 'CmdlineEnter' },
  dependencies = {
    'readline.nvim',
    'L3MON4D3/LuaSnip',
    'Kaiser-Yang/blink-cmp-avante', -- make it lazy?
    'mikavilpas/blink-ripgrep.nvim',
    'xzbdmw/colorful-menu.nvim',
    'Kaiser-Yang/blink-cmp-dictionary',
    -- attiva copilot server solo quando usi mapping?
    "fang2hou/blink-copilot",
    { 'Kaiser-Yang/blink-cmp-git', dependencies = { 'nvim-lua/plenary.nvim' } }
  },

  -- use a release tag to download pre-built binaries
  version = '*',

  opts = function()
    -- local ls = require("luasnip")
    return {
      sources = {
        -- how to show lowercase/uppercase versions of strings in buffer completions? (case-insensitive)
        -- TODO: luasnip?
        -- default = { 'lsp', 'path', 'snippets', 'buffer', 'ecolog', 'emoji', --[['copilot']] },
        default = { 'lsp', 'path', 'snippets', 'buffer', --[['ecolog',]] 'git', 'omni', 'avante'--[['env']] --[['copilot']] },
        -- default = { 'lsp', 'path', 'snippets', 'buffer', 'ecolog', 'emoji', 'copilot' },
        -- markup adn programming (languages) keys?
        per_filetype = {
          AvanteInput = { 'avante', 'buffer' },
          sql = { 'dadbod', 'lsp', 'snippets', 'buffer' },
          lua = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
          -- org = { 'orgmode', 'buffer' },
          -- add in prog language's comments
          -- how to prioritize snippets? like options per_filetype?
          markdown = { 'snippets','dictionary' },
          vimwiki = { 'dictionary' }
          -- org = { 'orgmode' },
        },

        -- sposta in vim_dadbod_completion spec (when blink has buffer completions...)
        -- easy way to add icon and text???

        ---@see https://www.reddit.com/r/neovim/comments/1i12yjp/comment/m72t0t0/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
        -- specify filetype per provider?
        providers = {
          -- make lazydev completions top priority (see `:h blink.cmp`)
          lazydev = { name = 'LazyDev', module = 'lazydev.integrations.blink', score_offset = 100, },
        -- cmdline = {
        --   min_keyword_length = function(ctx)
        --     -- when typing a command, only show when the keyword is 3 characters or longer
        --     if ctx.mode == 'cmdline' and string.find(ctx.line, ' ') == nil then return 3 end
        --     return 0
        --   end
        -- },
          avante = {
            module = 'blink-cmp-avante',
            name = 'Avante',
            opts = {avante={
              command = {

                get_kind_name = function(_)
                  return 'AvanteCmd'
                end,
              },

              mention = {

                get_kind_name = function(_)
                  return 'AvanteMention'
                end,
              },
            },

            kind_icons = {

          AvanteCmd = '',
          AvanteMention = '',
            }}
          },
          -- would be nice if it expanded env vars
          -- how to disable for large files?
          path = {
            score_offset = 2,
          -- opts = {
          --   -- This also makes it easy to `:cwd` to the desired base directory for path completion.
          --   get_cwd = function(_)
          --     return vim.fn.getcwd()
          --   end,
          -- },
          },
          buffer = {
            min_keyword_length = 2,
            score_offset = 5,
          },
          git = {
            module = 'blink-cmp-git',
            name = 'Git',
            opts = { },
          },
          -- shouldn't use your current buffer as source right?
          ripgrep = { module = 'blink-ripgrep', name = 'Ripgrep', opts = { search_casing = '--smart-case' } },
          -- ecolog = { name = 'ecolog', module = 'ecolog.integrations.cmp.blink_cmp' },
          dadbod = { name = 'Dadbod', module = 'vim_dadbod_completion.blink' },
          -- orgmode = { name = 'Orgmode', module = 'orgmode.org.autocompletion.blink' },
          -- buffer = { fallback_for = { 'lsp', 'dadbod', 'orgmode' }, },
          -- TODO: show only in comments/markdown/latex/etc... (basically just markup languages or plain text?)
          lsp = {
            score_offset = 2,
            override = {
              get_trigger_characters =  function(self)
                local trigger_characters = self:get_trigger_characters()
                vim.list_extend(trigger_characters, { '\n', '\t', ' ' })
                return trigger_characters
              end
            }
          },
          dictionary = {
                module = 'blink-cmp-dictionary',
                name = 'Dict',
                -- Make sure this is at least 2.
                -- 3 is recommended
                min_keyword_length = 3,
                opts = {
                  -- would be cool to set it according to spellang, and show spellang in the window?
                    dictionary_files = {'/usr/share/dict/american-english','/usr/share/dict/italian'},
                }
            },
            -- maybe create mapping to push up or down this source?
            -- how to show completions during macro recording
            copilot = {
          name = "copilot",
          module = "blink-copilot",
          score_offset = 100,
          async = true,
          opts = {
            max_completions = 3,
            max_attempts = 4,
          }
        },
            snippets = {
              score_offset = 4,
            },
      }
      },
      snippets = {
        preset = 'luasnip',
        expand = function(snippet) require('luasnip').lsp_expand(snippet) end,
        active = function(filter)
          if filter and filter.direction then
            return require('luasnip').jumpable(filter.direction)
          end
          return require('luasnip').in_snippet()
        end,
        jump = function(direction) require('luasnip').jump(direction) end,
      },
      -- Disable for some filetypes
      -- enabled = function()
      --   return not vim.tbl_contains({ --[["lua",]]
      --     'markdown',
      --   }, vim.bo.filetype) and vim.bo.buftype ~= 'prompt' and vim.b.completion ~= false
      -- end,
      completion = {
      trigger = {
        -- doesn't work
        show_on_blocked_trigger_characters = {}
      },
        list = {
          selection = {
            preselect = function(ctx) return ctx.mode ~= 'cmdline' end,
            -- auto_insert = function(ctx) return ctx.mode ~= 'cmdline' end
            auto_insert = false,
          }
        },
        keyword = { range = 'full' },
        accept = { auto_brackets = { enabled = true } },
        ghost_text = {enabled=false},
        -- https://github.com/Saghen/blink.cmp/discussions/620#discussioncomment-11611096
        menu = {
          -- auto_show = false,
          -- looks bad
          border = 'rounded',
          scrollbar=false,
          draw = {
            -- columns = 
            --   { 'label', 'label_description', gap = 1 }, { 'kind_icon', 'kind' },
            -- },
            -- We don't need label_description now because label and label_description are already
            -- conbined together in label by colorful-menu.nvim.
            columns = { { 'kind_icon' }, { 'label', gap = 1 } },
            -- columns = { { "kind_icon", "kind" }, { "label", gap = 1 } },
            components = {
              label = {
                width = { fill = true, max = 60 },
                text = require('colorful-menu').blink_components_text,
                highlight = require('colorful-menu').blink_components_highlight,
              },
            },
          },
        },
        documentation = {
          -- Controls whether the documentation window will automatically show when selecting a completion item
          auto_show = true,
          window = { border = 'rounded' },
        },
      },
      -- experimental signature help support
      -- TODO: does it support overloads???
      signature = { enabled = true, window = { border = 'single' } },
      appearance = {
        -- sets the fallback highlight groups to nvim-cmp's highlight groups
        -- useful for when your theme doesn't support blink.cmp
        -- will be removed in a future release, assuming themes add support
        use_nvim_cmp_as_default = true,
        -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'normal',
        kind_icons = {
          Copilot = "",
          Text = '󰉿',
          Method = '󰊕',
          Function = '󰊕',
          Constructor = '󰒓',

          Field = '󰜢',
          Variable = '󰆦',
          Property = '󰖷',

          Class = '󱡠',
          Interface = '󱡠',
          Struct = '󱡠',
          Module = '󰅩',

          Unit = '󰪚',
          Value = '󰦨',
          Enum = '󰦨',
          EnumMember = '󰦨',

          Keyword = '󰻾',
          Constant = '󰏿',

          Snippet = '󱄽',
          Color = '󰏘',
          File = '󰈔',
          Reference = '󰬲',
          Folder = '󰉋',
          Event = '󱐋',
          Operator = '󰪚',
          TypeParameter = '󰬛',

        },
      },

      -- for keymap, all values may be string | string[]
      -- use an empty table to disable a keymap
      keymap = {
        preset='none',
        -- how to specify modes?
        -- remember unix philosophy: one thing well
        -- ['<C-space>'] = { 'show' },
        -- copilot?
        -- ['<C-space>'] = { function(cmp) cmp.show({ providers = { 'snippets' } }) end },
        -- TODO: usa stessi mapping nativi di vim tipo ctrl-x ctrl-f per filenames
        ['<C-space>'] = { function(cmp) cmp.show({ providers = { 'copilot' } }) end },
        -- TODO: usa shortcuts di emacs per providers...
        -- like dynamic abbrev in emacs? automatically expand but show completion that you can replace current word?
        -- icon for buffer?
        ['<m-/>'] = { function(cmp) cmp.show({ providers = { 'buffer' } }) end },
        -- what about jl and al?
        ['<C-e>'] = { 'fallback_to_mappings' },
        ---           ['<C-y>'] = cmp.mapping(function(fallback)
        -- accept = '<C-i>', -- or maybe <c-l>? (create table?)
        -- ['<C-l>'] = { 'accept' }, -- or maybe <c-l>? (create table?)
        ['<C-l>'] = { 'select_and_accept','fallback' }, -- or maybe <c-l>? (create table?)
        -- ['jl'] = { 'select_and_accept' },
        -- what about <space><space>?
        -- ['<C-i>'] = { 'snippet_forward' }, -- or maybe <c-l>? (create table?)
        -- ['jk'] = { 'snippet_forward' }, -- or maybe <c-l>? (create table?)
        -- ['<a-k>'] = { 'snippet_forward', 'fallback' }, -- or maybe <c-l>? (create table?)
        -- ['<cr>'] = { 'snippet_forward', 'fallback' }, -- or maybe <c-l>? (create table?)
        -- ['<c-j>'] = { 'snippet_backward', 'fallback' }, -- or maybe <c-l>? (create table?)
        -- ['jk'] = {
        --   function(cmp)
        --     if cmp.snippet_active() then return cmp.snippet_forward()
        --   end
        -- end,
        --   'fallback'
        -- },
        -- ['<Tab>'] = {'snippet_forward'},
        -- ['<c-a>'] = {'snippet_backward'},
        -- ctrl in escape key location is pretty cool
        -- ['<c-s-i>'] = { 'snippet_backward' },
        -- ['kj'] = { 'snippet_backward' },
        -- ['<CR>'] = {'select_and_accept'},
        -- kanata? to insert newline w/ c-j
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<C-p>'] = { 'fallback' },
        -- TODO:  come andare all'ultimo item (della window)? autoshift
        -- ['<C-s-k>'] = { 'select_prev', 'fallback' },
        ['<C-j>'] = { 'select_next', 'fallback' },
        ['<C-n>'] = { 'fallback' },
      -- ["<CR>"] = { "select_accept_and_enter", "fallback" },
        -- ['<C-s-j>'] = { 'select_next', 'fallback' },

        -- [] = {'show_documentation'},
        -- [] = {'hide_documentation'},
        -- ['<a-k>'] = { 'scroll_documentation_up', 'fallback' },
        -- ['<a-j>'] = { 'scroll_documentation_down', 'fallback' },
        -- ['<a-s-k>'] = {function(cmp) cmp.scroll_documentation_up(4) end},
        -- check if same mapping in emacs
        ['<c-v>'] = { 'scroll_documentation_down', 'fallback' },
        ['<a-v>'] = { 'scroll_documentation_up', 'fallback' },
        ['<c-f>'] = { 'fallback_to_mappings' },
        -- if cmp.is_menu_visible() then return cmp.select_next()

      },

      -- don't want to replace already inserted text though... maybe use another mapping for that
        cmdline = {
          keymap=
          {preset = 'none',
          -- ['<C-k>'] = { 'select_prev', 'fallback_to_mappings' },
          ['<C-k>'] = { 'select_prev' },
          ['<C-j>'] = { 'select_next', 'fallback' },
          -- TODO: add keymap to execute as well (maybe <a-l>)
          -- ['<c-s-l>'] = { 'select_accept_and_enter' },
          -- ['<c-s-m>'] = { 'select_accept_and_enter' },
          -- ['<a-l>'] = { 'select_accept_and_enter' },
          -- basically like ble.sh
          -- ['<c-cr>'] = { 'select_accept_and_enter' },
          -- ['<space><space>'] = { 'select_accept_and_enter' },
          -- multiple keys don't work...
          ['<s-space>'] = { 'select_accept_and_enter' },
          -- ['<cr>'] = { 'select_accept_and_enter' },
          ['<c-c><c-c>'] = { 'select_accept_and_enter' },
          -- ['<C-l>'] = { 'select_and_accept' },
          ['<C-l>'] = { 'accept','fallback' },
          ['<C-e>'] = { 'fallback_to_mappings' },
          -- TODO: mapping for select_and_accept_and run afterwards? maybe use function
          -- ['<space><space>'] = function() 'select_and_accept' <CR> end
        },
        completion = {
        menu = { auto_show=true },
        -- ghost_text = { enabled=true }
        -- so u can use c-l To enter and accept
      list={selection={preselect=false}},
      },
        },
      -- allows extending the enabled_providers array elsewhere in your config
      -- without having to redefining it
      -- opts_extend = { 'sources.completion.enabled_providers' },
    }
  end,
}

-- omni Completion
-- inoremap <C-Space> <C-x><C-o>
-- disable<c-y>?
