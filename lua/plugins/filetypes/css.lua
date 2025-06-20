-- https://www.reddit.com/r/neovim/comments/1hkq9kt/px_to_rem_in_css_using_blinkcmp/
-- https://github.com/luckasRanarison/tailwind-tools.nvim?tab=readme-ov-file
    -- before = require("tailwind-tools.cmp").lspkind_format
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
