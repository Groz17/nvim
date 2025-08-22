-- usa ctrl-j o ctrl-m per premere return (comodo con caps lock)
--
-- how to impose over other windows, like lazy's (top priority/z-index iirc)
return {
  -- how to show file preview when auto completing :e, :sp, etc...?
  -- how to automatically trigger autocmpletion when pressing the first space?
  'folke/noice.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  event = 'VeryLazy',
  opts = {
    notify = {
      enabled = false
    },
    cmdline = {
      format = {
        -- can't use regex like :(%|\d+([,"]\d+)?)! but whatever
        -- create one for set? for options
        -- create <range> key here? inside pattern? like range = true or smth
        filter = { pattern = '^:%%?%s*!', icon = '$', lang = 'bash' },
        help = { pattern = "^:%s*FloatingHelp%s+", icon = "" },
        -- Fugitive
        -- magari metti in setup() di fugitive?
        Occur = { pattern = "^:%s*Occur%s+", icon = "" },
        Git = { pattern = "^:%s*Git%s+", icon = "󰊢" },
        -- Git = { pattern = "^:%s*Git%s+[^-]", icon = "󰊢" },
        -- i want to use \ze (vim patterns...)
        -- Git = { pattern = "^:%s*Git%s+[^-]", icon = "󰊢" },
        Octo = { pattern = "^:%s*Octo%s+", icon = "" },
        Neorg = { pattern = "^:%s*Neorg%s+", icon = "" },
        -- ['Git (grep)'] = { pattern = "^:%s*Gl?grep%s*", icon = "󰊢" },
        -- TODO: fallo per gli altri comandi... (o crea plugin/share on reddit...)
        -- ['Glgrep'] = { pattern = "^:%s*Glgrep%s*(--?%S+)?%s*", icon = "󰈞" },
        ['Glgrep'] = { pattern = "^:%s*Glgrep!?%s*", icon = "󰈞" },
        ['Ggrep'] = { pattern = "^:%s*Ggrep!?%s*", icon = "󰈞" },
        -- use icon? icon function should really be built into neovim
        -- how to use for %Silicon<space>?
        -- magari metti in setup() di silicon?
        ["Filename"] = { pattern = "^:%s*'<,'>Silicon%s+", icon = "󰹑" },
      },
    },
    lsp = {
      progress = {
        enabled = false,
      },
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
      },
      signature = {enabled=false},
      hover = {enabled=false},
    },
    -- you can enable a preset for easier configuration
    presets = {
      bottom_search = false, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = true, -- enables an input dialog for inc-rename.nvim
      -- lsp_doc_border = true, -- add a border to hover docs and signature help
    },
    popupmenu = {
      -- can you scroll with cmp mapping here?
      backend = 'cmp',
    },
    -- https://github.com/folke/noice.nvim/wiki/Configuration-Recipes#clean-cmdline_popup-1
    views = {
      -- how to automatically tab complete when pressing space the first time?
      cmdline_popup = {
        position = {
          row = '40%',
          col = '50%',
        },
        size = {
          -- width = 60,
          -- variable width depending on command length?
          width = 70,
          height = 'auto',
        },
        -- border = {
        --   style = "none",
        --   padding = { 2, 3 },
        -- },
        -- filter_options = {},
        -- win_options = {
        --   winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
        -- },
        -- popupmenu = {
        --   relative = "editor",
        --   position = {
        --     row = 8,
        --     col = "50%",
        --   },
        --   size = {
        --     width = 60,
        --     height = 10,
        --   },
        --   border = {
        --     style = "rounded",
        --     padding = { 0, 1 },
        --   },
        --   win_options = {
        --     winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
        --   },
        -- },
      },
    },
    routes = {
      -- {
      --     view = "notify",
      --     filter = { event = "msg_showmode" },
      --   },
      {
        view = 'split',
        -- doesn't seem to work
        filter = { event = 'msg_show', min_height = 30 },
      },
{
  -- is it possible to do it for filetype? like sql conforminfo when using . or \ (sqlite and pgsql)
            filter = {
              event = 'msg_show',
              any = {
                -- per help plugin
                { find = 'vim.tbl_islist' },
                { find = 'client.request' },
                -- copilot lsp
                { find = 'Agent service not initialized' },
                -- noice
                { find = 'while handling a ui event' },
                { find = 'checkhealth' },
                { find = 'Not enough room' },
                { find = 'tar' },
                { find = 'gzip' },
                { find = 'ipkg' },
                { find = 'temporary directory' },
                -- { find = 'An error happened while handling a ui event' },
              },
            },
            opts = { skip = true },
          },

      -- {
      --   filter = {
      --     event = "msg_show",
      --     find = "%d+L, %d+B",
      --   },
      --   view = "mini",
      -- },
      -- {
      --   filter = {
      --     event = "msg_show",
      --     kind = "search_count",
      --   },
      --   opts = { skip = true },
      -- },
      -- { -- filter annoying buffer messages
      --   filter = {
      --     event = "msg_show",
      --     kind = "",
      --     any = {
      --       { find = "written" },
      --       { find = "line less" },
      --       { find = "fewer lines" },
      --       { find = "more line" },
      --       { find = "change; before" },
      --       { find = "change; after" },
      --     },
      --   },
      --   opts = { skip = true },
      -- },
      -- {
      --   filter = {
      --     event = "notify",
      --     find = "No node found at cursor",
      --   },
      --   opts = { skip = true },
      -- },
      -- {
      --   filter = {
      --     event = "lsp",
      --     kind = "progress",
      --     find = "code_action",
      --   },
      --   opts = { skip = true },
      -- },
    },
  },

  -- use same mapping as dunstify for noice history
  -- stylua: ignore
  keys = {
    -- { "<leader>nh", function() require("noice").cmd("history") end, desc = "History" },
    -- -- maybe you can use vim.g.count here to show last count command output's pages
    -- { "<leader>nl", function() require("noice").cmd("last") end, desc = "Last Message" },
    -- { "<leader>nd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
    -- { "<leader>nx", function() require("noice").cmd("errors") end, desc = "Errors" },
    -- { "<leader>ne", function() require("noice").cmd("enable") end, desc = "Enable" },
    -- { "<leader>ns", function() require("noice").cmd("stats") end, desc = "Stats" },
    -- { "<leader>nt", function() require("noice").cmd("telescope") end, desc = "History in telescope" },
    --
    -- { "<leader>na", function() require("noice").cmd("all") end, desc = "All" },

    -- ╭─────────────────────────────────────────────────────────╮
    -- │                  ↪️ Command Redirection                 │
    -- ╰─────────────────────────────────────────────────────────╯
    -- useful to copy stuff as well
    { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },

  },
}
