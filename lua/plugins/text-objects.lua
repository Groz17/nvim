-- u don't need buffer (u can use <c-x>h)
return
  -- Better text-objects
  {
    -- use N and L to select last and first text object on line (buffer)
    "echasnovski/mini.ai",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects", cmd = {'TSTextobjectGotoPreviousStart','TSTextobjectGotoNextEnd'}, },
    --    event = "ModeChanged",
    keys = {
      { "a", mode = { "x", "o" } },
      { "i", mode = { "x", "o" } },
      -- NOTE: con g] puoi andare alla fine della funzione
      -- also add next/previous_start/end (like in tree-sitter) [maybe use g) and g(]
      -- TODO: goto_next_end??
      -- or just use [ and ]
      -- g]			Like CTRL-], but use ":tselect" instead of ":tag".
      -- kanata??????
      { "g]", mode = { "x", "o" }},
      -- { "<space>j", mode = { "n", "x", "o" }},
      { "g[", mode = { "x", "o" }},
      -- { "<space>k", mode = { "n", "x", "o" }},
    },
    opts = function()
      local extra_ai = require('mini.extra').gen_ai_spec
      local ai = require("mini.ai").gen_spec
      return {


        mappings = {
          goto_left = 'g[',
          goto_right = 'g]',
        },
        -- n_lines = 700,
        n_lines = math.huge,
        -- how to make this work like targets? current -> next in line -> previous in line -> next in successive lines -> previous in successive lines
        -- search_method = 'cover_or_nearest',
        -- would be nice if it went forward only for the visibile screen, otherwise backward
        search_method = 'cover_or_next',
        custom_textobjects = {
          t = false,
          -----------------------------------------------------------
          -- treesitter text objects
          -----------------------------------------------------------
          -- if treesitter is not available in the current buffer use a vim-regexes-based fallback

          -- https://github.com/echasnovski/mini.nvim/issues/192
          -- how to get those mappings from treesitter spec? instead of rewriting them...
          -- You can use the capture groups defined in textobjects.scm



          -- ╭───────────────────────────────────────────────────────────╮
          -- │                        Assignment                         │
          -- ╰───────────────────────────────────────────────────────────╯
          -- e = equal
          -- gl = ai.gen_spec.treesitter({ a = "@assignment.outer", i = "@assignment.inner" }, {}),
          e = ai.treesitter({ a = "@assignment.outer", i = "@assignment.inner" }, {}),
          -- would be cool if this worked everywhere (random file with a=b, like logs...) (fallback mechanism)
          -- uso per vim-swap text objects
          -- ["gh"] = "@assignment.lhs",

          -- maybe use gL and gR to include whitespace or other surroundings?
          -- sembra ridondante? basta usare vie or vile...
          -- g = ai.gen_spec.treesitter({ l = { "@assignment.lhs" }, r = { "@assignment.rhs" }, }, {}),

          -- key (from key value pair) merge these w/ assignment?
          -- FIX: doesn't work
          k = ai.treesitter({
            i = { "@key.inner", "@assignment.lhs" },
            a = { "@key.outer", "@assignment.lhs" },
          }),
          v = ai.treesitter({
            i = { "@value.inner", "@assignment.rhs" },
            a = { "@value.outer", "@assignment.rhs" },
          }),
          -- ╭───────────────────────────────────────────────────────────╮
          -- │                         Attribute                         │
          -- ╰───────────────────────────────────────────────────────────╯
          x = ai.treesitter({ a = "@attribute.outer", i = "@attribute.inner" }, {}),
          -- ╭───────────────────────────────────────────────────────────╮
          -- │                           Block                           │
          -- ╰───────────────────────────────────────────────────────────╯
          -- K = ai.gen_spec.treesitter({ a = { "@block.outer" }, i = { "@block.inner" }, }, {}),
          -- k = ai.gen_spec.treesitter({ a = { "@block.outer" }, i = { "@block.inner" }, }, {}),

          -- ╭───────────────────────────────────────────────────────────╮
          -- │                           Call                            │
          -- ╰───────────────────────────────────────────────────────────╯
          -- invocation
          -- i = ai.gen_spec.treesitter({ a = { "@call.outer"}, i = { "@call.inner"}, }, {}),
          -- -- y -> yell
          -- ["iy"] = "@call.inner",
          -- ["ay"] = "@call.outer",
          -- ['aj'] = '@call.outer',
          -- uppercase versions need to be related, like w and W
          F = ai.treesitter({ a = { "@call.outer" }, i = { "@call.inner" }, }, {}),

          -- j = ai.gen_spec.treesitter({ a = { "@call.outer" }, i = { "@call.inner" }, }, {}),
          -- m = ai.gen_spec.treesitter({ a = { "@call.outer" }, i = { "@call.inner" }, }, {}),

          -- u = ai.function_call(), -- u for "Usage"
          -- U = ai.function_call({ name_pattern = "[%w_]" }), -- without dot in function name

          -- ╭───────────────────────────────────────────────────────────╮
          -- │                           Class                           │
          -- ╰───────────────────────────────────────────────────────────╯
          -- Come fare per limitare queste mapping solo ai linguaggi OOP? [dove esistono le classi I guess]
          -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects/issues/65
          -- ['im'] = '@class.inner', -- m as in "(M)odule"
          -- S=double s
          S = ai.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
          -- You can optionally set descriptions to the mappings (used in the desc parameter of nvim_buf_set_keymap) which plugins like which-key display
          -- ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
          -- ╭───────────────────────────────────────────────────────────╮
          -- │                          Comment                          │
          -- ╰───────────────────────────────────────────────────────────╯
          -- g perché vim-commentary inizia con g
          -- non va bene perché g è il text object di gitgutter
          -- ["ag"] = "@comment.outer",
          -- ["acm"] = "@comment.outer",
          -- ["am"] = "@comment.outer",
          --               ['sc'] = '@comment.outer',
          -- gc come per commentary
          -- ["agc"] = "@comment.outer",
          -- ["ac"] = "@comment.outer",
          -- u seems nice
          -- ["iu"] = "@comment.inner",
          -- ["au"] = "@comment.outer",
          -- ag?
          c = ai.treesitter({ a = "@comment.outer", i = "@comment.inner" }, {}),
          -- group of subquent lines of comments?
          -- C = ai.treesitter({ a = "@comment.outer", i = "@comment.inner" }, {}),
          -- gc = ai.gen_spec.treesitter({ a = "@comment.outer", i = "@comment.inner" }, {}),
          -- ["|"] = ai.gen_spec.treesitter({ a = { "@pipe.outer", "@command.outer" }, i = { "@pipe.inner", "@command.inner" }, }, {}),

          -- ╭───────────────────────────────────────────────────────────╮
          -- │                        Conditional                        │
          -- ╰───────────────────────────────────────────────────────────╯
          -- block/conditional... (find better name)
          -- ["id"] = "@conditional.inner",
          -- ["ad"] = "@conditional.outer",
          -- i -> if then (conditional)
          -- indentation?
          -- can you use dsi to remove surrounding if?
          -- doesn't work w/ case in Bash...
          i = ai.treesitter({ a = { "@conditional.outer" }, i = { "@conditional.inner" }, }, {}),
          -- a judge
          -- j = ai.gen_spec.treesitter({ a = { "@conditional.outer" }, i = { "@conditional.inner" }, }, {}),
          -- ╭───────────────────────────────────────────────────────────╮
          -- │                           Frame                           │
          -- ╰───────────────────────────────────────────────────────────╯
          -- -- m -> modulo
           -- For LaTeX frames
          -- m = ai.gen_spec.treesitter({ a = { "@frame.outer" }, i = { "@frame.inner" }, }, {}),
          -- F = ai.gen_spec.treesitter({ a = "@frame.outer", i = "@frame.inner" }, {}),
          -- ╭───────────────────────────────────────────────────────────╮
          -- │                         Function                          │
          -- ╰───────────────────────────────────────────────────────────╯
          -- Functions
          -- textobj_treesitter,
          -- not sure it should delete the braces, same for class (Java at least)
          f = ai.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),

          -- ╭───────────────────────────────────────────────────────────╮
          -- │                           Loop                            │
          -- ╰───────────────────────────────────────────────────────────╯
          -- o -> loop cause it's like a circle (double o's in loop)
          -- backspace e interessante as well
          o = ai.treesitter({ a = { "@loop.outer" }, i = { "@loop.inner" }, }, {}),
          -- ╭───────────────────────────────────────────────────────────╮
          -- │                          Number                           │
          -- ╰───────────────────────────────────────────────────────────╯
          -- ["i#"] = "@number.inner",
          -- ["iN"] = "@number.inner",
          --  outer number factors in decimal points and includes minus sign
          -- ["#"] = ai.gen_spec.treesitter({ a = "@number.inner", i = "@number.inner" }, {}),
          -- d for digit?
          -- d = ai.gen_spec.treesitter({ a = "@number.inner", i = "@number.inner" }, {}),
          N = ai.treesitter({ a = "@number.inner", i = "@number.inner" }, {}),
          -- ╭───────────────────────────────────────────────────────────╮
          -- │                         Parameter                         │
          -- ╰───────────────────────────────────────────────────────────╯
          -- k è simile a < :)) ; aspettiamo l'integrazione targets-treesitter...
          -- ["ia"] = "@parameter.inner",
          -- ["aa"] = "@parameter.outer",
          -- no mnemonic, but feels nice to type
          -- fallback to regular when no treesitter, for the moment use uppercase version
          -- how to ignore comments?
          -- J = ai.gen_spec.treesitter({ a = "@parameter.outer", i = "@parameter.inner" }, {}),
          -- P = ai.treesitter({ a = "@parameter.outer", i = "@parameter.inner" }, {}),
          m = ai.treesitter({ a = "@parameter.outer", i = "@parameter.inner" }, {}),
          -- ╭───────────────────────────────────────────────────────────╮
          -- │                           Regex                           │
          -- ╰───────────────────────────────────────────────────────────╯
          R = ai.treesitter({ a = "@regex.outer", i = "@regex.inner" }, {}),
          -- ╭───────────────────────────────────────────────────────────╮
          -- │                          Return                           │
          -- ╰───────────────────────────────────────────────────────────╯
          -- <CR>: return (`ar` already = a rectangular bracket)
          -- sembra non funzionare...
          -- ["<CR>"] = ai.gen_spec.treesitter({ a = "@return.outer", i = "@return.inner" }, {}),
          -- use w/ katana
          ['\r'] = ai.treesitter({ a = "@return.outer", i = "@return.inner" }, {}),
          -- c-j -> newline -> like cr in unix
          -- ["<c-j>"] = ai.gen_spec.treesitter({ a = "@return.outer", i = "@return.inner" }, {}),
          -- j = ai.treesitter({ a = "@return.outer", i = "@return.inner" }, {}),
          -- ╭───────────────────────────────────────────────────────────╮
          -- │                         Scopename                         │
          -- ╰───────────────────────────────────────────────────────────╯
          -- ['h'] = ai.treesitter({ a = "@scopename.inner", i = "@scopename.inner" }, {}),

          -- ╭───────────────────────────────────────────────────────────╮
          -- │                         Statement                         │
          -- ╰───────────────────────────────────────────────────────────╯
          -- x -> eXecute
          -- ["ax"] = "@statement.outer",
          -- S = ai.gen_spec.treesitter({ a = { "@statement.outer" }, i = { "@statement.inner" }, }, {}),
          X = ai.treesitter({ a = { "@statement.outer" }, i = { "@statement.inner" }, }, {}),


          -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects/issues/439
          -- ["ad"] = {
          --   desc = "Select around an entire docstring",
          --   query = "@string.documentation",
          --   query_group = "highlights",
          -- },
          -- D = ai.treesitter({ a = "@string.documentation", i = "@string.documentation" }, {}),
          C = ai.treesitter({ a = "@string.documentation", i = "@string.documentation" }, {}),
          -- h = ai.treesitter({ a = "@string.documentation", i = "@string.documentation" }, {}),









          -----------------------------------------------------------
          -- filetype-specific text objects
          -----------------------------------------------------------
          -- markdown
          -- ["ili"] = "@list_item.inner",
          -- ["ali"] = "@list_item.outer",
          -- ["icb"] = "@code_block.inner",
          -- ["acb"] = "@code_block.outer",
          -- ["itc"] = "@table_cell.inner",
          -- @attribute.inner
          -- @attribute.outer

          -----------------------------------------------------------
          -- additional text objects
          -----------------------------------------------------------
          --sbircia qui https://github.com/search?q=%20%20custom_textobjects%20&type=repositories
          -- fallback to this when treesitter ain't available?
          -- ['j'] = ai.gen_spec.argument(),
          -- ['P'] = ai.gen_spec.argument(),
          -- a = require("mini.ai").gen_spec.argument { separator = "[,;]" },
          -- A = ai.gen_spec.argument { brackets = { '%b()', '%b[]', '%b{}' }, separators = { ',',';' }, exclude_regions = { '%b""', "%b''", '%b()', '%b[]', '%b{}' }},
          -- A = ai.argument({ brackets = { '%b()', '%b[]', '%b{}' }, separator = '[;,:]' }),
          -- non usare separatori (per bash)
          -- m = ai.argument({}),
          I = extra_ai.indent(),
          ['\t'] = extra_ai.indent(),
          -- ["<space>"] = extra_ai.indent(),
          -- G = extra_ai.buffer(),
          -- BUG: doesn't work
          -- ["<space>"] = extra_ai.buffer(),
          -- does work ;D
          [" "] = extra_ai.buffer(),
          -- y = extra_ai.buffer(),

          -- https://github.com/echasnovski/mini.nvim/issues/6

          -- https://github.com/echasnovski/mini.nvim/issues/151
          -- x = { '%f[%s]%s+[^%s<>=]+=[^%s<>]+', '^%s+().*()$' },
          -- slightly differente from iv and av in the sense that it jumps
          V = { { '%f[%w]()%w+()_', '%f[%u]()()%w*[%l%d]()()%u' } },
          -- ["s"] = { "%f[%w]%w+", "^().*()$" }, -- like `w`, except underbar

          -- define swap operator so you can swap words around and other textobjects
          --https://github.com/echasnovski/mini.nvim/issues/387
          -- <Cmd>normal cxiacxila<CR> to move argument to the left.
          -- <Cmd>normal cxiacxina<CR> to move argument to the right.

          -- Word with camel case (https://github.com/lkhphuc/dotfiles/blob/474e122f68d3df7ac4c5990246062e47a272fd15/nvim/lua/plugins/coding.lua#L5)
          -- junction (from https://www.youtube.com/watch?v=JnD9Uro_oqc)
          -- crea J per l'opposto (tipo per catturare abd-def)
          -- difference between aj and ij? make it so aj targets the eventual separator as well
          -- J for symbols? like doom emacs
          j = {
            {
              "%u[%l%d]+%f[^%l%d]",
              "%f[%S][%l%d]+%f[^%l%d]",
              "%f[%P][%l%d]+%f[^%l%d]",
              "^[%l%d]+%f[^%l%d]",
            },
            "^().*()$",
          },


          -- TODO: how many numbers
          -- N = gen_ai_spec.number(),
          -- D = require('mini.extra').gen_ai_spec.diagnostic(vim.v.count),
          -- D = extra_ai.diagnostic(),
          d = extra_ai.diagnostic(),
          -- -- treesitter-unit
          -- u = function(type)
          --   local node = vim.treesitter.get_node()
          --   if node == nil then
          --     return node
          --   end
          --   if type == 'a' then
          --     local parent = node:parent()
          --     local start = node:start()
          --     local end_ = node:end_()
          --     while parent ~= nil and parent:start() == start and parent:end_() == end_ do
          --       node = parent
          --       parent = node:parent()
          --     end
          --   end
          --   local from_line, from_col, to_line, to_col = node:range()
          --   return {
          --     from = { line = from_line + 1, col = from_col + 1 },
          --     to = { line = to_line + 1, col = to_col },
          --   }
          -- end,
          -- -- textobj-line
          --   l = function(type)
          --     if vim.api.nvim_get_current_line() == '' then
          --       return
          --     end
          --     vim.cmd.normal({ type == 'i' and '^' or '0', bang = true })
          --     local from_line, from_col = unpack(vim.api.nvim_win_get_cursor(0))
          --     local from = { line = from_line, col = from_col + 1 }
          --     vim.cmd.normal({ type == 'i' and 'g_' or '$', bang = true })
          --     local to_line, to_col = unpack(vim.api.nvim_win_get_cursor(0))
          --     local to = { line = to_line, col = to_col + 1 }
          --     return { from = from, to = to }
          --   end,

          -- ['L'] = function(type)
          --   if vim.api.nvim_get_current_line() == '' then
          --     return
          --   end
          --   vim.cmd.normal({ type == 'i' and '^' or '0', bang = true })
          --   local from_line, from_col = unpack(vim.api.nvim_win_get_cursor(0))
          --   local from = { line = from_line, col = from_col + 1 }
          --   vim.cmd.normal({ type == 'i' and 'g_' or '$', bang = true })
          --   local to_line, to_col = unpack(vim.api.nvim_win_get_cursor(0))
          --   local to = { line = to_line, col = to_col + 1 }
          --   return { from = from, to = to }
          -- end,
          -- ignore, use gG and gW
          -- Whole buffer
          -- g = function(ai_type)
          -- -- e = function(ai_type)
          --   local n_lines = vim.fn.line("$")
          --   local start_line, end_line = 1, n_lines
          --   if ai_type == "i" then
          --     local first_nonblank, last_nonblank = vim.fn.nextnonblank(1), vim.fn.prevnonblank(n_lines)
          --     start_line = first_nonblank == 0 and 1 or first_nonblank
          --     end_line = last_nonblank == 0 and n_lines or last_nonblank
          --   end
          --
          --   local to_col = math.max(vim.fn.getline(end_line):len(), 1)
          --   return { from = { line = start_line, col = 1 }, to = { line = end_line, col = to_col } }
          -- end,


          -- -- https://github.com/IndianBoy42/dot.nvim/blob/89d6d6e70fd9869c36fe4633f69345bd9dbcbe94/lua/editor/nav.lua#L106
          -- C = function(ai_type)
          --   local line_num = vim.fn.line "."
          --   local first_line = 1
          --   local last_line = vim.fn.line "$"
          --   local line = vim.fn.getline(line_num)
          --   local cond = function(l)
          --     if l:len() > 3 then
          --       if l:sub(1, 4) == "# %%" then return true end
          --     end
          --     return false
          --   end
          --   local found_up = true
          --
          --   -- Find first line in cell
          --   while not cond(line) do
          --     line_num = line_num - 1
          --     line = vim.fn.getline(line_num)
          --     if line_num == 1 then
          --       found_up = false
          --       break
          --     end
          --   end
          --
          --   if not found_up then
          --     local cur_pos = vim.api.nvim_win_get_cursor(0)
          --     return {
          --       from = { line = cur_pos[1], col = cur_pos[2] + 1 },
          --     }
          --   end
          --
          --   -- If inside, not include cell delimiter
          --   if ai_type == "i" then
          --     first_line = line_num + 1
          --   else
          --     first_line = line_num
          --   end
          --
          --   -- Find last line in cell
          --   line_num = vim.fn.line "."
          --   line = vim.fn.getline(line_num)
          --   local found_down = true
          --   while not cond(line) do
          --     if line_num == last_line then
          --       found_down = false
          --       break
          --     end
          --     line_num = line_num + 1
          --     line = vim.fn.getline(line_num)
          --   end
          --   local last_col = line:len()
          --   if found_down then
          --     last_line = line_num - 1
          --     line = vim.fn.getline(last_line)
          --     last_col = math.max(line:len(), 1)
          --   else
          --     last_col = math.max(last_col, 1)
          --   end
          --   return { from = { line = first_line, col = 1 }, to = { line = last_line, col = last_col } }
          -- end,

          -----------------------------------------------------------
          -- native text objects
          -----------------------------------------------------------
          -- b = ai.gen_spec.argument { brackets = { "%b()", "^.%s*().-()%s*.$" } },
          -- B = ai.gen_spec.argument { brackets = { "%b{}", "^.%s*().-()%s*.$" } },
          -- r = ai.gen_spec.argument { brackets = { "%b[]", "^.%s*().-()%s*.$" } },

          -- https://github.com/huwqchn/.dotfiles/blob/075b7421c730b88811bc2fc87fdc3bb4141ae288/nvim/.config/nvim/lua/plugins/extras/coding/text-objects/mini-ai.lua#L65
          -- 50dinw should delete the next 50 words (dinw followed by 49. should do the same) while d50innw should delete the 50th word from the cursor
          w = { "()()%f[%w_][%w_]+()[ \t]*()" },
          -- WORD
          W = { { "()()%f[%w%p][%w%p]+()[ \t]*()", } },

          -- b = false,
          a = ai.pair("<", ">", { type = "balanced" }),
          b = ai.pair("(", ")", { type = "balanced" }),
          r = ai.pair("[", "]", { type = "balanced" }),
          -- t = { '<([%p%w]-)%f[^<%w][^<>]->.-</%1>', '^<.->().*()</[^/]->$' },

        },
      }
    end,
  }

