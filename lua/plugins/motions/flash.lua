-- maybe use <c-s> in insert mode (similar to emacs mapping)
-- kanata prefix for all these mappings?

-- fixa f and t (make them work like native)

-- how to use in telescope? (to select entry?)

-- how to disable in macros?
-- https://github.com/dpetka2001/dotfiles/blob/5f743e4b67ca7894d19d02b432fd8a43495f9d32/dot_config/nvim/lua/plugins/flash.lua#L9
return
  {
    "folke/flash.nvim",
    opts = {
      -- prioritize the ones on the left?
      -- TODO: add space?
      labels = "asdfghjkl;ewiocmz./()'-=",

      label = {
        -- you can always jump to the first match with `<CR>`
        uppercase = false,
        rainbow = {
          enabled = true,
          shade = 3,
        },
      },
      search = {
        mode = "fuzzy"
      },
      modes = {
        char = {
          enabled = false,
        }
      }
    },
    -- instead of using s, use f and t (behave like f and t [one character input] if there's that character on the current line, otherwise behave like leap)
    -- use space for keys?
    keys = {
      --   -- "/",
      --   -- perchè usare più mapping quando puoi fare tutto con uno
      --   -- mode = { "n", "x", "o" },
      -- { "<f11>", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      -- basically df
      -- { "<s-esc>", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      -- almeno questo mapping e innocuo
      -- { "<cr>", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      -- { "<c-esc>", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      -- basically pressing jfd in sequence
      -- { "<a-esc>", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      -- { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      -- s is used by vim-surround
      -- doesn't work in visual mode cause of sniprun
      -- need this for surround


      -- how to highlight all mini.ai textobjects?
      -- i want to use the text object before flash letters...
      -- would be nice to have a remote paste...
      -- would be nice to do yrlii to yank remote last if statement; if you don't specify l for last, simply highlight all the ifs with labels (also make this work with count)
      -- how to use drr to delete line? or 3drr for ex? yrr would yank remote lines, but also break yrr to yank remote square brackets (leap-spooky behaviour to mean r=ir); alternative -> use yr_
      -- useful to quickly comment out stuff...
      -- would be nice to do yriq and it highlight all text inside quotes...
      { "r", mode = { "o" }, function() require("flash").remote({ restore = true, motion = true }) end, desc = "Remote flash" },
      -- don't return back? ala vim-spooky

      -- require("flash").remote({ restore = false, motion = true })
      -- desc = "Magnetic flash"
      { "m", mode = { "o" }, function() require("flash").remote({ restore = false, motion = false }) end, desc = "Move flash" },
      --   how to use remote flash in insert mode?
      --   {
      --   "<a-r>",
      -- --   mode = { "i" }  mode = { "i" },

      --   desc = "Remote flash"
      -- },
    { "g/", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      -- use treesitter textobjects?
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Flash Treesitter Search" },

      -- diagnostic hover
      {"dK", mode = {"n"}, function()
        if vim.tbl_isempty(vim.diagnostic.get(vim.api.nvim_win_get_buf(0))) then vim.notify('No diagnostics found!') return end
        require("flash").jump({
          matcher = function(win)
            ---@param diag Diagnostic
            return vim.tbl_map(function(diag)
              return {
                pos = { diag.lnum + 1, diag.col },
                end_pos = { diag.end_lnum + 1, diag.end_col - 1 },
              }
            end, vim.diagnostic.get(vim.api.nvim_win_get_buf(win)))
          end,
          action = function(match, state)
            vim.api.nvim_win_call(match.win, function()
              vim.api.nvim_win_set_cursor(match.win, match.pos)
              vim.diagnostic.open_float()
            end)
            state:restore()
          end,
        })end,desc="Show diagnostics at target" },

      -- {
      --   "<CR>",
      --   function()
      --     require("flash").jump({ continue = true })
      --   end,
      --   mode = { "n", "x", "o" },
      -- },

      -- how to make this case insensitive? nevermind, it uses your 'ignorecase'
      -- pattern = [[\c]] .. vim.fn.expand("<cword>"),
      -- { "*", mode = { "n", "o", "x" }, function() require("flash").jump({ pattern = vim.fn.expand("<cword>"), search = { forward = true, wrap = false, multi_window = true } }) end },

      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },

      -- un po(  ridondante avere sia * che #... soprattutto se utilizzati in multi_window
      -- search = { forward = false, wrap = false, multi_window = false },
      -- Make it behave normally when there )s no other occurrence in the current window
      -- { "#", mode = { "n", "o", "x" }, function() require("flash").jump({ pattern = vim.fn.expand("<cword>"), search = { forward = false, wrap = false, multi_window = true } }) end },
      -- {
      --     -- j for jump (colemak-dh binding)
      --     -- "jd",
      --     "gd",
      --     mode = { "n" },
      --     function()
      --         -- More advanced example that also highlights diagnostics:
      --         require("flash").jump({
      --             matcher = function(win)
      --                 ---@param diag Diagnostic
      --                 return vim.tbl_map(function(diag)
      --                     return {
      --                         pos = { diag.lnum + 1, diag.col },
      --                         end_pos = { diag.end_lnum + 1, diag.end_col - 1 },
      --                     }
      --                 end, vim.diagnostic.get(vim.api.nvim_win_get_buf(win)))
      --             end,
      --             action = function(match, state)
      --                 vim.api.nvim_win_call(match.win, function()
      --                     vim.api.nvim_win_set_cursor(match.win, match.pos)
      --                     vim.diagnostic.open_float()
      --                     vim.api.nvim_win_set_cursor(match.win, state.pos)
      --                 end)
      --             end,
      --         })
      --     end
      -- }
    }
}
