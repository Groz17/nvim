-- select unique by regex or <c-n>?
-- https://zed.dev/docs/multibuffers
-- support all of this:https://github.com/mg979/vim-visual-multi (and other multicursors plugins (vim/neovim))

-- For inspiration for mappings: https://github.com/terryma/vim-multiple-cursors and https://github.com/mg979/vim-visual-multi
-- https://github.com/smoka7/multicursors.nvim/issues/16
-- use visual mode instead of extend?
-- how to use jj for accepting pattern?
-- integra flash qui?
-- return {
--   -- would be great if it ignored comments
--   'jake-stewart/multicursor.nvim',
--   branch = '1.0',
--   keys = {
--
--     -- Add or skip cursor above/below the main cursor.
--     -- magari just <c-.> or smth (. means current line) and <c-j> and <c-k> to go up and down?
--     -- {mode={"n", "x"}, "<up>", function() require("multicursor-nvim").lineAddCursor(-1) end},
--     -- {mode={"n", "x"}, "<down>", function() require("multicursor-nvim").lineAddCursor(1) end},
--     -- {mode={"n", "x"}, "<leader><up>", function() require("multicursor-nvim").lineSkipCursor(-1) end},
--     -- {mode={"n", "x"}, "<leader><down>", function() require("multicursor-nvim").lineSkipCursor(1) end},
--
--     -- Add or skip adding a new cursor by matching word/selection
--     -- <word> and <Cword>?
--     -- add operator as in substitute.nvim?
--     {mode={"n", "x"}, "<c-n>", function() require("multicursor-nvim").matchAddCursor(1) end},
--     -- {mode={"n", "x"}, "<c-s>", function() require("multicursor-nvim").matchSkipCursor(1) end},
--     -- {mode={"n", "x"}, "<c-s-n>", function() require("multicursor-nvim").matchAddCursor(-1) end},
--     -- {mode={"n", "x"}, "<c-s-s>", function() require("multicursor-nvim").matchSkipCursor(-1) end},
--
--     -- Add all matches in the document
--     -- maybe add before and after cursor? could use narrow plugin here
--     {mode={"n", "x"}, "<a-n>", function() require("multicursor-nvim").matchAllAddCursors() end},
--
--     -- Add and remove cursors with control + left click.
--     { '<c-leftmouse>', function() require('multicursor-nvim').handleMouse() end },
--
--     -- Split visual selections by regex.
--     -- TODO: support *search-offset* *{offset}*
--     {mode='x', '<c-s>', function() require('multicursor-nvim').splitCursors() end},
--
--     -- match new cursors within visual selections by regex.
--     -- FIX: doesn't work with $ input
--     {mode='x', '<c-r>', function() require('multicursor-nvim').matchCursors() end},
--
--
--         -- You can also add cursors with any motion you prefer: (TODO: create operator?)
--
--   },
--   config = function()
--     local mc = require('multicursor-nvim')
--
--     mc.setup()
--
--     -- Rotate the main cursor.
--     vim.keymap.set({ 'n', 'x' }, '<left>', mc.nextCursor)
--     vim.keymap.set({ 'n', 'x' }, '<right>', mc.prevCursor)
--
--     -- Delete the main cursor.
--     vim.keymap.set({ 'n', 'x' }, '<leader>x', mc.deleteCursor)
--
--     vim.keymap.set({ 'n', 'x' }, '<c-q>', function()
--       if mc.cursorsEnabled() then
--         -- Stop other cursors from moving.
--         -- This allows you to reposition the main cursor.
--         mc.disableCursors()
--       else
--         mc.addCursor()
--       end
--     end)
--
--     vim.keymap.set('n', '<esc>', function()
--       if not mc.cursorsEnabled() then
--         mc.enableCursors()
--       elseif mc.hasCursors() then
--         mc.clearCursors()
--       else
--         -- Default <esc> handler.
--       end
--     end)
--
--     -- Align cursor columns.
--     vim.keymap.set('n', '<leader>a', mc.alignCursors)
--
--     -- Append/insert for each line of visual selections.
--     vim.keymap.set('x', 'I', mc.insertVisual)
--     vim.keymap.set('x', 'A', mc.appendVisual)
--
--     -- Rotate visual selection contents.
--     vim.keymap.set('x', '<leader>t', function() mc.transposeCursors(1) end)
--     vim.keymap.set('x', '<leader>T', function() mc.transposeCursors(-1) end)
--
--     -- Customize how cursors look.
--     vim.api.nvim_set_hl(0, 'MultiCursorCursor', { link = 'Cursor' })
--     vim.api.nvim_set_hl(0, 'MultiCursorVisual', { link = 'Visual' })
--     vim.api.nvim_set_hl(0, 'MultiCursorDisabledCursor', { link = 'Visual' })
--     vim.api.nvim_set_hl(0, 'MultiCursorDisabledVisual', { link = 'Visual' })
--   end,
-- }
-- --
-- -- {mode={"n", "x"}, "<left>", require("multicursor-nvim").nextCursor},
-- -- {mode={"n", "x"}, "<right>", require("multicursor-nvim").prevCursor},
-- --
-- --         -- Delete the main cursor.
-- -- {mode={"n", "x"}, "<leader>x", require("multicursor-nvim").deleteCursor},
-- --
-- --         -- Add and remove cursors with control + left click.
-- -- { "<c-leftmouse>", require("multicursor-nvim").handleMouse},
-- --
-- --         -- Easy way to add and remove cursors using the main cursor.
-- -- {mode={"n", "x"}, "<c-q>", require("multicursor-nvim").toggleCursor},
-- --
-- --         -- Clone every cursor and disable the originals.
-- -- {mode={"n", "x"}, "<leader><c-q>", require("multicursor-nvim").duplicateCursors},
-- --
-- --         -- bring back cursors if you accidentally clear them
-- -- { "<leader>gv", require("multicursor-nvim").restoreCursors},
-- --
-- --         -- Align cursor columns.
-- -- {mode="x", "<leader>a", require("multicursor-nvim").alignCursors},
-- --
-- --         -- Split visual selections by regex.
-- -- {mode="x", "S", require("multicursor-nvim").splitCursors},
-- --
-- --         -- Append/insert for each line of visual selections.
-- -- {mode="x", "I", require("multicursor-nvim").insertVisual},
-- -- {mode="x", "A", require("multicursor-nvim").appendVisual},
-- --
-- --         -- Rotate visual selection contents.
-- -- {mode="x", "<leader>t", function() require("multicursor-nvim").transposeCursors(1) end},
-- -- {mode="x", "<leader>T", function() require("multicursor-nvim").transposeCursors(-1) end},

