-- magari fai <c-s-w> to delete prev <cWORD>?
-- return to previous position? previous cursor like <c-^> but for cursors basically
-- would be nice if it accepted/supported a count with <a-<num>> (maybe for all insert mode mappings?)
-- usa command per vim mappings in insert mode like ctrl-t e ctrl per queste? per esperienza consistente readline/vim... o magari usa katana per vim mappings?

-- come usare questo in readline?
-- you could maybe use <c-x> as a prefix in command line mode? but what about insert
-- TODO: add ^[ to go to next character and M-C-[
return {
  -- "linty-org/readline.nvim",
  'assistcontrol/readline.nvim',
  pin = true,
  -- stylua: ignore
  keys = {
    -- c-f in command line mode apre window quando e alla fine??? come in rsi... (geniale perchè ctrl-f alla fine non serve)
    -- usa capslock (cap2esc)
    --  ╭──────────────────────────────────────────────────────────╮
    --  │               Supported Readline commands                │
    --  ╰──────────────────────────────────────────────────────────╯
    -- ╭─────────────────────────────────────────────────────────╮
    -- │ word                                                    │
    -- ╰─────────────────────────────────────────────────────────╯
    { "<M-f>", function() require("readline").forward_word() end, mode = "!" },
    { "<M-b>", function() require("readline").backward_word() end, mode = "!" },
    { "<M-d>", function() require("readline").kill_word() end, mode = "!" },
    -- would be nice if it deleted subwords in camel-cased words
    { "<M-BS>", function() require("readline").backward_kill_word() end, mode ="!" },
    -- Easier to type and h~BS (ctrl-h=BS); also you can view it as an extension of <c-h> where it deletes more characters (view alt as a more powerful version of ctrl)
    -- { "<M-h>", function() require("readline").backward_kill_word() end, mode ={"i", "c"} },
    { "<C-w>", function() require("readline").unix_word_rubout() end, mode = "!" },
    -- TODO:https://github.com/tpope/vim-rsi/blob/45540637ead22f011e8215f1c90142e49d946a54/plugin/rsi.vim#L32C1-L48C39
    -- basically a way to still have a way to use vim insert mode mappings
    -- { "<c-t>", function()
      --   return vim.api.nvim_exec2([[
      --     let pos = getcmdpos()
      --     if getcmdtype() =~# '[?/]'
      --       echo "\<C-T>"
      --     elseif pos > strlen(getcmdline())
      --       let pre = "\<Left>"
      --       let pos -= 1
      --     elseif pos <= 1
      --       let pre = "\<Right>"
      --       let pos += 1
      --     else
      --       let pre = ""
      --     endif
      --     echo pre . "\<BS>\<Right>".matchstr(getcmdline()[0 : pos-2], '.$')
      --   ]],
      --   { output = true }).output
      -- end,  expr = true, mode = "!" },


      -- copia behaviour of vim-rsi (jceb/vimrc/patches/rsi_disable_c-e.patch)
      -- ╭─────────────────────────────────────────────────────────╮
      -- │ line                                                    │
      -- ╰─────────────────────────────────────────────────────────╯
      -- { "<C-a>", function() require("readline").beginning_of_line() end, mode = "!" },
      { "<C-e>", function() require("readline").end_of_line() end, mode = "!" },
      -- blink.cmp bug?
      { "<C-k>", function()
        -- if vim.fn.getcmdpos() > vim.fn.getcmdline():len() then
        --   return [[<c-k>]]
        -- else
          require("readline").kill_line()
        -- end
      end, mode = "!",},
      -- seems buggy (sometimes goes into normal mode)
      -- { "<C-u>", function() require("readline").backward_kill_line() end, mode = "!" },

      -- char
      { "<C-d>", "<Delete>", mode = "!" },
      -- disable for ultimate-autopair <BS>
      -- { "<C-h>", "<BS>", mode = "!" },
      -- usa lo stesso mapping di tpope (alla fine della riga apre window)
      -- https://github.com/tpope/vim-rsi/blob/45540637ead22f011e8215f1c90142e49d946a54/plugin/rsi.vim#L30
      { "<C-f>", function()
        if vim.fn.getcmdpos() > vim.fn.getcmdline():len() then
          return vim.o.cedit
        else
          return '<Right>'
        end
      end,
      mode = "!", expr = true },
      { "<C-b>", "<Left>", mode = "!" },
      { "<C-n>", "<Down>", mode = "!" },
      { "<C-p>", "<Up>", mode = "!" },

      -- extras (https://github.com/linty-org/readline.nvim/issues/2)
      -- Maybe you could use the + register in insert mode
      { mode = "!", "<C-y>", '<C-r>"' },
      -- { mode = "!", "<C-y>", "<C-r>-" },
      { mode = "i", "<C-_>", "<C-Bslash><C-o>u" },
      -- { mode = "i", "<C-/>", "<C-Bslash><C-o>u" },

      --  ╭──────────────────────────────────────────────────────────╮
      --  │                 Supported Emacs commands                 │
      --  ╰──────────────────────────────────────────────────────────╯
      -- https://www.gnu.org/software/emacs/manual/html_node/emacs/Indentation-Commands.html
      { "<M-m>", function() require("readline").back_to_indentation() end, mode = "i" },

      --  ╭──────────────────────────────────────────────────────────╮
      --  │                 Do-what-I-mean commands                  │
      --  ╰──────────────────────────────────────────────────────────╯
      { mode = "!", "<c-a>", function() require("readline").dwim_beginning_of_line() end },
      { mode = "!", "<c-u>", function() require("readline").dwim_backward_kill_line() end },
      { mode = "!", "<f12><c-s-/>", function() require("readline").dwim_backward_kill_line() end },

      -- ╭─────────────────────────────────────────────────────────╮
      -- │ Others I find :Groz:                                     │
      -- ╰─────────────────────────────────────────────────────────╯
      -- https://vimways.org/2018/the-mapping-business/
      -- i need insert mode v:count man
      -- {mode = "!","<M-.>","<C-r>=split(histget('cmd', -1))[-1]<cr>"},
      -- {mode = "i","<M-.>","<C-r>=split(getline(line('.')-1))[-1]<cr>"},
      -- {mode = "i","<M-,>","<C-r>=split(getline(line('.')+1))[-1]<cr>"}
      ---@see /tomtomjhj/dots/small.vim
      -- " readline-style cmap
      -- cnoremap <C-x><C-e> <C-f>
      -- cnoremap <expr> <C-d> getcmdpos() <= strlen(getcmdline()) ? "\<Del>" : ""
      -- " completing
      -- cnoremap <M-?> <C-d>
      -- cnoremap <M-*> <C-a>
    },
}
-- maybe also add them in insert mode?
-- inspiration from vim-rsi by tpope
-- $PS1 doesn't work sadly
-- There's nothing to delete backward at SOL
-- vim.keymap.set('t',[[<c-h>]],function() if string.match(vim.fn.getline("."),[[%$ $]]) then return [[<c-\><c-n><c-w>h]] else return "<c-h>" end end, {expr=true})
-- when using ^R (fzf) c-j (and c-k) don't work...
-- vim.keymap.set('t',[[<c-j>]],[[<c-\><c-n><C-w>j]])
-- There's nothing to delete forward at EOL
-- vim.keymap.set('t',[[<c-k>]],function() if vim.fn.col(".") - 1 == vim.fn.len(vim.fn.getline(".")) then return [[<c-\><c-n><c-w>k]] else return "<c-k>" end end, {expr=true})
-- There's nothing to clear in the first line
-- usa <c-u> se nella prima linea (if and non funge)
-- vim.keymap.set('t',[[<c-l>]],function() if vim.fn.line(".") == 3 and string.match(vim.fn.getline("."),[[%$ $]]) then return [[<c-\><c-n><c-w>l]] else return "<c-l>" end end, {expr=true})
-- vim.keymap.set('t',[[<c-l>]],function() if vim.fn.line(".") == 3 then return [[<c-\><c-n><c-w>l]] else return "<c-l>" end end, {expr=true})

-- c-s and c-r
    -- vim.keymap.set('i','<c-y>','<c-r>=')
