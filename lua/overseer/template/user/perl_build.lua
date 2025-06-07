return {
  name = 'Run Perl',
  desc = 'Run a Perl program',
  condition = {
    filetype = 'perl',
  },
  builder = function()
    local file = vim.fn.expand('%')
    return {
      cmd = 'perl',
      args = { file },
      components = { { 'on_output_quickfix', open = true }, 'default' },
    }
  end,
}
