-- https://www.reddit.com/r/neovim/comments/1i3tpko/introducing_notmuchnvim_readwrite_mail_offline_in/
-- https://github.com/felipec/notmuch-vim
-- https://github.com/soywod/himalaya.vim/blob/master/README.md
-- maybe intergrate with snacks.dashboard?
return
{
    -- TODO: support visual mode commands?
    "yousefakbar/notmuch.nvim",
    cond=false,
    cmd = {'Notmuch','NmSearch'},
    opts = {
        -- notmuch_db_path = os.getenv('HOME') .. '/mail/outlook',
        -- notmuch_db_path = os.getenv('BACKUP_DIR') .. '/mail/outlook',
        -- maildir_sync_cmd = "mbsync personal",
        keymaps = {
            sendmail = "<C-g><C-g>",
        },
    },
    keys = {
        -- Lists available tags in your Notmuch database in a buffer.
        -- for plugins with jut a mapping, use symbols
        { "<f12>m", "<CMD>Notmuch<CR>", desc = "Launch notmuch landing page"},
        -- { "<leader>n", ":NmSearch<space>", desc = "Notmuch query"},
        { "<space><space>", ":NmSearch<space>", desc = "Notmuch query", ft = {"notmuch-hello","notmuch-threads","mail"}},

        -- show these mappings in navbar
        {"l","<CR>", ft = "notmuch-hello", remap = true},
        {"l","<CR>", ft = "notmuch-threads", remap = true},
        -- {"h","q", ft = "notmuch-threads", remap = true},
        {"h","<CMD>bwipeout<CR>", ft = "notmuch-threads"},
        {"h","<CMD>bwipeout<CR>", ft = "mail"},
        -- {"h","q", ft = "mail", remap = true}
    },
    config = function (_,opts)
        require'notmuch'.setup(opts)
        vim.cmd[[
        augroup UnmapMacro
        au!
        au Filetype notmuch-threads unmap<buffer> q
        augroup END
        ]]
    end
}
