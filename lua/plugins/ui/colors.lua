return {
    -- what about blink?
    'brenoprata10/nvim-highlight-colors',
    event = 'BufEnter', -- event = { "BufReadPre *.html,*.conf,*.lua,*.css", "BufWritePost", "BufNewFile" },
    opts = {
      -- render = 'foreground',
      -- render = 'virtual',
      render = 'background',
      enable_tailwind = true,
      -- maybe also octo...
      -- also ignore if part of url...
      exclude_buffer = function(bufnr) return
        -- vim.bo[bufnr].filetype == 'bigfile' or vim.bo[bufnr].filetype=='lazy'
        vim.tbl_contains({'bigfile','lazy','xxd'},vim.bo[bufnr].filetype)
      end
    },
  }

