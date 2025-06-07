-- TODO: magari crea cartella filetype?
-- https://github.com/chrisbra/csv.vim
-- voglio which-key che mi mostri commandi <buffer>-bound
-- premi <cr> per eseguirli e <c-cr> per eseguire bang command (fai check se si puo, senno notifica)
-- use filter per togliere i comandi che iniziano per :CSV che sono duplicati
return {
  -- {
  --   "chrisbra/csv.vim",
  --   init = function()
  --     vim.g.csv_start = 1
  --     vim.g.csv_end = 100
  --   end,
  --   -- ft = 'csv',
  --   config = function()
  --     vim.keymap.set('c','c',function() return (vim.fn.getcmdpos() == 1 and vim.fn.getcmdtype() == ':') and 'CSV' or 'c' end,{buffer = true, expr = true})
  --   end
  -- },
  {
    'cameron-wags/rainbow_csv.nvim',
    cond = false,
    init = function()
      vim.g.disable_rainbow_key_mapings = 1
      -- TODO: doesn't work
      vim.g.rbql_backend_language = 'js'
    end,
    ft = { 'csv', 'tsv', 'csv_semicolon', 'csv_whitespace', 'csv_pipe', 'rfc_csv', 'rfc_semicolon' },
    cmd = { 'RainbowDelim', 'RainbowDelimSimple', 'RainbowDelimQuoted', 'RainbowMultiDelim' },
    config = function()
      require'rainbow_csv'.setup({})
      vim.keymap.set('c','s',function() return (vim.fn.getcmdpos() == 1 and vim.fn.getcmdtype() == ':') and 'Select ' or 's' end,{buffer = true, expr = true})
      vim.keymap.set('c','u',function() return (vim.fn.getcmdpos() == 1 and vim.fn.getcmdtype() == ':') and 'Update ' or 'u' end,{buffer = true, expr = true})

      -- variable doesn't exists...if another language gets added, use vim.ui.select instead of toggling
      -- local languages = vim.g.rbql_backend_languages
      vim.keymap.set('n','<localleader>l',function()
       vim.api.nvim_set_var('rbql_backend_language', vim.api.nvim_get_var('rbql_backend_language') == 'python' and 'js' or 'python')
      end,{buffer = true, desc = "Toggle backend language"})

      vim.keymap.set('n', '<cr>', function() require'rainbow_csv.fns'.select_from_file() end, { buffer = true })
      -- filetype should be rbql
      -- vim.keymap.set('n', '<cr>', function() require'rainbow_csv.fns'.finish_query_editing() end--[[, { buffer = true }]])
      vim.keymap.set('n', '<localleader>e', function() require'rainbow_csv.fns'.finish_query_editing() end--[[, { buffer = true }]])
      -- vim.keymap.set('n', '<space><space>', function() require'rainbow_csv.fns'.copy_file_content_to_buf(vim.b.self_path, vim.b.root_table_buf_number) end--[[, { buffer = true }]])
      vim.keymap.set('n', '<localleader>y', function() require'rainbow_csv.fns'.copy_file_content_to_buf(vim.b.self_path, vim.b.root_table_buf_number) end--[[, { buffer = true }]])
    end,
  },
  {
    'emmanueltouzery/decisive.nvim',
    -- BUG: doesn't work for 1st and last field
    -- ic text object (no mini.ai integration) (can you integrate it in a plugin?)
    opts = {},
    ft = { 'csv' },
    keys = {
      -- maybe toggle mapping?
      { '<localleader>a', "<CMD>lua require('decisive').align_csv({})<cr>", desc = 'Align CSV', buffer = true, ft = 'csv' },
      { '<localleader>A', "<CMD>lua require('decisive').align_csv_clear({})<cr>", desc = 'Align CSV clear', buffer = true, ft = 'csv' },
      -- TODO: demicolon integration
      -- { '[c', "<CMD>lua require('decisive').align_csv_prev_col()<cr>", desc = 'Align CSV prev col', buffer = true, ft = 'csv' },
      -- { ']c', "<CMD>lua require('decisive').align_csv_next_col()<cr>", desc = 'Align CSV next col', buffer = true, ft = 'csv' },
      -- per il momento...
      { '(', "<CMD>lua require('decisive').align_csv_prev_col()<cr>", desc = 'Align CSV prev col', buffer = true, ft = 'csv' },
      { ')', "<CMD>lua require('decisive').align_csv_next_col()<cr>", desc = 'Align CSV next col', buffer = true, ft = 'csv' },
    },
    config = function(_,opts)
      require'decisive'.setup(opts)
      -- vim.cmd[[hi CsvFillHlEven ctermbg=red guibg=red]]
      vim.cmd[[hi CsvFillHlEven ctermbg=none guibg=none]]
    end

  }
}
