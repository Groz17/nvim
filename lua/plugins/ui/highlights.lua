-- does it work with snacks preview as well, etc...?
-- https://github.com/echasnovski/mini.nvim/issues/878
-- TODO: Tailwind: https://github.com/philosofonusus/nvim/blob/f45582c22a17f5ed7ee67fbae40c37e8e3694c13/lua/custom/plugins/colorizer.lua#L11
return {
  'echasnovski/mini.hipatterns',
  event = 'BufEnter',
  ---@see https://github.com/lassoColombo/macos.config/blob/52daa3c4c70b97570d9b840f997c1e9c3ca7d6de/nvim/lua/custom/UI/hipatterns.lua#L4
  opts = function()
    local hi = require 'mini.hipatterns'

    -- NOTE: you could use rot13 in some cases?
    local censor_extmark_opts = function(_, match, _)
      local mask = string.rep('x', vim.fn.strchars(match))
      return {
        virt_text = { { mask, 'Comment' } }, virt_text_pos = 'overlay',
        priority = 200, right_gravity = false,
      }
    end
    return {
      highlighters = {
        hex_color = hi.gen_highlighter.hex_color { priority = 2000 },
        shorthand = {
          pattern = '()#%x%x%x()%f[^%x%w]',
          group = function(_, _, data)
            ---@type string
            local match = data.full_match
            local r, g, b = match:sub(2, 2), match:sub(3, 3), match:sub(4, 4)
            local hex_color = '#' .. r .. r .. g .. g .. b .. b

            return require('mini.hipatterns').compute_hex_color_group(hex_color, 'bg')
          end,
          extmark_opts = { priority = 2000 },
        },
        trailspace = { pattern = '%f[%s]%s*$', group = 'Error' },
        censor = {
          -- TODO: generalize pattern
          -- TODO: how to disable/toggle?
          pattern = 'password: ()%S+()',
          group = '',
          extmark_opts = censor_extmark_opts,
        },
        github_token = {
          pattern = function (buf_id)
            if vim.bo[buf_id].filetype ~= 'http' then return nil end
            return '@token = ()%S+()'
          end,
          group = '',
          extmark_opts = censor_extmark_opts,
        },
        vimwiki_important = {
          pattern = function (buf_id)
            if vim.bo[buf_id].filetype ~= 'text' then return nil end
            return '%f[%w]()THIS %->>> '
          end,
          -- group = 'Special'
          -- TODO: how to show in snacks preview as well? maybe :hi?
          group = 'markdownRule'
        }
      },
    }
  end,
  keys = {
    {
      '<leader>1h', --z/ prefix mapping?
      function()
        require('mini.hipatterns').toggle()
      end,
      mode = 'n',
      desc = '[T]oggle [H]ighlight patterns',
    },
  },
}
