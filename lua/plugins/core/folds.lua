-- https://github.com/anuvyklack/pretty-fold.nvim
return {{
-- https://www.reddit.com/r/neovim/comments/1k3l7j9/comment/mo4wajb/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
  -- https://www.reddit.com/r/neovim/comments/10q2mjq/i_dont_really_get_folding/ (close_fold_kinds)
  -- l opens a fold
  "kevinhwang91/nvim-ufo",
  cond = false,
  dependencies = "kevinhwang91/promise-async",
  event = "BufReadPost",
  init = function()
    vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
    vim.o.foldcolumn = "0" -- '0' is not bad
    vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
  end,
  config = function()

    local handler = function(virtText, lnum, endLnum, width, truncate)
      local newVirtText = {}
      local suffix = ('  %d '):format(endLnum - lnum)
      -- local suffix = (' 祉 %d '):format(endLnum - lnum)
      local sufWidth = vim.fn.strdisplaywidth(suffix)
      local targetWidth = width - sufWidth
      local curWidth = 0
      for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
          table.insert(newVirtText, chunk)
        else
          chunkText = truncate(chunkText, targetWidth - curWidth)
          local hlGroup = chunk[2]
          table.insert(newVirtText, { chunkText, hlGroup })
          chunkWidth = vim.fn.strdisplaywidth(chunkText)
          -- str width returned from truncate() may less than 2nd argument, need padding
          if curWidth + chunkWidth < targetWidth then
            suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
          end
          break
        end
        curWidth = curWidth + chunkWidth
      end
      table.insert(newVirtText, { suffix, 'MoreMsg' })
      return newVirtText
    end

    require("ufo").setup({
      provider_selector = function(bufnr, filetype, buftype)
        return { "treesitter", "indent" }
      end,
      fold_virt_text_handler = handler
    })

    -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
    vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
    vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
    vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
    vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
    vim.keymap.set('n', 'zK', require('ufo').peekFoldedLinesUnderCursor)

    -- How to make the cursor not jump?
    vim.keymap.set('n', 'z[', function() require('ufo').goPreviousClosedFold() require('ufo').peekFoldedLinesUnderCursor() end,{desc="Ufo peek prev fold"})
    vim.keymap.set('n', 'z]', function() require('ufo').goNextClosedFold() require('ufo').peekFoldedLinesUnderCursor() end,{desc="Ufo peek next fold"})

    vim.keymap.set('n','zk', function() require('ufo').goPreviousStartFold() end, {desc='Ufo go previous start fold'})
    vim.keymap.set('n','zJ', function() require('ufo').goNextClosedFold() end, {desc='Ufo go next close fold'})

  end,
},

{
    "OXY2DEV/foldtext.nvim",
    cond = false,
    lazy = false
}
}

-- ufo (folds)
-- https://www.reddit.com/r/neovim/comments/12f705t/comment/jfktf8p/?utm_source=share&utm_medium=web2x&context=3
