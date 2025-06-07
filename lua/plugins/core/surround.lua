-- ctrl-o dsb in insert mode doesn't work?
-- TODO: how to delete/replace in visual mode?
-- make dsB work w/treesitter?
-- use i or g (generic) instead of ? for arbitrary surround?
-- how to use in insert mode/emacs?

-- ds<CR> to delete surrounding empty lines? create operator to delete empty lines or whitespace-only lines...

-- 'ysiwS'  foo -> [[foo]] (how to work with double surroundings, like change/delete surrounding 2 brackets)
-- how to have jj work as enter? (input mode?)
-- how to change surrounding with count? 2cs"r or cs"2r?
-- surround with print? let b:surround_{char2nr('p')} = "System.out.println(\r)"

-- maybe use Sc, Sd and Sy in visual mode to add those missing mappings
--
-- allow count before char (yss10= doesn't work) -> https://github.com/tpope/vim-surround/pull/341
--
--  using csf in table.insert(vimwiki_dirs, path) only changes insert, maybe csF can change the whole function? also use count to target the depth (how many periods/dots)
--
--  " *cS* changes surroundings, placing the surrounded text on its own line(s) like |yS|.
--  "insert" key, denoted by `i`. It queries the user for what should go on the left and right hand sides of a selection, and adds the delimiter pair to the buffer. Currently, deletions and changes are not supported.
--
--  ds, cs don't work in visual mode (find alternative/newer/more modern mappings)
--
-- q is aliased to `,',", so csqb replaces the nearest set of quotes with parentheses

-- what about surround with snippet? doing ysss will open telescope with your snippets, the preview would show the line inside the snippet (to add loops, etc...)
return {
  -- yswT -> opens telescope with treesitter nodes that you can surround the region with
  -- ysilr doesn't seem to work?

      -- move_cursor = false, ??? like in surround.nvim
    -- is it possible to integrate with mini-ai text-objects? like using b to surrund with () (ib, ab), or c to surround with class
    -- when there are ambiguities pick the first element in the list of aliases, but what about block? what should we do?
    -- rv echasnovski/mini.surround -g \*.lua
  -- provide all mappings of vim.surround (like surround line with string in its own line)
  -- How to make the cursor not move after surrounding?
  -- Would be nice to add print function: https://github.com/kylechui/nvim-surround/discussions/53#discussioncomment-3341113
    'echasnovski/mini.surround',
    -- it makes sense that q = ", since it's harder to press than ' (you gotta use shift)
    version = false,
  -- what about yS, cS, etc...?
  -- https://github.com/search?q=++++++++++%22--+Populate+the+keys+based+on+the+user%27s+options%22&type=code&p=2
    -- how to avoid indenting when surround with S in visual mode? for backticks in markdown (indenting not necessary I think and ugly)
    keys = { "ds", "cs", "ys", "yS", { "S", mode = "x" } },
    -- keys = { { "i", "<C-g>s" }, { "i", "<C-g>S" }, { "n", "ys" }, { "n", "yS" }, { "x", "S" }, { "x", "gS" }, { "n", "cs" }, { "n", "ds" } },

    config = function()

    -- local mini_ai = require("lazy.core.config").spec.plugins["mini.ai"]
    -- how to show functions? they maybe use :match(treesitter or smth)
    -- local mini_ai_keys = require("lazy.core.plugin").values(mini_ai, "opts", false).custom_textobjects

      local ts_input = require('mini.surround').gen_spec.input.treesitter
      require("mini.surround").setup({
      -- how to change/delete in visual mode?
      mappings = {
        add = 'ys',
        delete = 'ds',
        find = '>s',
        find_left = '<s',
        -- highlight = 'vs',
        highlight = '',
        -- what about cS from vim-surround?
        replace = 'cs',
        update_n_lines = '',
      },
      -- https://github.com/echasnovski/mini.nvim/issues/150
      -- BUG: It shouldn't add a space after the brace if it's on its one line
      respect_selection_type = true,
      -- search_method = 'cover_or_nearest',
      search_method = 'cover_or_next',
      n_lines = math.huge,
      custom_surroundings = {
        -- how to use mini-ai surroundings?
        ['b'] = { input = { '%b()', '^.().*().$' },       output = { left = '(',  right = ')' } },
        ['r'] = { input = { '%b[]', '^.().*().$' },       output = { left = '[',  right = ']' } },
        ['B'] = { input = { '%b{}', '^.().*().$' },       output = { left = '{',  right = '}' } },
        ['a'] = { input = { '%b<>', '^.().*().$' },       output = { left = '<',  right = '>' } },
      -- ['*'] = {
      --   input = function()
      --     local n_star = MiniSurround.user_input('Number of * to find: ')
      --     local many_star = string.rep('%*', tonumber(n_star) or 1)
      --     return { many_star .. '().-()' .. many_star }
      --   end,
      --   output = function()
      --     local n_star = MiniSurround.user_input('Number of * to output: ')
      --     local many_star = string.rep('*', tonumber(n_star) or 1)
      --     return { left = many_star, right = many_star }
      --   end,
      -- },

        -- https://github.com/echasnovski/mini.nvim/issues/321
        -- Use `<CR>` as surrounding identifier
        ['\r'] = { output = { left = '\n', right = '\n' } },

        -- S = { output = { left = '-- stylua:ignore start\r', right = '-- stylua:ignore end\r' } },

          -- argument?
          -- A = {
          --   input = { "function%(.-%).-end", "^function%(%)%s?().-()%s?end$" },
          --   output = { left = 'function() ', right = ' end' },
          -- },

          -- would be nicer to import the letters from mini.ai...
          f = {
            input = ts_input({
              outer = "@function.outer",
              inner = "@function.inner",
            }),
          -- In attesa di treesitter-support...
            -- output = { left = 'function() ', right = '() end' },
            output = { left = 'function() ', right = ' end' },
          },

          F = {
            input = ts_input({
              outer = "@call.outer",
              inner = "@call.inner",
            }),
          output = function()
            local fun_name = MiniSurround.user_input('Function name')
            if fun_name == nil then return nil end
            return { left = ('%s('):format(fun_name), right = ')' }
          end,
          },

          o = {
            input = ts_input({
              outer = "@loop.outer",
              inner = "@loop.inner",
            }),
          },

          i = {
            input = ts_input({
              outer = "@conditional.outer",
              inner = "@conditional.inner",
            }),
          },
        --   s = {
        --     input = ts_input({
        --       outer = "@function.outer",
        --       inner = "@function.inner",
        --     }),
        --   },
        --   k = {
        --     input = ts_input({
        --       outer = "@key.outer",
        --       inner = "@key.inner",
        --     }),
        --   },
        --   v = {
        --     input = ts_input({
        --       outer = "@value.outer",
        --       inner = "@value.inner",
        --     }),
        -- },
      },
    })
      -- Remap adding surrounding to Visual mode selection
      vim.keymap.del('x', 'ys')
      -- TODO: create a snippet that surrounds the current code with 3 backticks and put the language based on the language of the code... (maybe w/ treesitter?)
      -- make this work with virtuaedit block???
      vim.keymap.set('x', 'S', [[:<C-u>lua MiniSurround.add('visual')<CR>]])

      -- Make special mapping for "add surrounding for line"
      -- vim.keymap.set('n', 'yss', 'ys_', { remap = true, desc = "Surround current line" })
    -- generally what I wanna do with yss
      -- vim.keymap.set('n', 'yss', '^ysg_', { remap = true, desc = "Surround current line" })
      -- vim.keymap.set('n', 'yss', '^ys$', { remap = true, desc = "Surround current line" })
      -- TODO: make this dot repeatable
      vim.keymap.set('n', 'yss', function() return '^'..vim.v.count1..'ys$' end, { expr = true, remap = true, desc = "Surround current line" })
    -- TODO: vim-surround behaviour
      vim.keymap.set('n', 'yS', 'ys$', { remap = true, desc = "Surround 'til end of line" })
      -- vim.keymap.set('n', 'ySS', 'V'..vim.v.count1..'S', { remap = true, desc = "Surround 'til end of line" })
      vim.keymap.set('n', 'ySS', function() return 'V'..vim.v.count1..'S' end, { expr = true, remap = true, desc = "Surround 'til end of line" })
    end
}
-- "markdown with vim-surround
-- " comes from e -> em (in html ~ italic)
-- autocmd FileType markdown,octopress let b:surround_{char2nr('e')} = "_\r_"
-- " comes from s -> strong (in html ~ bold)
-- autocmd FileType markdown,octopress let b:surround_{char2nr('s')} = "**\r**"
-- autocmd FileType markdown,octopress let b:surround_{char2nr('c')} = "```\r```"
-- " let g:surround_{char2nr('q')} = "'\r'"
-- " let g:surround_{char2nr('Q')} = "\"\r\""
-- " a -> apostrophe
-- let g:surround_{char2nr('a')} = "'\r'"
-- " q -> quotes
-- let g:surround_{char2nr('q')} = "\"\r\""
-- " k -> bacKticK
-- " let g:surround_{char2nr('k')} = "`\r`"
-- " g -> grave accent
-- let g:surround_{char2nr('g')} = "`\r`"
--

-- let g:CSApprox_verbose_level = 0
-- let g:NERDTreeHijackNetrw = 0
-- let g:netrw_dirhistmax = 0
-- let g:ragtag_global_maps = 1
-- let b:surround_{char2nr('e')} = "\r\n}"
-- let g:surround_{char2nr('-')} = "<% \r %>"
-- let g:surround_{char2nr('=')} = "<%= \r %>"
-- let g:surround_{char2nr('8')} = "/* \r */"
-- let g:surround_{char2nr('s')} = " \r"
-- let g:surround_{char2nr('^')} = "/^\r$/"
-- let g:surround_indent = 1

--emmet tag?

-- https://github.com/kylechui/nvim-surround/blob/main/doc/nvim-surround.txt
    -- insert = "<C-g>s",
    --     insert_line = "<C-g>S",
    --     normal = "ys",
    --     normal_cur = "yss",
    --     normal_line = "yS",
    --     normal_cur_line = "ySS",
    --     visual = "S",
    --     visual_line = "gS",
    --     delete = "ds",
    --     change = "cs",
    --     change_line = "cS",


-- R -> double square brackets (links, etc...) TODO
-- onoremap iR
-- onoremap aR

-- Delete spaces {Groz}
-- dsn e dsp shouldn't be necessary
-- Non usarlo per gli edge cases (casi in cui non c'è più spazio e usi ancora il mapping, quando sei su una riga vuota (una cip/dip), etc...), non funziona
-- delete previous space
-- nmap dsp ma:?..*\n^$?+;+;/./-d<cr>:norm `a<cr>:silent! nohls<cr>
-- nmap dsP ma:?..*\n^$?+;/./-d<cr>:norm `a<cr>:silent! nohls<cr>
-- delete spaces around line but one blank line surrounding it
-- nmap dss ma:?..*\n^$?+;+;/./-d<cr>:/^$/+;/./-d<cr>:norm `a<cr>:silent! nohls<cr>
-- nmap dsS ma:?..*\n^$?+;/./-d<cr>:/^$/;/./-d<cr>:norm `a<cr>:silent! nohls<cr>
-- nmap dSS ma:?..*\n^$?+;/./-d<cr>:/^$/;/./-d<cr>:norm `a<cr>:silent! nohls<cr>
-- ":norm `a<cr>
-- delete all spaces
-- nmap dSS :?..*\n^$?+;/\(^$\n\)\{-1}\ze./d<cr>:/^$/;/./-d<cr>
-- nmap dsS :?..*\n^$?+;/\(^$\n\)\{-1}\ze./d<cr>:/^$/;/./-d<cr>
-- delete next space
-- nmap dsn ma:/^$/;+;/./-d<cr>:norm `a<cr>:silent! nohls<cr>
-- nmap dsN ma:/^$/;/./-d<cr>:norm `a<cr>:silent! nohls<cr>
--
-- maybe dsw (next) and dsW (previous) like n and N?
