-- would be cool to align based on indentation/scope like after { in Lua for ex (align = by level in assignment)
-- would be nice if for example when aligning with comma it was smart and for example ignored those inside parenthesis (separating arguments) (treesitter?)

-- how to enter interactive mode after pressing ga?
-- - Filtering by last equal sign usually can be done with `n >= (N - 1)` (because there is usually something to the right of it). (find better UX)

-- https://github.com/search?q=path%3Amini-align.lua&type=code

-- use S to split by vim regex (uppercase because vim regex is more powerful?)
-- how to insert expression in split/merge, for example to insert 30 spaces you could use repeat?

-- would be nice to filter by treesitter/AST expression, like align only assignments
-- in interactive mode, show possible mappings with which-key...
return {
  {
    -- how to insert multiple split patterns without exiting interactive mode?
    -- not being able to use vim regex is a deal-breaker sadly (add PR...) (vim.regex module?)
    -- how to merge only left or right?
    'nvim-mini/mini.align',
    cond = false,
    -- enabled = true,
    version = '*',
    opts = {
      mappings = {
        start = 'gl',
        start_with_preview = 'gL',
      },
    },

    keys = {
      -- { "ga", mode = { "x", "n" }, desc = "Align" },
      -- { "gA", mode = { "x", "n" }, desc = "Align with preview" },
      -- use g| to align (w/ kanata symbol layer)
      { 'gl', mode = { 'x', 'n' }, desc = 'Align' },
      { 'gL', mode = { 'x', 'n' }, desc = 'Align with preview' },
    },
    -- come delimiters usa stessi di mini.ai? anche per surround
  },

  {
    -- how to align ranges? can mini.align?
    -- maybe use hydra.nvim for this type of plugin?
    'junegunn/vim-easy-align',
    -- sadly it doesn't store the command or the regex pattern in history (FIX)

    -- In live interactive mode, you have to type in the same delimiter (or CTRL-X on regular expression) again to finalize the alignment. This allows you to preview the result of the alignment and freely change the delimiter using backspace key without leaving the interactive mode.
    -- add mapping like <s-cr> that in interactive execute the current alignment configuration/status but doesn't exit the mode
    -- it would be cool if it had default text objects/elements like arguments to center align them, ect...
    -- would be cool to have a similar plugin that worked for tables...
    enabled = true,
    pin = true,
    -- cond = false,

    -- https://github.com/junegunn/vim-easy-align/search?q=arrow+key
    -- https://github.com/junegunn/vim-easy-align/pull/138/files (aggiunto <c-s> al posti di <right>)

    init = function()
      -- would be cool if this used treesitter (don't think this works sadly)
      vim.g.easy_align_ignore_groups = { 'Comment' }

      -- b, B e r come surround, differenziando open and closed parenthesis [fai interagire i plugin surround, text-obj, targets e easy-align]
      -- d (definition) -> Aligning C-style variable definition
      -- s -> aSterisk (or Star) [a starebbe per argument]
      vim.g.easy_align_delimiters = {
        ['+'] = { pattern = [[+]] },
        ['-'] = { pattern = [[-]] },
        ['s'] = { pattern = [[*]] },
        ['>'] = { pattern = [[>>\|=>\|>]] },
        ['<'] = { pattern = [[<<\|=<\|<]] },
        ['k'] = { pattern = [[>>\|=>\|>\|<<\|=<\|<]] },
        ['/'] = {
          pattern = [[//\+\|/\*\|\*/]],
          delimiter_align = 'l',
          ignore_groups = { '!Comment' },
        },
        ['['] = {
          pattern = [=[[[\]]]=],
          left_margin = 1,
          right_margin = 1,
          stick_to_left = 0,
        },
        [']'] = {
          pattern = [=[[[\]]]=],
          left_margin = 0,
          right_margin = 0,
          stick_to_left = 0,
        },
        ['r'] = {
          pattern = [=[[[\]]]=],
          left_margin = 0,
          right_margin = 0,
          stick_to_left = 0,
        },
        ['('] = {
          pattern = [=[[()]]=],
          left_margin = 1,
          right_margin = 0,
          stick_to_left = 0,
        },
        [')'] = {
          pattern = [=[[()]]=],
          left_margin = 0,
          right_margin = 0,
          stick_to_left = 0,
        },
        ['b'] = {
          pattern = [=[[()]]=],
          left_margin = 1,
          right_margin = 0,
          stick_to_left = 0,
        },
        ['B'] = {
          pattern = [=[[{}]]=],
          left_margin = 1,
          right_margin = 0,
          stick_to_left = 0,
        },
        ['d'] = {
          pattern = [[ \(\S\+\s*[;=]\)\@=]],
          left_margin = 0,
          right_margin = 0,
        },
      }
    end,

    keys = {
      -- xnoremap <leader><leader> <plug>(EasyAlign)
      -- nnoremap <leader><leader> <plug>(EasyAlign)
      --
      -- https://thoughtbot.com/blog/align-github-flavored-markdown-tables-in-vim
      -- Align GitHub-flavored Markdown tables
      -- au FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>
      -- { mode = 'x', '<Leader><Bslash>', [[:EasyAlign*<Bar><Enter>]] },

      -- -- use <c-s> instead of <left> or <right> for stick to left, at arrow keys...
      { mode = 'n', 'gl',               '<Plug>(EasyAlign)',         { noremap = false } },
      { mode = 'n', 'gll',              'gl_',                       { noremap = false } },
      { mode = 'x', 'gl',               '<Plug>(EasyAlign)',         { noremap = false } },
      -- { mode = 'v', '<Enter>',          '<Plug>(EasyAlign)',         { noremap = false } },
      { mode = 'n', 'gL',               '<Plug>(LiveEasyAlign)',     { noremap = false } },
      { mode = 'n', 'gLL',              'gL_',                       { noremap = false } },
      { mode = 'x', 'gL',               '<Plug>(LiveEasyAlign)',     { noremap = false } },

      -- { mode = { 'n', 'x' }, 'gl', '<Plug>(EasyAlign)' },
      -- { mode = { 'n', 'x' }, 'gL', '<Plug>(LiveEasyAlign)' },
    },
  },

  -- how to center align the modes heres inside braces? I tried /{\zs"[^}]*\ze}/ then center align but it doesn't work
  -- { mode = {"n","x","o"  },"]d", "<Plug>(textobj-diff-file-n)", desc = "Move to the beginning of the next header of files"         },
  -- { mode = {"n","x","o"  },"[d", "<Plug>(textobj-diff-file-p)", desc = "Move to the beginning of the previous header of files"     },
  -- { mode = {"n","x","o"  },"]D", "<Plug>(textobj-diff-file-N)", desc = "Move to the end of the next header of files"               },
  -- { mode = {"n","x","o"  },"[D", "<Plug>(textobj-diff-file-P)", desc = "Move to the end of the previous header of files"           },
  -- { mode = {"n","x","o"  },"]h", "<Plug>(textobj-diff-hunk-n)", desc = "Move to the beginning of the next hunk"                    },
  -- { mode = {"n","x","o"  },"[h", "<Plug>(textobj-diff-hunk-p)", desc = "Move to the beginning of the previous hunk"                },
  -- { mode = {"n","x","o"  },"]H", "<Plug>(textobj-diff-hunk-N)", desc = "Move to the end of the next hunk"                          },
  -- { mode = {"n","x","o"  },"[H", "<Plug>(textobj-diff-hunk-P)", desc = "Move to the end of the previous hunk"                      },
  -- { mode=  {"x","o"      },"ah", "<Plug>(textobj-diff-file)",   desc = "Select all hunks and the header of the next/previous files"},
  -- { mode=  {"x","o"      },"ih", "<Plug>(textobj-diff-hunk)",   desc = "Select the next/previous hunk"                             },
}
