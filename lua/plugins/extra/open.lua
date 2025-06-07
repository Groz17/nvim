-- how to use operator? like gW2w to search the next 2 words on wikipedia?
return {
--   {
--  "ofirgall/open.nvim",
--  name = "open", -- Open current word by other tools
--  dependencies = "nvim-lua/plenary.nvim",
--  keys = {
--    -- { 'gx', function() require('open').open_cword() end },
--    { 'gX', function() require('open').open_cword() end },
--  }
-- },
{
    "chrishrb/gx.nvim",
    cond = false,
    keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
    cmd = { "Browse" },
    init = function ()
      -- vim.g.netrw_nogx = 1 -- disable netrw gx
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
    submodules = false, -- not needed, submodules are required only for tests

    -- you can specify also another config if you want
    config = function() require("gx").setup {
      open_browser_app = "os_specific", -- specify your browser app; default for macOS is "open", Linux "xdg-open" and Windows "powershell.exe"
      open_browser_args = { "--background" }, -- specify any arguments, such as --background for macOS' "open".
      handlers = {
        plugin = true, -- open plugin links in lua (e.g. packer, lazy, ..)
        github = true, -- open github issues
        brewfile = true, -- open Homebrew formulaes and casks
        package_json = true, -- open dependencies from package.json
        search = true, -- search the web/selection on the web if nothing else is found
      },
      handler_options = {
        -- search_engine = "google", -- you can select between google, bing, duckduckgo, and ecosia
        search_engine = "https://search.brave.com/search?q=", -- or you can pass in a custom search engine
      },
    } end,
  },
  {
    -- maybe add spotify/mail (outlook), etc...
    -- use kitty hints? (https://phaazon.net/blog/editors-in-2022)
    -- magari usa \ come prefisso? tipo \gr
    -- make it work with nwm
    "dhruvasagar/vim-open-url",
    -- what about user input?
    -- treccani map?
    keys = {
      { mode = { 'n', 'x' }, 'gx', desc = "Open url under cursor in the default web browser." },
      { mode = { 'n', 'x' }, 'g<CR>', desc = "Google search word under cursor in the default web browser" },

      -- take inspiration from tridactyl mappings... (maybe add amazon)
      -- why does it save the file if it's unsaved?
      { mode = { 'n', 'x' }, 'gW', desc = "Wikipedia search word under cursor in the default web browser" },
      { mode = { 'n', 'x' }, 'gS', '<Plug>(open-url-search-so)', desc = "Stackoverflow search word under cursor in the default web browser" },
      -- B stands for buy...
      { mode = { 'n', 'x' }, 'gB', desc = "Amazon search word under cursor in the default web browser" },
      { mode = { 'n', 'x' }, 'gY', desc = "Youtube search word under cursor in the default web browser" },
      { mode = { 'n', 'x' }, 'gG', desc = "GitHub search word under cursor in the default web browser" },
    },

    init = function()
      -- vim.g.open_url_browser_default  = 'google'
      -- vim.keymap.set({'n','x'}, 'gx', '<Plug>(open-url-browser)', { desc = "Open url under cursor in the default web browser" })
      -- vim.keymap.set({'n','x'}, 'g<CR>', '<Plug>(open-url-search-google)', { desc = "Open url under cursor in the default web browser" })

    end,
    config = function ()
      vim.keymap.del({'n','x'}, 'gB')

      vim.keymap.set({'n','x'}, 'gx', '<Plug>(open-url-browser)')
      vim.keymap.set({'n','x'}, 'g<CR>', '<Plug>(open-url-search-google)')

      -- vim.keymap.set('n', 'gX', '<CMD>OpenURLFind<CR>', { desc = "Open url under cursor in the default web browser" })
      vim.api.nvim_call_function('open_url#engines#add', {'amazon', 'https://www.amazon.it/s?k=%s'})
      vim.api.nvim_call_function('open_url#engines#add', {'yt', 'https://www.youtube.com/results?search_query=%s'})
      -- what about grep.app
      vim.api.nvim_call_function('open_url#engines#add', {'github', 'https://github.com/search?q=%s'})

      vim.api.nvim_call_function('open_url#engines#add', {'wikipedia_it', 'https://it.wikipedia.org/wiki/Special:Search?search=%s'})

      -- vim.keymap.set('n', 'gA', '<CMD>call open_url#engines#search("amazon", expand("<cword>"))<CR>', { desc = "Open url under cursor in the default web browser" })
      vim.keymap.set({'n','x'}, 'gB', '<CMD>call open_url#engines#search("amazon", expand("<cword>"))<CR>')
      vim.keymap.set({'n','x'}, 'gY', '<CMD>call open_url#engines#search("yt", expand("<cword>"))<CR>')
      vim.keymap.set({'n','x'}, 'gG', '<CMD>call open_url#engines#search("github", expand("<cword>"))<CR>')
      -- vim.keymap.set({'n','x'}, 'gW', '<CMD>call open_url#engines#search("wikipedia_it", expand("<cword>"))<CR>')
      -- vim.keymap.set({'n','x'}, 'gW', function()
        -- fai mapping ita/arab/eng/rus/etc... per ogni lingua
        -- require('easypick').one_off('trans --list-codes')
-- <CMD>call open_url#engines#search("wikipedia_it", expand("<cword>"))<CR>
      -- end
      -- )
    end
  }
}
