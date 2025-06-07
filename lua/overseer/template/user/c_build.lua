return {
  name = 'Build & Debug C',
  desc = 'build and debug C program',
  condition = {
    filetype = 'c',
  },
  builder = function()
    -- local file = vim.fn.expand('%:p')
    local file = vim.api.nvim_buf_get_name(0)
    local out = '/tmp/' .. vim.fn.fnamemodify(file, ':t:r')

    return {
      cmd = 'gcc',
      -- runna solo se non c'è gia l'eseguibile?
      args = { '-g', file, '-o', out },
      components = { { 'on_output_quickfix', open = true }, 'default' },
    }
  end,
}