return {
  'jake-stewart/multicursor.nvim',
  branch = '1.0',
  keys = function()

local mc=require('multicursor-nvim')
    return{


    -- Add or skip adding a new cursor by matching word/selection
    -- TODO: should support v:count
    -- how to ignore case?
    -- u can use C-j,k now If kanata window mapping
    {mode={ 'n', 'x' }, '<c-n>', function() mc.matchAddCursor(1) end},
    -- {mode={ 'n', 'x' }, '<c-s-n>', function() mc.matchSkipCursor(1) end},
    -- {mode={ 'n', 'x' }, '<c-s>', function() mc.matchAddCursor(-1) end},
    -- {mode={ 'n', 'x' }, '<c-s-s>', function() mc.matchSkipCursor(-1) end},
    -- match new cursors within visual selections by regex.
    -- ghostty?
    {mode='x', '<c-m>', function() mc.matchCursors() end},
    -- Split visual selections by regex.
    -- utile con dial ad esempio per incrementare numeri
    -- BUG: it shoudn't enter in visual mode right?
    -- does it work in normal mode? treesitter?
    {mode='x', '<c-s>', function() mc.splitCursors()end} ,
    -- define unifying interface using text-objects mapping, so you don't have to define all these mappings...
-- {mode={"n", "x"}, "me", function() mc.diagnosticMatchCursors({ severity = vim.diagnostic.severity.ERROR }) end},
-- {mode={"n", "x"}, "me", function() mc.diagnosticMatchCursors({}) end},

    -- Add all matches in the document
    -- {mode={ 'n', 'x' }, '<a-n>', function() mc.matchAllAddCursors() end},
    -- use a-n for cWORD
    -- {mode={ 'n', 'x' }, '<a-a>', function() mc.matchAllAddCursors() end},
    {mode={ 'n', 'x' }, '<a-n>', function() mc.matchAllAddCursors() end},
    -- ctrl-%
    --This plays very nice with flash treesitter label：
    -- {mode={ 'x', 'n' }, "<c-s-5>", function() mc.operator() end},
  }end,
  config = function()
    -- TODO: mc.swapCursors(direction)                            *multicursor-swapCursors*
    require('multicursor-nvim').setup()

    -- TODO: add hydra activate w/ (*multicursor-selecting-cursors*) + split & match
    -- Add or skip cursor above/below the main cursor.
    -- alt->add, shift->skip
    -- vim.keymap.set({ 'n', 'x' }, '<c-a-j>', function() require('multicursor-nvim').lineAddCursor(1) end)
    -- vim.keymap.set({ 'n', 'x' }, '<c-a-k>', function() require('multicursor-nvim').lineAddCursor(-1) end)
    -- vim.keymap.set({ 'n', 'x' }, '<s-a-j>', function() require('multicursor-nvim').lineSkipCursor(1) end)
    -- vim.keymap.set({ 'n', 'x' }, '<s-a-k>', function() require('multicursor-nvim').lineSkipCursor(-1) end)

    -- You can also add cursors with any motion you prefer:
    -- set("n", "<right>", function()
    --     mc.addCursor("w")
    -- end)
    -- set("n", "<a-x>", function()
    --     mc.skipCursor("w")
    -- end)

    -- Rotate the main cursor.
    -- vim.keymap.set({ 'n', 'x' }, '<left>', require('multicursor-nvim').nextCursor)
    -- vim.keymap.set({ 'n', 'x' }, '<right>', require('multicursor-nvim').prevCursor)

    -- Delete the main cursor.
    -- vim.keymap.set({ 'n', 'x' }, '<a-x>', require('multicursor-nvim').deleteCursor)

    -- Add and remove cursors with control + left click.
    -- vim.keymap.set('n', '<c-leftmouse>', require('multicursor-nvim').handleMouse)
    --
    -- Easy way to add and remove cursors using the main cursor.
    -- vim.keymap.set({ 'n', 'x' }, '<c-q>', function()
    --   if require('multicursor-nvim').hasCursors() then
    --     require('multicursor-nvim').toggleCursor()
    --   end
    -- end)

    -- Clone every cursor and disable the originals.
    -- vim.keymap.set({ 'n', 'x' }, '<c-a-q>', require('multicursor-nvim').duplicateCursors)

    vim.keymap.set('n', '<esc>', function()
      if not require('multicursor-nvim').cursorsEnabled() then require('multicursor-nvim').enableCursors() elseif require('multicursor-nvim').hasCursors() then
        require('multicursor-nvim').clearCursors()
      else
        -- Default <esc> handler.
      end
    end)

    -- Maybe in insert mode?
    -- vim.keymap.set('n', '<c-c>', function()
    --   if require('multicursor-nvim').hasCursors() then
    --     require('multicursor-nvim').clearCursors()
    --   else
    --     -- Default <esc> handler.
    --   end
    -- end)

    -- bring back cursors if you accidentally clear them
    -- vim.keymap.set('n', '<a-v>', require('multicursor-nvim').restoreCursors)

    -- Align cursor columns.
    -- vim.keymap.set('n', '<a-a>', require('multicursor-nvim').alignCursors)


    -- Append/insert for each line of visual selections.
    -- vim.keymap.set('x', 'I', require('multicursor-nvim').insertVisual)
    -- vim.keymap.set('x', 'A', require('multicursor-nvim').appendVisual)


    -- Rotate visual selection contents.
    -- which means the text within each visual selection will be rotated between cursors.
    -- vim.keymap.set('x', '<a-t>', function() require('multicursor-nvim').transposeCursors(1) end)
    -- vim.keymap.set('x', '<a-s-t>', function() require('multicursor-nvim').transposeCursors(-1) end)

    -- Jumplist support
    -- vim.keymap.set({ 'x', 'n' }, '<c-i>', require('multicursor-nvim').jumpForward)
    -- vim.keymap.set({ 'x', 'n' }, '<c-o>', require('multicursor-nvim').jumpBackward)


    -- vim.keymap.set({ 'x', 'n' }, "ga", require('multicursor-nvim').addCursorOperator)
    -- cursor to visual???
    -- vim.keymap.set("x", "<leader><esc>", require('multicursor-nvim').visualToCursors)

    -- Customize how cursors look.
    vim.api.nvim_set_hl(0, 'MultiCursorCursor', { link = 'Cursor' })
    vim.api.nvim_set_hl(0, 'MultiCursorVisual', { link = 'Visual' })
    vim.api.nvim_set_hl(0, 'MultiCursorSign', { link = 'SignColumn' })
    vim.api.nvim_set_hl(0, 'MultiCursorDisabledCursor', { link = 'Visual' })
    vim.api.nvim_set_hl(0, 'MultiCursorDisabledVisual', { link = 'Visual' })
    vim.api.nvim_set_hl(0, 'MultiCursorDisabledSign', { link = 'SignColumn' })
  end,
}
-- magari crea<space><space> mapping pure qui?

-- https://github.com/junegunn/dotfiles/blob/master/vimrc
-- nmap  cp vip<Plug>(VM-Visual-Cursors)I
-- nmap  cP vip<Plug>(VM-Visual-Cursors)A
-- would be way cooler if it selected based on indentation... (count to go back one level of indentation)
-- nmap <silent> <leader>I ^vip<C-V>I
-- nmap <silent> <leader>A ^vip<C-V>$A
-- nmap <silent> <leader>E Evip<C-V>$A
-- nmap <silent> <leader>gI W<C-V>}I
-- nmap <silent> <leader>gA <C-V>}$A

