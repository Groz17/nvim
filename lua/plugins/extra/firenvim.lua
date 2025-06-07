-- https://gist.github.com/craigmac/81aa8f5c67f7ebf8995d497a8cc0a02f
-- https://github.com/RoryNesbitt/RNvim/blob/main/lua/configs/firenvim.lua

-- ctrl-i sembra che funga come tab nelle textarea (non in vim, magari è tridactyl?)
return
{
    'glacambre/firenvim',
    enabled = false,

    -- Lazy load firenvim
    -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
    cond = not not vim.g.started_by_firenvim,
    build = function()
        require("lazy").load({ plugins = "firenvim", wait = true })
        vim.fn["firenvim#install"](0)
    end
}

-- " " Plug 'glacambre/firenvim'
-- " Plug 'glacambre/firenvim'
-- "
-- " " Disable vim-airline when firenvim starts since vim-airline takes two lines.
-- " " if !exists('g:started_by_firenvim')
-- " "     Plug 'vim-airline/vim-airline'
-- " " endif
-- "
-- " if exists('g:started_by_firenvim') && g:started_by_firenvim
-- "     " general options
-- "     set laststatus=0 noruler noshowcmd
-- "
-- "     augroup firenvim
-- "         autocmd!
-- "         "autocmd BufEnter *.txt setlocal filetype=markdown.pandoc
-- "  au BufEnter github.com_*.txt set filetype=markdown
-- "  au BufEnter txti.es_*.txt set filetype=typescript
-- "     augroup END
-- " endif

-- " not rich text editors: doesn't work in outlook (maybe compile from source to fix)
-- "let fc['.*'] = { 'selector': 'textarea' }













-- if not vim.g.started_by_firenvim == true then return end

-- vim.o.colorcolumn = '50,80,100'
-- vim.o.cursorline = true
-- vim.o.spell = true
-- vim.o.guifont = 'Iosevka Fixed:h24'
-- vim.o.laststatus = 1

-- vim.o.background = 'light'
-- vim.cmd.colorscheme('quiet')

-- vim.g.firenvim_config = {
--   localSettings = {
--     ['.*'] = {
--       cmdline = 'neovim',
--       content = 'text',
--       priority = 0,
--       selector = "textarea:not([readonly]), div[role='textbox']",
--       takeover = 'once',
--     },
--     ['https?://.*github.com.*$'] = {
--       content = 'markdown',
--       priority = 1,
--       takeover = 'once',
--     },
--     ['https?://.*atlassian.*$'] = {
--       content = 'markdown',
--       priority = 1,
--       takeover = 'once',
--     },
--   }
-- }

-- -- throttle syncing with page to every 3 seconds
-- vim.api.nvim_create_autocmd({'TextChanged', 'TextChangedI'}, {
--   callback = function(_)
--     if vim.g.timer_started == true then
--       return
--     end
--     vim.g.timer_started = true
--     vim.fn.timer_start(3000, function()
--       vim.g.timer_started = false
--       vim.cmd[[silent! write]]
--     end)
--   end
-- })

-- -- TODO: toggle focus from page/editor in one
-- vim.keymap.set('n', '<Esc><Esc>', '<Cmd>call firenvim#focus_page()<CR>')
-- -- TODO: on certain sites where we know what 'submit' is mapped to like a s-cr by default have a mapping like this:
-- vim.keymap.set('i', '<S-CR>', '<Esc>:w<CR>:call firenvim#press_keys("<lt>CR>")<CR>ggdGa')

-- vim.o.guicursor = 'n-v-c-i-sm-i-ci-ve-r-cr-o:block'
-- vim.cmd.startinsert()
