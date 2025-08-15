-- would be nice if it loaded just the docs of all plugins

-- does entering gx (or other predefined mapping) on plugin take you on the github page?

-- if vim.env.PROF then
--   -- example for lazy.nvim
--   -- change this to the correct path for your plugin manager
--   local snacks = vim.fn.stdpath("data") .. "/lazy/snacks.nvim"
--   vim.opt.rtp:append(snacks)
--   require("snacks.profiler").startup({
--     startup = {
--       event = "VimEnter", -- stop profiler on this event. Defaults to `VimEnter`
--       -- event = "UIEnter",
--       -- event = "VeryLazy",
--     },
--   })
-- end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- doesn't work
-- vim.opt.rtp:remove(vim.env.VIMRUNTIME.."/colors/")

-- require("lazy").setup("plugins", {
require("lazy").setup({
    -- rocks = {
    --   hererocks = true,  -- recommended if you do not have global installation of Lua 5.1.
    -- },
    spec = {
        -- use this as reference to subdivide your plugins (https://github.com/rockerBOO/awesome-neovim#editing-supports)
        -- mason tools // delete...
        { import = "plugins.tools" },
        -- plugins that change how neovim native features behave
        { import = "plugins.core" },
        -- useful for programming
    -- maybe change name to utilities?
        { import = "plugins.extra" },
        -- extra feature (not in neovim)
        { import = "plugins.coding" },
        -- filetype-specific
        { import = "plugins.filetypes" },
        -- { import = "plugins.filetypes" },
        -- user interface
        { import = "plugins.ui" },
        -- folke's snacks
        { import = "plugins.snacks" },

        -- maybe change to wiki/neorg? -- ha senso questa dir?
        -- { import = "plugins.vimwiki" },

        -- gitlab/bitbucket/gitea/etc...
        { import = "plugins.platforms" },

        { import = "plugins.colorschemes" },

        { import = "plugins.comments" },

        { import = "plugins.AI" },

        { import = "plugins.debug" },
        { import = "plugins.motions" },

        { import = "plugins.windows" },

        { import = "plugins.git" },

    },
    performance = {
        rtp = {
            -- disable unused builtin plugins from neovim
            disabled_plugins = {
                -- TODO: is it related to TOhtml?
                -- "2html_plugin",
                "getscript",
                "getscriptPlugin",
                -- "gzip",
                -- how to lazy load this one? with cmd = {} ...
                "logipat",
                -- I wanna open urls from cli ; funge anche con gf
                "netrw",
                "netrwPlugin",
                "netrwSettings",
                "netrwFileHandlers",
                "matchit",
                -- "tar",
                -- "tarPlugin",
                "rrhelper",
                "spellfile_plugin",
                "vimball",
                "vimballPlugin",
                -- "zip",
                -- "zipPlugin",
                -- "tutor",
                "rplugin",
                "synmenu",
                "optwin",
                "compiler",
                "bugreport",
                "ftplugin",
            },
        },
    },
    ui = {
        custom_keys = {
            -- open a terminal for the plugin dir
            ["<localleader>t"] = function(plugin)
                require("lazy.util").float_term(nil, {
                    cwd = plugin.dir,
                })
            end,
        },
    },
    -- how to make this work with lazy-loading the plugin?
    diff = { cmd = "diffview.nvim" },

      checker = {
        -- automatically check for plugin updates
        enabled = true,
        notify = false, -- get a notification when new updates are found
        -- frequency = 3600, -- check for updates every hour
    },

    change_detection = {
        -- automatically check for config file changes and reload the ui
        enabled = true,
        notify = false, -- get a notification when changes are found
    },
  dev = {
    path = vim.fn.stdpath('data') .. '/myplugins/'
  },

      install = {
        -- install missing plugins on startup. This doesn't increase startup time.
        missing = true,
        -- try to load one of these colorschemes when starting an installation during startup
        colorscheme = { "habamax" },
      },
})

-- Cfilter supports using // if you've search smth before
vim.cmd('packadd cfilter')
-- vim.cmd('source sortgrop.vim')

vim.api.nvim_create_autocmd("User", {
  group = vim.api.nvim_create_augroup("LoadDiffview",{}),
  pattern = "LazyUpdate",
  callback = function()
      if not package.loaded["diffview.nvim"] then
          require("lazy").load({
              plugins = { "diffview.nvim" }
          })
      end
  end
})

-- from nvchad
-- local default_providers = {
--   "node",
--   "perl",
--   "python3",
--   "ruby",
-- }
--
-- for _, provider in ipairs(default_providers) do
--   vim.g["loaded_" .. provider .. "_provider"] = 0
-- end
