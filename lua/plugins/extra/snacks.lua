-- Snacks.input.enable()
-- make snacks.nvim lazy-loaded?
-- crea cartella snacks con vari plugin?
-- how to make transparent?
return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    explorer =
    {
      replace_netrw = true, -- Replace netrw with the snacks explorer
    },
    -- use same trick to show only errors, infos etc... with v:count (for notification history)
    -- /tmp/.mount_nvimfk8cr5/usr/share/nvim/runtime/lua/vim/_editor.lua check out this? for numbers to use with v:count
    -- @alias snacks.notifier.level "trace"|"debug"|"info"|"warn"|"error"
    -- you can also jump to notification window using ^ww
    -- show where notification came from? (plugin)
    notify = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
      -- width = { min = 40, max = 0.8 },
      style = 'fancy',
      -- e una buona idea metterlo in mezzo?
      -- TODO: fai in modo che notifiche successive si spostino a destra e non in basso
      -- BUG: funge bene solo se hai una solo window...
      -- margin = { top = 0, right = math.floor(vim.o.columns/2-15) , bottom = 0 },
      -- top_down = true,
    },
    quickfile = { enabled = true },
    -- magari disable per snacks preview?
    statuscolumn = { enabled = false },
    words = { enabled = true },
    input = { enabled = true },
    -- indent = {
    --   indent = {
    --     only_scope = true, -- only show indent guides of the scope
    --     only_current = true, -- only show indent guides in the current window
    --   },
    --   scope = {
    --     only_current = true, -- only show scope in the current window
    --   },
    --   chunk = {
    --     only_current = true,
    --   }
    -- },
    styles = {
      -- TODO: use syntax highlighting for vimwiki notifications (like Send and file in different highlights)
      notification = {
        wo = { wrap = true }, -- Wrap notifications
      },
    },
  },
  keys = {
    -- TODO: todo: autofocus file when opening from neovim???
    -- how to exclude jj in TUIs? (basically i want it just for shell) (and for lazygit confirm dialog/confirm in general)
    -- { '<leader>gg', function() Snacks.lazygit() vim.keymap.del('t','jj') end, desc = 'Lazygit' },
    -- how to open in current directory?
    -- { '<leader>gg', function() Snacks.lazygit() end, desc = 'Lazygit' },
    -- like magit
    -- { '<f12>g', function() Snacks.lazygit() end, desc = 'Lazygit' },
    -- { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
    -- { mode={"n","x"}, "<leader>gx", function() Snacks.gitbrowse() end, desc = "Git Browse" },
    -- { mode={"n","x"}, "<leader>gy", function() Snacks.gitbrowse.get_url() end, desc = "Git Browse" },
    -- { "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History" },
    -- { "<leader>gl", function() Snacks.lazygit.log() end, desc = "Lazygit Log (cwd)" },
    -- also add move() function?
    { '<F2>', function() Snacks.rename.rename_file() end,      desc = 'Rename File' },
    -- one shot mapping? maybe define keymap variable
    -- { '<F12>r', function() Snacks.rename.rename_file() end, desc = 'Rename File' },
    -- show virtual lines number like for #/*?
    { ']]',   function() Snacks.words.jump(vim.v.count1) end,  desc = 'Next Reference' },
    { '[[',   function() Snacks.words.jump(-vim.v.count1) end, desc = 'Prev Reference' },
    {
      '<f18>n',   -- same keybinding as emacs
      desc = 'Neovim News',
      function()
        Snacks.win({
          file = vim.api.nvim_get_runtime_file('doc/news.txt', true)[vim.v.count1+1],
          -- file = vim.api.nvim_eval([=[nvim_get_runtime_file('doc/news*.txt', v:true)->filter({_,v->v=~'/runtime/doc/news'..(!v:count?'':('-0.'..v:count..'.txt'))})[0]]=]),
          width = 0.6,
          height = 0.6,
          wo = {
            spell = false,
            wrap = false,
            signcolumn = 'yes',
            statuscolumn = ' ',
            conceallevel = 3,
          },
        })
      end,
    },
  },
  init = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command
      end,
    })
  end,
}
