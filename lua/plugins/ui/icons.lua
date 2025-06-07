return
    -- {
    -- -- if some code requires a module from an unloaded plugin, it will be automatically loaded.
    -- -- So for api plugins like devicons, we can always set lazy=true
    -- "nvim-tree/nvim-web-devicons",
    -- lazy = true,
    -- opts = {
    --     -- your personnal icons can go here (to override)
    --     -- you can specify color or cterm_color instead of specifying both of them
    --     -- DevIcon will be appended to `name`
    --     override = {
    --         zsh = {
    --             icon = "",
    --             color = "#428850",
    --             cterm_color = "65",
    --             name = "Zsh"
    --         }
    --     },
    --     -- globally enable different highlight colors per icon (default to true)
    --     -- if set to false all icons will have the default icon's color
    --     color_icons = true,
    --     -- globally enable default icons (default to false)
    --     -- will get overriden by `get_icons` option
    --     default = true,
    --     -- globally enable "strict" selection of icons - icon will be looked up in
    --     -- different tables, first by filename, and if not found by extension; this
    --     -- prevents cases when file doesn't have any extension but still gets some icon
    --     -- because its name happened to match some extension (default to false)
    --     strict = true,
    --     -- same as `override` but specifically for overrides by filename
    --     -- takes effect when `strict` is true
    --     override_by_filename = {
    --         [".gitignore"] = {
    --             icon = "",
    --             color = "#f1502f",
    --             name = "Gitignore"
    --         }
    --     },
    --     -- same as `override` but specifically for overrides by extension
    --     -- takes effect when `strict` is true
    --     override_by_extension = {
    --         ["log"] = {
    --             icon = "",
    --             color = "#81e043",
    --             name = "Log"
    --         }
    --     },
    -- }
    {
        -- still don't understand what this plugins does (aren't they inside the font?)
        { 'echasnovski/mini.icons',
        version = false, opts = {},
        -- https://github.com/veiledshadow/dotfiles/blob/c6823a8a76ea87321c4b76e025c3b59132316331/nvim/lua/user/editor.lua#L36
        init = function()
            package.preload["nvim-web-devicons"] = function()
                require("mini.icons").mock_nvim_web_devicons()
                return package.loaded["nvim-web-devicons"]
            end
        end,
    }
}
