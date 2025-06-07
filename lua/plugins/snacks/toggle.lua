        -- ╭─────────────────────────────────────────────────────────╮
        -- │                       unimpaired                        │
        -- ╰─────────────────────────────────────────────────────────╯
        -- use <s-space> to toggle, like for linux sof
        -- no which key for modifiers sadly...
return {
  'snacks.nvim',
  opts = {
    toggle = {},
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()

        -- basically unbounded vim/emacs keymaps could become kanata's modifiers
        -- what about visual mode? just operate on that region
        Snacks.toggle.animate():map("<f13>a", { mode = {"n","i"} })
        Snacks.toggle.line_number():map("<f13>n", { mode = {"n","i"} })
        -- maybe use uppercase for lsp-related toggle mappings?
        -- Snacks.toggle.diagnostics():map([[\D]], { mode = {"n","i"} })
        Snacks.toggle.diagnostics():map("<f13>d", { mode = {"n","i"} })
        -- Snacks.toggle.treesitter():map([[\T]], { mode = {"n","i"} })
        Snacks.toggle.treesitter():map("<f13>t", { mode = {"n","i"} })
        -- H?
        Snacks.toggle.inlay_hints():map("<f13>h", { mode = {"n","i"} })
        -- Snacks.toggle.scroll():map("<f13>j", { mode = {"n","i"} })
        Snacks.toggle.indent():map("<f13>i", { mode = {"n","i"} })
        Snacks.toggle.dim():map("<f13>D", { mode = {"n","i"} })
        Snacks.toggle.zoom():map("<f13>o", { mode = {"n","i"} }) -- like ^wo vim mapping
        Snacks.toggle.zen():map("<f13>z", { mode = {"n","i"} })
        Snacks.toggle.words():map("<f13>R", { mode = {"n","i"} })
        -- ╭─────────────────────────────────────────────────────────╮
        -- │ options                                                 │
        -- ╰─────────────────────────────────────────────────────────╯
        Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<f13>b", { mode = {"n","i"} })
        Snacks.toggle.option("cursorline", {}):map("<f13>c", { mode = {"n","i"} })
        -- *[od*	*]od*	*yod*	'diff' (actually |:diffthis| / |:diffoff|)
        -- Snacks.toggle.option("diff", {}):map("<f13>d", { mode = {"n","i"} })
        -- Snacks.toggle.option("hlsearch", {}):map("<f13>d", { mode = {"n","i"} })
        -- Snacks.toggle.option("ignorecase", {}):map("<f13>i", { mode = {"n","i"} })
        Snacks.toggle.option("list", { name = "List" }):map("<f13>l", { mode = {"n","i"} })
        -- Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<f13>r", { mode = {"n","i"} })
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<f13>s", {mode={"n","i"}})
        -- Snacks.toggle.option("colorcolumn", { name = "Spelling" }):map("<f13>s", {mode={"n","i"}})
        -- Snacks.toggle.option("cursorcolumn", { name = "Spelling" }):map("<f13>s", {mode={"n","i"}})
        -- TODO:  Fixa
        Snacks.toggle.option("virtualedit", { name = "Virtualedit" }):map("<f13>v", { mode = {"n","i"} })
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<f13>w", { mode = {"n","i"} })
        -- Snacks.toggle.option("cursorline cursorcolumn", { name = "Crosshairs" }):map("<f13>x", {mode={"n","i"}})

        Snacks.toggle.option("modifiable", { name = "Modifiable" }):map("<f13>m", { mode = {"n","i"} })
        -- like emacs c-x c-q
        Snacks.toggle.option("readonly", { name = "Readonly" }):map("<f12><c-q>", { mode = {"n","i"} })
        -- yoL?
        -- yoc?
        Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<f13>e", { mode = {"n","i"} })
        -- yol?
      end,
    })
  end
}

-- Disable continuation of comments to the next line in Vim
-- f -> formatoptions
-- nnoremap yof :set formatoptions-=cro<cr>
-- nnoremap yoN :set relativenumber!<CR>:set number!<CR>.
--
-- Zen : goyo + limelight + salvation
-- nmap coz colcog:colo salvation<cr>


