-- https://github.com/luckasRanarison/tailwind-tools.nvim?tab=readme-ov-file
    -- :Telescope tailwind <subcommand>
-- https://github.com/razak17/tailwind-fold.nvim
return {
    "atiladefreitas/tinyunit",
    ft = {'javascript','javascriptreact','typescript','typescriptreact', 'css'},
    keys = {{'<localleader>cu',buffer=true, ft ='css'}},
    opts = {
        keymap = {
            open = "<localleader>cu", -- Toggle converter window
            close = "q",         -- Close window
            convert = "<CR>",    -- Convert value
            escape = "<Esc>",    -- Close window
        },

    },
}
