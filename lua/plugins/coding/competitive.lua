local leet_arg = 'lc.nvim'
return {{
-- https://github.com/p00f/cphelper.nvim?tab=readme-ov-file
  'kawre/leetcode.nvim',
  lazy = leet_arg ~= vim.fn.argv()[1],
  cmd = 'Leet',
  opts = {
    arg = leet_arg,
    image_support = false,
    lang = "java",
    plugins = {
      non_standalone = true,
    },
  },
  build = ':TSUpdate html',
  dependencies = {
    'snacks.nvim',
    'MunifTanjim/nui.nvim',

    -- optional
    'nvim-treesitter/nvim-treesitter',
    'nvim-mini/mini.icons',
  },
  config = function(_,opts)
    require'leetcode'.setup(opts)
    -- crea filetype mappings
    vim.api.nvim_create_autocmd('BufEnter', {
      group = vim.api.nvim_create_augroup('LeetCode',{}),
      pattern = vim.fn.stdpath('data') .. '/leetcode/*',
      callback = function(ev)
        -- andava bene pure buffer = true qui?
        vim.keymap.set('n', '<localleader>m', '<CMD>Leet menu<CR>', { buffer = ev.buf, desc = "Menu" })
        vim.keymap.set('n', '<localleader>c', '<CMD>Leet console<CR>', { buffer = ev.buf, desc = "Console" })
        vim.keymap.set('n', '<localleader>i', '<CMD>Leet info<CR>', { buffer = ev.buf, desc = "Info" })
        vim.keymap.set('n', '<localleader>Q', '<CMD>Leet tabs<CR>', { buffer = ev.buf, desc = "Tabs" })
        vim.keymap.set('n', '<localleader>l', '<CMD>Leet lang<CR>', { buffer = ev.buf, desc = "Lang" })
        vim.keymap.set('n', '<localleader>r', '<CMD>Leet run<CR>', { buffer = ev.buf, desc = "Run" })
        vim.keymap.set('n', '<localleader>t', '<CMD>Leet test<CR>', { buffer = ev.buf, desc = "Test" })
        vim.keymap.set('n', '<localleader>s', '<CMD>Leet submit<CR>', { buffer = ev.buf, desc = "Submit" })
        vim.keymap.set('n', '<localleader>d', '<CMD>Leet daily<CR>', { buffer = ev.buf, desc = "Daily" })
        vim.keymap.set('n', '<localleader>y', '<CMD>Leet yank<CR>', { buffer = ev.buf, desc = "Yank" })
        vim.keymap.set('n', '<localleader>o', '<CMD>Leet open<CR>', { buffer = ev.buf, desc = "Open" })
        -- vim.keymap.set('n', '<localleader>r', '<CMD>Leet reset<CR>', { buffer = ev.buf, desc = "Reset" })
        vim.keymap.set('n', '<localleader>l', '<CMD>Leet last_submit<CR>', { buffer = ev.buf, desc = "Last_submit" })
        -- vim.keymap.set('n', '<localleader>r', '<CMD>Leet restore<CR>', { buffer = ev.buf, desc = "Restore" })
        -- vim.keymap.set('n', '<localleader>i', '<CMD>Leet inject<CR>', { buffer = ev.buf, desc = "Inject" })
        -- vim.keymap.set('n', '<localleader>s', '<CMD>Leet session<CR>', { buffer = ev.buf, desc = "Session" })
        vim.keymap.set('n', '<localleader>q', '<CMD>Leet list<CR>', { buffer = ev.buf, desc = "List" })
        vim.keymap.set('n', '<localleader>?', '<CMD>Leet random<CR>', { buffer = ev.buf, desc = "Random" })
        -- vim.keymap.set('n', '<localleader>d', '<CMD>Leet desc<CR>', { buffer = ev.buf, desc = "Desc" })
        -- vim.keymap.set('n', '<localleader>c', '<CMD>Leet cookie<CR>', { buffer = ev.buf, desc = "Cookie" })
        -- vim.keymap.set('n', '<localleader>c', '<CMD>Leet cache<CR>', { buffer = ev.buf, desc = "Cache" })
        -- vim.keymap.set('n', '<localleader>f', '<CMD>Leet fix<CR>', { buffer = ev.buf, desc = "Fix" })
      end
    })
  end
},
{
-- https://github.com/jmerle/competitive-companion?tab=readme-ov-file#competitive-companion
    "A7lavinraj/assistant.nvim",
    cond = false,
    dependencies = { "folke/snacks.nvim" }, -- optional but recommended
    lazy = false, -- if you want to start TCP Listener on neovim startup
    keys = {
      { "<leader>1", "<cmd>AssistantToggle<cr>", desc = "Assistant.nvim" }
    },
    opts = {}
}
}
