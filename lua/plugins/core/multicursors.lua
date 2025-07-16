return {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    keys = {
        -- Add or skip cursor above/below the main cursor.
        {mode={"n", "x"}, "<c-j>", function() require("multicursor-nvim").lineAddCursor(1) end},
        {mode={"n", "x"}, "<c-k>", function() require("multicursor-nvim").lineAddCursor(-1) end},

        {mode={"n", "x"}, "<c-n>", function() require("multicursor-nvim").matchAddCursor(1) end},
        {mode={"n", "x"}, "<c-s-n>", function() require("multicursor-nvim").matchAddCursor(-1) end},

        -- Add a cursor to every search result in the buffer.
        { "<A-/>", function() require("multicursor-nvim").searchAllAddCursors() end},
        --
        -- Add a cursor for all matches of cursor word/selection in the document.
        {mode={"n", "x"}, "<a-n>", function() require("multicursor-nvim").matchAllAddCursors() end },


        -- Pressing `cmiwap` will create a cursor in every match of the
        -- string captured by `iw` inside range `ap`.
        -- This action is highly customizable, see `:h multicursor-operator`.
        {mode={"n", "x"}, "cm", function() require("multicursor-nvim").operator() end},

        -- Pressing `c<cr>ip` will add a cursor on each line of a paragraph.
        -- cr->(new)line
        { "c<cr>", function() require("multicursor-nvim").addCursorOperator()end},

        -- Split visual selections by regex.
        {mode="x", "<a-s>", function() require("multicursor-nvim").splitCursors() end},

        -- match new cursors within visual selections by regex.
        {mode="x", "<a-m>", function() require("multicursor-nvim").matchCursors() end},


    },
    config = function()
        local mc = require("multicursor-nvim")
        mc.setup()

        vim.keymap.set({"n", "x"}, "<leader><up>", function() mc.lineSkipCursor(-1) end)
        vim.keymap.set({"n", "x"}, "<leader><down>", function() mc.lineSkipCursor(1) end)

        -- Disable and enable cursors.
        vim.keymap.set({"n", "x"}, "<c-q>", mc.toggleCursor)

        -- bring back cursors if you accidentally clear them
        vim.keymap.set("n", "<a-g><a-v>", mc.restoreCursors)

        -- Rotate the text contained in each visual selection between cursors.
        -- v:count?
        vim.keymap.set("x", "<a-t>", function() mc.transposeCursors(1) end)
        vim.keymap.set("x", "<a-s-T>", function() mc.transposeCursors(-1) end)

        -- Mappings defined in a keymap layer only apply when there are
        -- multiple cursors. This lets you have overlapping mappings.
        mc.addKeymapLayer(function(layerSet)

            -- they support v:count
            layerSet({"n", "x"}, "n", function() require("multicursor-nvim").matchAddCursor(1) end)
            layerSet({"n", "x"}, "N", function() require("multicursor-nvim").matchAddCursor(-1) end)

            -- Add or skip adding a new cursor by matching word/selection
            layerSet({"n", "x"}, "q", function() mc.matchSkipCursor(1) end)
            layerSet({"n", "x"}, "Q", function() mc.matchSkipCursor(-1) end)

            -- Clone every cursor and disable the originals.
            layerSet({"n", "x"}, "<a-w>", mc.duplicateCursors)



            -- -- Select a different cursor as the main one.
            -- layerSet({"n", "x"}, "<left>", mc.prevCursor)
            -- layerSet({"n", "x"}, "<right>", mc.nextCursor)
            --
            -- -- Delete the main cursor.
            -- layerSet({"n", "x"}, "<leader>x", mc.deleteCursor)

            -- Enable and clear cursors using escape.
            -- c-g?
            layerSet("n", "<esc>", function()
                if not mc.cursorsEnabled() then
                    mc.enableCursors()
                else
                    mc.clearCursors()
                end
            end)

            -- Append/insert for each line of visual selections.
            -- Similar to block selection insertion.
            layerSet("x", "I", mc.insertVisual)
            layerSet("x", "A", mc.appendVisual)


            -- Increment/decrement sequences, treaing all cursors as one sequence.
            layerSet({"n", "x"}, "g<c-a>", mc.sequenceIncrement)
            layerSet({"n", "x"}, "g<c-x>", mc.sequenceDecrement)

            -- Align cursor columns.
            layerSet("n", "<a-a>", mc.alignCursors)

        end)

        -- Customize how cursors look.
        local hl = vim.api.nvim_set_hl
        hl(0, "MultiCursorCursor", { reverse = true })
        hl(0, "MultiCursorVisual", { link = "Visual" })
        hl(0, "MultiCursorSign", { link = "SignColumn"})
        hl(0, "MultiCursorMatchPreview", { link = "Search" })
        hl(0, "MultiCursorDisabledCursor", { reverse = true })
        hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
        hl(0, "MultiCursorDisabledSign", { link = "SignColumn"})
    end
}
