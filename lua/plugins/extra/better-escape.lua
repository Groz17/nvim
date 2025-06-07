return {
  'max397574/better-escape.nvim',
  -- usa keys in opts.mappings? keys = {...},
  -- event = { "CursorHold", "CursorHoldI" },
  opts = {
    -- mapping = {"jk", "jl"}, -- a table with mappings to use
    -- maybe add those user insert mappings that start with j, k, etc...
    default_mappings = false,
    -- i wish i could define the mappings elsewhere and here just put the keys...
    mappings = {
      -- c = {
      --   j = {
      --     k = '<cr>',
      --   },
      -- },
      i = {
        -- d = {
        --   f = '<esc>'
        -- },
        -- bel movimento, confortevole
        -- con le home row mods non serve piu tanto
        -- f = {
        --   d = '<bs>'
        -- },
        -- j = {
          -- j = '<esc>'
          -- j = '<cmd>x<cr>'
          -- j = '<cmd>up<cr><esc>'
          -- k = '<cmd>up<cr><esc>',
        -- },

        -- non funge...
        -- ['<space>'] = {
        --   ['<space>'] ='<cmd>up<cr><esc>'
        -- },
      },
      --   j = {
      -- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
      -- ┃ escape                                                  ┃
      -- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

      -- from vscode-neovim readme
      -- j = "<esc>",
      -- i need <a-<num>> in neovim
      -- non funge molto bene
      -- j = "<c-h>",
      -- j = "<bs>",
      -- jk puoi facile da typare, quindi meglio visto che salvo spesso
      -- k = "<cmd>up<cr><esc>",

      -- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
      -- ┃ save + save & exit                                      ┃
      -- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
      -- "j",
      -- for telescope
      -- vim.keycode("<space><space>"), -- FIX: always use keycode
      -- "JJ",
      -- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
      -- ┃ tabout                                                  ┃
      -- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
      -- "l",
      -- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
      -- ┃ normal mode command                                     ┃
      -- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
      -- Usa una o l'altra a seconda dei tasti che stai premendo
      -- "fd",
      -- "df",
      -- "jd",
      -- },
      -- },

      -- tanto eredita da ~/.inputrc right?
      t = {
        ['<esc>'] = {
          ['<esc>'] = '<esc>',
        },
        j = {
          -- j = "<CR>",
          -- NOTE: fix for TUIs (more general approach?)
          -- is this a expression mapping?
          -- for lazygit
          -- j =function() if vim.bo.filetype ~= 'yazi' and vim.bo.filetype ~= 'snacks_terminal' and vim.bo.filetype ~= 'lazy' then return "<CR>"end end,
          -- TODO: metti mapping cr in lazy config
          -- k =function() if vim.bo.filetype ~= 'yazi' and vim.bo.filetype ~= 'snacks_terminal' and vim.bo.filetype ~= 'lazy' then return [[<C-\><C-N>]]end end,
        },
        -- ['<space>'] = {
        --   ['<space>'] =function() if vim.bo.filetype ~= 'fzf' then return "<space>"end end,
        -- },
      },
      -- c = {}?
      -- Use ojk to go to other side first
      -- v = {
      -- j = {
      -- k = "<Esc>",
      -- },
      -- },
    },
    -- clear_empty_lines = true,   -- clear line after escaping if there is only whitespace
  },
  -- keys = { mode  = "i", "jk"}
  -- keys = { mode  = "i", "j"}
}
-- Get out of insert mode
-- inoremap jk <esc>
-- come mappare jk a cntrl? così per provare se è una buona idea
-- inoremap jk <cntrl>?
-- cnoremap jk <C-C>

-- vim.keymap.set('i','<c-l>','<cmd>up<cr><esc>')
-- for gitcommit message
-- vim.keymap.set('i','JJ','<cmd>x<cr><esc>')
-- kanata mapping for this?
-- vim.keymap.set('i','JJ','<esc><cmd>x<cr>')
-- vim.keymap.set('i','jj','<bs>')
-- vim.keymap.set('i','jk','<esc>')
-- Mnemonic: Going from future/right (k) to past/left (j)
-- doesn't work when writing think and then saving with jj.
-- vim.keymap.set('i','kj','<c-o>u')
-- vim.keymap.set('i','jl','<esc>')
-- maybe also add an insert/normal mode mapping to exit window more comfortably?
-- maybe use uncommon insert mode mappings to insert symbols like =??? also search for non-used or extremely uncommon bigrams that you can use in mappings (preferably in both english and italian or in generale european languages)
-- find uncommon digraphs with smth like this: $ cat american-english  | sed -E '/^[^j]*$/d' | sed -E 's/([^j]*)?(j.)/\2\n/g' | grep '^j' | sort | uniq -c
-- <Lshift><space> for [ and <Rshift><space> for ]???
-- vim.keymap.set('i','jl','=')
-- vim.keymap.set('i','jm',' = ')
-- maybe create mapping for <c-o> in insert mode like j, or smth?
-- insert mode mappings for common operations?
-- vim.keymap.set('i','jx','<esc>lxi')
-- vim.keymap.set('i','jd','<c-h>')
-- vim.keymap.set('i','jf','<c-h>')
-- usa <c-j> per newline
