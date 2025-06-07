-- Customize 'mini.nvim'
local has_mini_ai, mini_ai = pcall(require, 'mini.ai')
if has_mini_ai then
  vim.b.miniai_config = {
    custom_textobjects = {
      ['*'] = mini_ai.gen_spec.pair('*', '*', { type = 'greedy' }),
      ['_'] = mini_ai.gen_spec.pair('_', '_', { type = 'greedy' }),
    },
  }
end

local has_mini_surround, mini_surround = pcall(require, 'mini.surround')
if has_mini_surround then
  vim.b.minisurround_config = {
    custom_surroundings = {
      -- Link
      L = {
        input = { '%[().-()%]%(.-%)' },
        output = function()
          -- local link = mini_surround.user_input('Link: ')
          local link = mini_surround.user_input('Link: ')
          if link then
            if link == '' then link = vim.fn.getreg(vim.v.register):gsub("\n", "") end
            return { left = '[', right = '](' .. link .. ')' }
          end
        end,
      },
    c = { input = { '```\n().-()\n```' }, output = { left = '```\n', right = '\n```' } },
    },
  }
end
