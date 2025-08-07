-- https://github.com/nvzone/showkeys
-- https://www.reddit.com/r/neovim/comments/18sybv3/hawtkeysnvim_suggest_new_easy_to_hit_keymaps_and/
-- add which-key conf here
-- how to change to which-key window? maybe just to copy
return {
  { "meznaric/key-analyzer.nvim",
  cmd="KeyAnalyzer",
  opts = {}
},
  {
    -- Dupl shouldn't return buffer-local mappings
    -- find mappings that don't have a description?
    'tris203/hawtkeys.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      -- ["lazy"] = {
      --   method = "lazy",
      -- },
    },
    --- @type table
    cmd = {
      'Hawtkeys',
      'HawtkeysAll',
      'HawtkeysDupes',
    },
  },

  -- this means you can't use <prefix><c-d>/<c-u> because it scrolls the window?

  -- Use consistent description for mappings (maybe Title Case?)
  -- add key to also show function/command near mapping

  -- would be nice if this supported markdown

  -- does which-key respects buffer-local mappings? doesn't show for ex gitsigns in file not in a git repo

  -- rv  (search for cool icons to use for prefixes)

  -- would be cool if this worked also for modifiers like ctrl, alt, etc... when held.
  -- would be nice to show mappings that each plugin defines grouped (in boxes, maybe)

  -- cosa succede se ci sono mappings multipli con lo stesso lhs? whichkey checkhealth?
  -- fallback to rhs if not desc? [fugitive]
  -- would be cool if it separated neovim's builtin mappings with the user's
  -- una idea sarebbe quella di evitare di usare desc e mettere ogni descrizione in questo file (utile per avere tutto in un unico file ma un po' faticoso)
  -- You can run `:checkhealth which-key` to see if there’s any conflicting keymaps that will prevent triggering **WhichKey** WhichKey comes with the following defaults:
  -- would be cool if it showed mappings (non-native of course) that don't have a description yet
  -- would be cool to add a label to a mapping like ATTENTION for deleting files... also a priority setting that dims or highlights more important mappings
  -- would be cool if it checked if a mapping is misplaced like <leader>li for :Lfind while <leader>l is for lsp mappings (hard to do, an idea could be if these mapping from the same file/plugin spec)
  -- can which-key work with commands? desc in command field?
  -- <c-b> which-key {https://github.com/LinArcX/telescope-command-palette.nvim}

  -- :WhichKey " show all mappings
  -- :WhichKey <leader> " show all <leader> mappings
  -- :WhichKey <leader> v " show all <leader> mappings for VISUAL mode
  -- :WhichKey '' v " show ALL mappings for VISUAL mode

  -- what to do with ctrl mappings like <c-p> for files (and <a-p>?) group them somehow
  -- usa [<PLUGIN_NAME>] per riferirti a mapping di quel plugin (o anche argomento, tipo LSP)
  {
    -- maybe use uppercase for groups and lowercase for desc?
    -- how to show prefix on top by itself and not on the bottom left?
    -- would be nice if you could group mappings, that could be inclosed in a box for example
    -- have mapping that fuzzy finds the which-key window?
    -- for certain filetypes (like fugitive), how to display only <buffer>-local mappings?
    -- integra (in qualche modo) vim.v.count to show keybindings for todo-comments mapping or keymaps (using hex trick)
    -- TODO: esplora proxy
    -- https://github.com/folke/which-key.nvim/issues/827 TODO: patched file...
    -- how to jump to "hint" window? like for notifications...
    -- usa emacs keybindings
    'folke/which-key.nvim',
    event = 'VeryLazy',
    -- useful for filetype plugins (localleader)
    keys = {
      {
        -- '<leader>?',
        -- TODO: usa keytrans per mostrare localleader e non ,
        -- how to exclude this mapping in the window?
        -- non consistente xke <leader><leader> non mostra i globali...
        -- emacs inspired
        -- '<localleader><localleader>',
        -- '<m-X>',
        '<f18>m',
        function()
          require('which-key').show { global = false }
        end,
        -- maybe show those for filetype only? and another mapping for buffer...
        -- desc = 'Buffer Local Keymaps (which-key)',
        desc = 'which_key_ignore',
      },
      -- notify if no mappings?
      { mode="i", '<f18>m', function() require('which-key').show { global = false, mode = "i" } end, desc = 'which_key_ignore', },
      -- v for snippets???
      { mode="x", '<f18>m', function() require('which-key').show { global = false, mode = "v" } end, desc = 'which_key_ignore', },
      { mode="t", '<f18>m', function() require('which-key').show { global = false, mode = "t" } end, desc = 'which_key_ignore', }
    },
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- preset = "helix",
      -- how to adjust size based on number of mappings?
      preset = "helix",
      -- TODO: how to align center?
      plugins = {
        presets = {
          motions = false,
        }
      },
      layout = {
        -- width = { min = 100, max = 200 }, -- min and max width of the columns
        -- spacing = 5, -- spacing between columns
        align = 'center'
      },
      -- add operators that will trigger motion and text object completion
      -- to enable all native operators, set the preset / operators plugin above
      -- g= "Eval vimscript"
      -- how to show Coerce in which-key window?
      -- cr = "Coerce"
      -- operators = { gc = 'Comments', gs = 'Execute', },

      -- hidden = { '<silent>', '<cmd>', '<Cmd>', '<CR>', '^<Plug>%b()', 'call', '^lua', '^:', '^ ', 'require', 'escope', 'erator', '"' },                                                                                                                --
      -- hidden="Neorg?"

      -- list of mode / prefixes that should never be hooked by WhichKey
      -- triggers_blacklist = { i = { 'j', 'k' }, v = { 'j', 'k' }, },
      disable = {
        ft = {
          -- "fugitive"
          -- "grug-far" -- see https://github.com/folke/which-key.nvim/issues/830
        },
      },

      -- icons = {
      --   breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
      --   separator = "  ", -- symbol used between a key and it's label
      --   group = "+", -- symbol prepended to a group
      -- },
      -- FIX: they don't work
      keys = {
        scroll_down = '<c-j>', -- binding to scroll down inside the popup
        scroll_up = '<c-k>', -- binding to scroll up inside the popup
      },

      -- ignore_missing = true,

      -- win = {
      --   border = 'single', -- none, single, double, shadow
      --   col = 10,
      --   row = 2,
      --   height = { min = 5, max = 10 },
      --   -- height = #vim.api.nvim_buf_get_keymap(0,"n"),
      --   -- height = function() return #vim.api.nvim_buf_get_keymap(0,"n")() end,
      --   padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
      --   zindex = 1000, -- positive value to position WhichKey above other floating windows.
      --
      --   wo = {
      --     winblend = 10, -- value between 0-100 0 for fully opaque and 100 for fully transparent
      --   },
      -- },
      win = {
        -- row = 1,
        -- row = math.floor(vim.api.nvim_win_get_width(0)/2),
        -- row = math.huge,
        -- col = 0.5
        -- width = math.ceil(vim.api.nvim_get_option("columns") * 0.8),
        -- height = math.ceil(vim.api.nvim_get_option("lines") * 0.8 - 4),
        -- TODO: how to make center this window?
        row = math.ceil((vim.api.nvim_get_option_value("lines",{}) - math.ceil(vim.api.nvim_get_option_value("lines",{}) * 0.8 - 4)) / 2 - 1),
        -- row = function() return #vim.api.nvim_buf_get_keymap(0,"n") end,
        col = 0.5,

      },
      show_help = false,
    },
    config = function(_, opts)
      -- Use lowercase prefix (just first letter) for plugin mappings (Git, LSP, etc...) and uppercase prefix for vim-related mappings (Quickfix, Diff, etc...)

      --  consider using symbols as well, to use after the leader prefix (like <CR> for start and . for stop) (create a legend)
      -- don't use uppercase letters, too uncomfortable
      -- local leaders = {
      --   {"`",
      --     -- maybe Miscellaneous is better? for telescope mappings like co for colorschemes, etc... also could be useful for plugins that have very few mappings for a topic like template (pity to waste an entire prefix)
      --     group = 'UNIX',
      --     q = 'quickfix list',
      --     l = 'location list',
      --   },
      -- }
      -- magari non crearli per plugin con pochi mappings...
      -- a = art?
      -- local leaders = { vim.g.mapleader,vim.g.tleader,vim.g.hleader }
      -- local leaders = { vim.g.mapleader, vim.g.tleader }
      local leaders = { vim.g.mapleader }
      -- stylua: ignore
      -- NOTE: magari mettigrouppi specifici nei singoli plugin (tipo todo, chatgpt)
      -- how to not show space key in which-key buffer?
      local groups = {
        -- {"a", group = "AI"},
        {"p", group = "Auto-preview"},
        {"d", group = "Diagnostics"},
        -- TODO: add icons? with mini?
        {"e", group = "Edit config files"},
        {"f",group = 'Picker',

        },
        -- },
        -- { 'g', group = 'git', icon = { icon = '󰊢', hl = 'WhichKeyColorOrange', color = 'orange' } },
        -- TODO: come scrivere mapping a cascata come nella versione precedente?
        { 'g', group = 'Git'},
        {"i", group = "Images"},
        {"I", group = "Swap Nodes"},
        -- evaluate? just cause j is nice to type? (also ctrl-j is how you send commands in the terminal) XPATH/jq...
        -- j = {
        --
        -- },
        -- maybe use m for Miscellaneous? like snack's news, etc...
        -- m = { name = "Mason" },
        -- nm = { name = "Metadata" },
        -- n = { name = "Neorg" },
        -- {"n", group = "Notifications"},
        {"n", group = "Org-roam"},
        -- no = { name = "ToC" },
        {"pl", group = "Load"},
        {"r", group = "Refactor"},
        {"s", group = "Sessions"},
        {"S", group = "Screenshot"},
        -- t = { name = "Toggle" },
        -- t = { name = "Treesitter" },
        {"c", group = "Coverage"},
        {"t", group = "Testing"},
        -- {"t", group = "TODO"},
        -- w = { name = "Windows" },
        {"x",
          group = ' Diagnostics [Trouble]',
          -- g = 'LSP',
        },
        -- to send to most common files for ex <leader>{w|v}n to send to neovim todo (actually using <s-space>n seems nicer) (interessante l'utlizzo di <s-space> (o anche <c-space> o anche <a-space>) come ulteriore leader)
        -- to select with telescope
        -- v = { name = "VimWiki" },
        {"w", group = "Wiki"},
        -- {"u", group = "UI"},
        -- {"q", group = "Macros"},
        {'"', group = "Registers"},

        -- possible to negate character class?
        -- [!glt] = { name = "Miscellaneous" },
        {"<tab>" ,group= "Snippets"},
        {"w" ,group= "Wiki"},

        -- {vim.g.hleader,group= "Hydra"}
      }

      local wk = require('which-key')
      wk.setup(opts)

      local mappings = {}
      for _, leader in pairs(leaders) do
        for _, group in pairs(groups) do
          table.insert(mappings, { leader .. group[1], group = group['group'] })
        end
      end
      -- TODO: usa wk.Spec???
      wk.add(mappings)
      -- maybe use just one character like \ to start all your hydras? like \d to debug \w for windows operationsm, etc...
      -- mah, mi sa che nel caso di hydra i mapping non debbano essere consistenti con leader e tleader...
      -- FIX: Can you use \ in key for lua table?
      -- [vim.g.hleader] = {
      --   group = 'Hydra',
      -- },
      -- filetype-specific leader (which just be <localleader> right?)
      -- [vim.g.fleader] = {
      --   name = "Hydra",
      -- }

      wk.add({ '<localleader>', desc = 'Local mappings' })
      -- wk.add({ [[\]], desc = 'Toggle mappings' })
      -- wk.add({[[\g]],  group = "Git"} )
      -- TODO: too long
      -- wk.add({[[\gh]],  group = "Gitsigns"} )

      -- wk.add({ 'yo', desc = 'Toggle Vim Option' })

      -- magari sposta in plugin? ma poi non piu lazy
      -- wk.add({ 'cd', desc = 'Create DocBlocks' })
      -- TODO: it's not a change (in which-key window...)
      wk.add({ 'cd', group = 'Create DocBlocks' })
      -- https://www.reddit.com/r/neovim/comments/1j4twi0/feature_idea_local_comments/
      wk.add({ 'gC', group = 'Local comments' })
      wk.add({ '<f12>p', group = 'Projects' })

      -- Operators?
      -- magari sposta in plugin config?
      -- wk.add({ 'gh', desc = 'Translate', icon = '󰗊' })
      wk.add({ 'cr', desc = 'Coerce' })
    end,
  },
}
