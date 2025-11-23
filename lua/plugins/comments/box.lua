return{
    -- create telescope extension that shows the catalog (w/ preview) and when pressing <CR> generates the comment
    -- How to adjust indent based on current indentation?
    -- create operator? maybe with boxes cli command...
    -- support block/multiline comments like --[[]] in lua?
    -- make it support dot repeat
    -- magari usa hex trick
    'LudoPinelli/comment-box.nvim', -- same command as emacs
    opts = {
      doc_width = vim.opt.columns:get(),
      -- doesn't work?
      -- comment_style="auto",
      comment_style = 'line',
      -- inner_blank_lines = true, -- insert a blank line above and below the text
    },
    -- do these mappings make sense in visual mode?
    keys = {
      --  ╭──────────────────────────────────────────────────────────╮
      --  │                          Boxes                           │
      --  ╰──────────────────────────────────────────────────────────╯
      -- non sono sicuro di <leader>C?
      -- magari usa whichkey api per sostitutire il valore di which key per comment-box così modifichi il prefisso solo una volta (fallo per tutti i prefissi che non sei sicuro, non LSP e Git)
      -- usa stesso prefix di comment textobject

      -- let dict = { 'll':'J','cc':'K','rr':'L','l':'j','c':'k','r':'l'} (easier to type)
      -- Boxes
      -- The type n°1 for the box and line is the default one, so vim.v.count1 fits well
      -- comma because it has rounding shape, like a box
      -- ctrl-comma non funge, ma non va male come mapping
      -- { mode = { "n", "x" }, "<c-,>jj", function() require("comment-box").llbox(vim.v.count1) end, desc = "Left aligned box of fixed size with Left aligned text" },

      -- You can imagine o as a circular box
      -- sk -> surround with bo[k]s
      -- Would be nice to intergrate with surround plugin (surround with box/line) and which-key that shows the name of the styles like inn the catalog...
      { mode = { "n", "x" }, "<space>;jj", function() require("comment-box").llbox(vim.v.count1) end, desc = "Left aligned box of fixed size with Left aligned text" },
      { mode = { "n", "x" }, "<space>;jk", function() require("comment-box").lcbox(vim.v.count1) end, desc = "Left aligned box of fixed size with Centered text" },
      { mode = { "n", "x" }, "<space>;jl", function() require("comment-box").lrbox(vim.v.count1) end, desc = "Left aligned box of fixed size with Right aligned text" },
      { mode = { "n", "x" }, "<space>;kj", function() require("comment-box").clbox(vim.v.count1) end, desc = "Centered box of fixed size with Left aligned text" },
      { mode = { "n", "x" }, "<space>;kk", function() require("comment-box").ccbox(vim.v.count1) end, desc = "Centered box of fixed size with Centered text" },
      { mode = { "n", "x" }, "<space>;kl", function() require("comment-box").crbox(vim.v.count1) end, desc = "Centered box of fixed size with Right aligned text" },
      { mode = { "n", "x" }, "<space>;lj", function() require("comment-box").rlbox(vim.v.count1) end, desc = "Right aligned box of fixed size with Left aligned text" },
      { mode = { "n", "x" }, "<space>;lk", function() require("comment-box").rcbox(vim.v.count1) end, desc = "Right aligned box of fixed size with Centered text" },
      { mode = { "n", "x" }, "<space>;ll", function() require("comment-box").rrbox(vim.v.count1) end, desc = "Right aligned box of fixed size with Right aligned text" },
      { mode = { "n", "x" }, "<space>;ja", function() require("comment-box").labox(vim.v.count1) end, desc = "Left aligned adapted box" },
      { mode = { "n", "x" }, "<space>;ka", function() require("comment-box").cabox(vim.v.count1) end, desc = "Centered adapted box" },
      { mode = { "n", "x" }, "<space>;la", function() require("comment-box").rabox(vim.v.count1) end, desc = "Right aligned adapted box" },

      -- Titled lines
      -- l in <c-l> sta per line
      -- sl -> surround with line
      -- stylua: ignore start
      -- { mode = { "n", "x" }, "<c-;>jj", function() require("comment-box").llline(vim.v.count1) end, desc = "Left aligned titled line with Left aligned text" },
      -- { mode = { "n", "x" }, "<c-;>jk", function() require("comment-box").lcline(vim.v.count1) end, desc = "Left aligned titled line with Centered text" },
      -- { mode = { "n", "x" }, "<c-;>jl", function() require("comment-box").lrline(vim.v.count1) end, desc = "Left aligned titled line with Right aligned text" },
      -- { mode = { "n", "x" }, "<c-;>kj", function() require("comment-box").clline(vim.v.count1) end, desc = "Centered title line with Left aligned text" },
      -- { mode = { "n", "x" }, "<c-;>kk", function() require("comment-box").ccline(vim.v.count1) end, desc = "Centered titled line with Centered text" },
      -- { mode = { "n", "x" }, "<c-;>kl", function() require("comment-box").crline(vim.v.count1) end, desc = "Centered titled line with Right aligned text" },
      -- { mode = { "n", "x" }, "<c-;>lj", function() require("comment-box").rlline(vim.v.count1) end, desc = "Right aligned titled line with Left aligned text" },
      -- { mode = { "n", "x" }, "<c-;>lk", function() require("comment-box").rcline(vim.v.count1) end, desc = "Right aligned titled line with Centered text" },
      -- { mode = { "n", "x" }, "<c-;>ll", function() require("comment-box").rrline(vim.v.count1) end, desc = "Right aligned titled line with Right aligned text" },
      -- stylua: ignore end

      -- Lines
      -- use <c-,> here? , slimmer than ; (like a line is slimmer than a box)
      -- maybe w/ ghostty <c-,> works... yes!
      -- how to give count to insert-mode mapping?
      -- { mode = { --[[ "n", ]] "i" }, "<a-j>",   function() require("comment-box").line(vim.g.count1) end,   desc = "Left aligned line" },
      -- { mode = { --[[ "n", ]] "i" }, "<a-j>",   function()
      --  -- local  char_before = vim.fn.substitute(vim.fn.getline('.'), [[^.*\(\d\+\)\%#.*$]], [[\1]], '')
      --  -- local  char_before = vim.fn.substitute(vim.fn.getline('.'), [[\(\d\+\)\%#]], [[\1]], '')
      --    local style = vim.trim(vim.fn.getline('.'))
      --  -- it kinda triggers me that it is not called lline
      --     require("comment-box").line(vim.fn.str2nr(style))
      --  end
      --  , desc = "Left aligned line"
      -- },
      --                                                                            ╭─────────────────────────────────────────────────────────╮
      --                                                                            │  { mode = { --[[ "n", ]] "i" }, "<a-k>",   function()   │
      --                                                                            │       local style = vim.trim(vim.fn.getline('.'))       │
      --                                                                            │   require("comment-box").cline(vim.fn.str2nr(style))    │
      --                                                                            │             end,  desc = "Centered line" },             │
      --                                                                            ╰─────────────────────────────────────────────────────────╯
      -- { mode = { --[[ "n", ]] "i" }, "<a-l>",   function() local style = vim.trim(vim.fn.getline('.')) require("comment-box").rline(vim.fn.str2nr(style)) end, desc = "Right aligned line" },

      -- Operations (delete, yank, view)
      { mode = { "n" }, "dc",    function() require("comment-box").dbox() end, desc = "Remove a box or titled line, keeping its content" },
      { mode = { "n" }, "yc",    function() require("comment-box").yank() end, desc = "Yank the content of a box or titled line" },
      -- -- Catalog
      -- make this accept vim.v.count1 to show only that style?
      -- fzf-lua mapping to select box type for current session?
      { mode = { "n" }, "vc", function() require("comment-box").catalog() end, desc = "Try other styles of boxes and lines" },
    },
    config = function(_, opts)
      require('comment-box').setup(opts)
      -- map ]b [b to go to next block comment
      -- unimpaired mapping is useless tbh (use new mini bracketed plugin)
      -- vim.keymap.set('n', ']b', '/\\S\\zs\\s*╭<CR>zt')
      -- vim.keymap.set('n', '[b', '?\\S\\zs\\s*╭<CR>zt')
      -- vim.keymap.set('n', ']<m-;>', '?\\S\\zs\\s*╭<CR>zt')
      -- vim.keymap.set('n', '[<m-;>', '?\\S\\zs\\s*╭<CR>zt')
      -- vim.keymap.set('n', ']<c-;>', '?\\S\\zs\\s*╭<CR>zt')
      -- vim.keymap.set('n', '[<c-;>', '?\\S\\zs\\s*╭<CR>zt')
    end,
  }
