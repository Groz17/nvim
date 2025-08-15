-- lilypond?
return {
  --     {"madskjeldgaard/reaper-nvim", cond = false,
  --     dependencies = {'davidgranstrom/osc.nvim',
  --     {'junegunn/fzf.vim',dependencies='junegunn/fzf'},
  -- },
  --     opts = {},
  --
  --   }
  {
    -- blink completion?
    -- also snippets for chords like use a trigger like semicolon or smth and then the chord like c and it should return c e g
    -- also snippets like pravi or persian for inserting scales? also for lilypond, etc...
    -- would be nice if the cursor moved when the music was playing
    -- add template file (when you're old you're old)
    -- also use ctrl-a to increment notes and then after g go to a?
    -- also visually select notes and show the corresponding chord?
    -- maybe visually select and press K to show corresponding sheet?
    'daveyarwood/vim-alda',
    ft = 'alda',
    config = function()
      vim.api.nvim_create_autocmd('BufWritePost', {
        group = vim.api.nvim_create_augroup('PlayBuffer', { clear = true }),
        buffer = vim.fn.bufnr('%'),
        command = 'exe "AldaStopPlayback"|AldaPlayBuffer',
      })
    end,
    -- vim.keymap.set('x','<space><space>','<localleader>p', { remap = true, buffer = true })
    vim.keymap.set('x','<f12><c-e>','<localleader>p', { remap = true, buffer = true })
  },
}
