return {
  {
    'rest-nvim/rest.nvim',
    ft = 'http',
    config = function()
      -- using mappings without leader in filetype plugins is a genious idea
      -- TODO: consider using localledear
      vim.keymap.set('n', 'rr', '<cmd>Rest run<cr>', { buffer = true, desc = 'Run request under the cursor' })
      vim.keymap.set('n', 'rR', ':Rest run<space>', { buffer = true, desc = 'Run request with given name' })
      vim.keymap.set('n', 'rd', '<cmd>Rest run document<cr>', { buffer = true, desc = 'Run request under the cursor' })
      vim.keymap.set('n', 'rl', '<cmd>Rest run last<cr>', { buffer = true, desc = 'Re-run latest request' })
      vim.keymap.set('n', 'rL', '<cmd>Rest logs<cr>', { buffer = true, desc = 'Opens the rest.nvim logs file' })
      -- preview???
      -- vim.keymap.set("n", "rp", "<Plug>RestNvimPreview", { desc = "Preview the request cURL command", buffer = true})
      --
      -- require('telescope').load_extension('rest')
      -- vim.keymap.set('n', 're', function() require('telescope').extensions.rest.select_env() end, { desc = 'Select/Edit Env file', buffer = true })

      vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
        group = vim.api.nvim_create_augroup('Rest', { clear = false }),
        pattern = { '*.http' },
        callback = function(buf) vim.cmd([[Rest run]]) end,
      })

    end,
    -- TODO: nvim-completion (setup con la source)
    -- TODO: crea autocommands to uppercase keywords like get, etc...
  },
  {
    'oysandvik94/curl.nvim',
    init = function()
      -- TODO: usa ftdetect (magari cosi compare anche nel picker dei filetype?)
      vim.api.nvim_create_autocmd('BufEnter', {
        group = vim.api.nvim_create_augroup('Curl', { clear = false }),
        pattern = '*.curl',
        callback = function() vim.cmd([[se filetype=curl]]) end,
      })
    end,
    cmd = { 'CurlOpen' },
    ft = 'curl',
    dependencies = {
      'nvim-lua/plenary.nvim',
      keys = {
        { '<localleader>o', function() require('curl').open_curl_tab() end, desc = 'Open a curl tab scoped to the current working directory', buffer = true, ft = 'curl'},
        { '<localleader>O', function() require('curl').open_global_tab() end, desc = 'Open a curl tab with global scope', buffer = true, ft = 'curl'},
        -- These commands will prompt you for a name for your collection
        { '<localleader>c', function() require('curl').create_scoped_collection() end, desc = 'Create or open a collection with a name from user input', buffer = true, ft = 'curl'},
        { '<localleader>C', function() require('curl').create_global_collection() end, desc = 'Create or open a global collection with a name from user input', buffer = true, ft = 'curl'},
        { '<localleader>f', function() require('curl').pick_scoped_collection() end, desc = 'Choose a scoped collection and open it', buffer = true, ft = 'curl'},
        { '<localleader>F', function() require('curl').pick_global_collection() end, desc = 'Choose a global collection and open it', buffer = true, ft = 'curl'},
      },
    },
    config = true,
  },
}
