-- how to load only personal snippets for a filetype? or just a specific dir?
-- https://github.com/smjonas/snippet-converter.nvim -> is it possible to convert to luasnip?
-- parametrized snippets? like v:count snippet (<a-3>date) put the date 3 days before? also for things like tables (3x4, etc...)
return {
  {
		'mireq/luasnip-snippets',
    lazy = true,
		dependencies = {'L3MON4D3/LuaSnip'},
			-- require('luasnip_snippets.common.snip_utils').setup()
      main = 'luasnip_snippets.common.snip_utils',
      opts = {}

	},
  {
    -- := require'luasnip'.get_snippets()
    "L3MON4D3/LuaSnip",
    lazy = true,
    -- event = { 'InsertEnter' },
    version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- mireq/luasnip-snippets
    -- dependencies = { "rafamadriz/friendly-snippets", --[['mireq/luasnip-snippets']]},
    dependencies = { "rafamadriz/friendly-snippets",
  },
    build = 'make install_jsregexp',
    init = function()
      -- vim.keymap.set( 'n', '<leader><tab>l',function() return '<CMD>e ' .. vim.fn.stdpath('config') .. '/snippets/LuaSnip/' .. vim.bo.filetype .. '.lua<CR>'end, { desc = "(LuaSnip) Edit &ft", expr = true })
      -- vim.keymap.set( 'n', '<leader><tab>L', '<CMD>e ' .. vim.fn.stdpath('config') .. '/snippets/LuaSnip/all.lua<CR>', { desc = "(LuaSnip) Edit All" })
    end,
    opts = function()
      return {
        -- If true, snippets that were exited can still be jumped back into.
        history = true,
        -- Event on which to check for exiting a snippet's region
        region_check_events = 'InsertEnter',
        delete_check_events = 'InsertLeave',

        -- To enable auto expansion
        -- how to make all snippets autosnippets?
        enable_autosnippets = true,
        -- Uncomment to enable visual snippets triggered using <c-x>
        store_selection_keys = '<leader><Tab>',
        -- https://www.reddit.com/r/neovim/comments/17o87nu/comment/k7wo306/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
        ext_opts = {
          [require('luasnip.util.types').choiceNode] = {
            active = {
              virt_text = { { ' Choice', 'character' } }, -- yellow
            },
          },
          [require('luasnip.util.types').insertNode] = {
            active = {
              virt_text = { { ' Insert', 'MoreMsg' } }, -- purple
            },
          },
        },
        update_events = 'TextChanged,TextChangedI',
      -- ╭─────────────────────────────────────────────────────────╮
      -- │ luasnip snippets                                        │
      -- ╰─────────────────────────────────────────────────────────╯
      -- Required to automatically include base snippets, like "c" snippets for "cpp"
      load_ft_func = require('luasnip_snippets.common.snip_utils').load_ft_func,
      -- ft_func = function() return vim.split(vim.bo.filetype, '.', { plain = true }) end,
      ft_func = require('luasnip_snippets.common.snip_utils').ft_func,
      }
    end,

    config = function(_, opts)
      require('luasnip').setup(opts)

      -- would be cool if in telescope/cmp it showed the source, but alas
      -- merge identical entries like uuid (which to prefer? Definitely my_snippets but what about the other two?)

      vim.api.nvim_create_user_command( 'LuaSnipEdit', function() require('luasnip.loaders.').edit_snippet_files() end, {})
      -- require("luasnip.loaders").edit_snippet_files( { ft_filter = function(ft) return ft ~= "all" end })
      -- added spaces to align in which-key
      -- vim.keymap.set('n', '<leader><tab>g', '<CMD>LuaSnipEdit<CR>', { desc = "  (All)   Edit" })

      -- vim.keymap.set({"i","s"}, "<leader><Tab>", "<Plug>luasnip-next-choice", {})
      -- vim.keymap.set({"i","s"}, "<s-Tab>", "<Plug>luasnip-prev-choice", {})
      local ls = require("luasnip")
      -- TODO: rendi mapping <expr>
      -- vim.keymap.set({"i", "s"}, "jk", function() ls.jump( 1) end, {silent = true})
      vim.keymap.set({"i", "s"}, "<tab>", function() ls.jump( 1) end, {silent = true})
      -- vim.keymap.set({"i", "s"}, "<c-i>", function() ls.jump( 1) end, {silent = true})
      -- magari usa tab?
      -- make this dinamycally confiurable, like if you have :: like in orgmode enter pattern aNd use it...
      -- vim.keymap.set({"i", "s"}, "kj", function() ls.jump(-1) end, {silent = true})
      -- vim.keymap.set({"i", "s"}, "<s-tab>", function() ls.jump(-1) end, {silent = true})
      vim.keymap.set({"i", "s"}, "<c-s-i>", function() ls.jump(-1) end, {silent = true})
      -- jj to mean <c-h>???

          -- ls.change_choice(1)
      -- vim.keymap.set({"i", "s"}, "<C-s>", function() return ls.choice_active() and '<cmd>lua require("luasnip.extras.select_choice")()<cr>' or "<C-s>" end, {expr = true})
      vim.keymap.set({"i", "s"}, "<C-i>", function() return ls.choice_active() and "<Plug>luasnip-next-choice" or "<C-i>" end, {expr = true})
      vim.keymap.set({"s"}, "<C-j>", function() return ls.choice_active() and "<Plug>luasnip-next-choice" or "<C-j>" end, {expr = true})
      -- alla fine choice next/prev si puo fare solo in select mode? no!
      -- vim.keymap.set({"i"}, "<a-j>", function() return ls.choice_active() and "<Plug>luasnip-next-choice" or "<a-j>" end, {expr = true})
      -- TODO: use c-j for both blink and luasnip's choice...
      -- vim.keymap.set({"i", "s"}, "<C-j>", function() return ls.choice_active() and "<Plug>luasnip-next-choice" or "<C-i>" end, {expr = true})
      -- vim.keymap.set({"i", "s"}, "<C-s-i>", function() return ls.choice_active() and "<Plug>luasnip-prev-choice" or "<C-s-i>" end, {expr = true})
      vim.keymap.set({"s"}, "<C-k>", function() return ls.choice_active() and "<Plug>luasnip-prev-choice" or "<C-k>" end, {expr = true})
      -- vim.keymap.set({"i", "s"}, "<C-s>", function()
      --   if ls.choice_active() then ls.select_choice(1) end
      -- end, {silent = true})

      -- ╭─────────────────────────────────────────────────────────╮
      -- │ Personal snippets                                       │
      -- ╰─────────────────────────────────────────────────────────╯
      require('luasnip.loaders.from_vscode').lazy_load({ paths = { './snippets/vscode' }, })
      require("luasnip.loaders.from_lua").lazy_load({paths = {"./snippets/LuaSnip/"}})
      require("luasnip.loaders.from_snipmate").lazy_load({paths = {"./snippets/snipmate/"}})

      -- realod snippets
      -- vim.keymap.set('n',"<>","<CMD>source ~/.config/nvim/after/plugin/luasnip.lua<CR>")

      require('luasnip').filetype_extend('python', { 'pytorch' })
      require('luasnip').filetype_extend('vimwiki', { 'markdown' })
      require('luasnip').filetype_extend('xslt', { 'xml' })

      -- ╭─────────────────────────────────────────────────────────╮
      -- │ friendly-snippets                                       │
      -- ╰─────────────────────────────────────────────────────────╯
      -- require('luasnip.loaders.from_vscode').lazy_load {
          -- exclude = { "javascript" },
        --   exclude = { "all" },
        -- }

      -- frameworks
      ---@see https://github.com/rafamadriz/friendly-snippets/tree/main/snippets/frameworks
      -- require'luasnip'.filetype_extend("ruby", {"rails"})

      -- enable standardized comments snippets
      require("luasnip").filetype_extend("typescript", { "tsdoc" })
      require("luasnip").filetype_extend("javascript", { "jsdoc" })
      require("luasnip").filetype_extend("lua", { "luadoc" })
      require("luasnip").filetype_extend("python", { "pydoc" })
      require("luasnip").filetype_extend("rust", { "rustdoc" })
      require("luasnip").filetype_extend("cs", { "csharpdoc" })
      require("luasnip").filetype_extend("java", { "javadoc" })
      require("luasnip").filetype_extend("c", { "cdoc" })
      require("luasnip").filetype_extend("cpp", { "cppdoc" })
      require("luasnip").filetype_extend("php", { "phpdoc" })
      require("luasnip").filetype_extend("kotlin", { "kdoc" })
      require("luasnip").filetype_extend("ruby", { "rdoc" })
      require("luasnip").filetype_extend("sh", { "shelldoc" })
    end
  },
  -- {
  --   'benfowler/telescope-luasnip.nvim',
  --   -- config = function() require('telescope').load_extension('luasnip') end,
  --   keys = {
  --     -- show all snippets, not only mine?
  --     -- how to show only luasnip-defined snippets?
  --     {
  --       -- go to file when pressing keybinding?
  --       '<leader><tab><tab>',
  --       function() require('telescope').extensions.luasnip.luasnip({}) end,
  --       desc = '  (All)   List',
  --     },
  --   },
  -- },
  {
    -- do user snippets overshadow plugin ones? they should
    -- how to set nlua? like lua but only in vim files...
    -- does it support nlua?
    -- support saving with ZZ et al? (don't save with ZQ...)
    'chrisgrieser/nvim-scissors',
    init = function()
      vim.keymap.set('n', '<leader><tab>p', '<CMD>e ' .. vim.fn.stdpath('config') .. '/snippets/vscode/package.json<CR>', { desc = "(VS Code) Project" })
      vim.keymap.set( 'n', '<leader><tab><tab>',function() return '<CMD>e ' .. vim.fn.stdpath('config') .. '/snippets/vscode/' .. vim.bo.filetype .. '.json<CR>'end, { desc = "(VS Code) Edit &ft", expr = true })
      -- add icon/text to blink for personal snippets...
      vim.keymap.set( 'n', '<leader><tab><s-tab>', '<CMD>e ' .. vim.fn.stdpath('config') .. '/snippets/vscode/all.json<CR>', { desc = "(VS Code) Edit All" })
    end,
    -- edits only my snips
    keys = {
      -- these should work even if filetype not set (maybe edit all.lua/json?)
      -- add snippets that correspond to comment-todo keywords... (with regex?)
      { '<leader><tab>e', function() require('scissors').editSnippet() end, desc = "(VS Code) Edit" },
      -- When used in visual mode prefills the selection as body.
      -- use <leader><tab> as mapping
      -- PERF: use all.json if not filetype (send PR)
      -- Snippets files are written in JSON, support C-style comments,??? doesn't seem that way
      -- what happens when you define same prefix as friendly-snippets? can you disable a specific friendly-snippets' snippet?
      { mode = { 'n', 'x' }, '<leader><tab>n', function() require('scissors').addNewSnippet() end, desc = "(VS Code) Add" },
      -- { mode = { 'n', 'x' }, '<leader><tab>N', function() require('scissors').addNewSnippet() end, desc = "(VS Code) Add" }, -- all.json?
    },

    opts = {
      snippetDir = vim.fn.stdpath('config') .. '/snippets/vscode',
      snippetSelection = {
      picker = 'snacks',
      telescope = {
        -- By default, the query only searches snippet prefixes. Set this to
        -- `true` to also search the body of the snippets.
        alsoSearchSnippetBody = true,
      },
    },
      jsonFormatter = 'jq', -- "yq"|"jq"|"none"
      editSnippetPopup = {
        keymaps = {
          insertNextPlaceholder = "<f24>"
        },
      }
  },
}
}
